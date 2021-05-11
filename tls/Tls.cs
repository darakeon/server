using System;
using System.Diagnostics;
using System.IO;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Extensions;

namespace TLS
{
	public class Tls
	{
		public static void Https(IApplicationBuilder app)
		{
			app.Use(async (context, next) =>
			{
				var request = context.Request;

				var tls = new Tls(request);

				var redirect = await tls.genCertAndCheckRedirect();

				if (redirect)
				{
					var url = request
						.GetDisplayUrl()
						.Insert(4, "s");

					context.Response.Redirect(url, false);
				}
				else
				{
					await next();
				}
			});
		}

		private Tls(HttpRequest request)
		{
			domain = request.Host.Host;

			issuedPath = $"/etc/letsencrypt/{domain}.issued";

			process = new Process
			{
				StartInfo = new ProcessStartInfo
				{
					FileName = "certbot",
					Arguments = $"--nginx -n --agree-tos -d {domain} -m your-mail",
					RedirectStandardOutput = true,
					RedirectStandardError = true,
					UseShellExecute = false,
					CreateNoWindow = true,
				}
			};
		}

		private readonly String domain;
		private readonly String issuedPath;
		private readonly Process process;

		private async Task<Boolean> genCertAndCheckRedirect()
		{
			if (!acceptableDomain())
			{
				Console.WriteLine($"Host [{domain}] cannot be validated for certificate");
				return false;
			}

			var issued = await testIssued();
			if (issued.HasValue)
				return issued.Value;

			await recordIssued(false);

			var started = process.Start();

			Console.WriteLine(await File.ReadAllTextAsync("/etc/nginx/conf.d/default.conf"));

			if (!started)
			{
				Console.WriteLine($"Certbot could not be started (code {process.ExitCode})");
				return false;
			}

			Console.WriteLine(await File.ReadAllTextAsync("/etc/nginx/conf.d/default.conf"));

			await process.WaitForExitAsync();
			var isOk = process.ExitCode == 0;

			Console.WriteLine(await File.ReadAllTextAsync("/etc/nginx/conf.d/default.conf"));

			var result = isOk
				? process.StandardOutput
				: process.StandardError;

			Console.WriteLine(await result.ReadToEndAsync());

			if (isOk)
				await recordIssued(true);

			return isOk;
		}

		private Boolean acceptableDomain()
		{
			return domain != "localhost"
				&& !Regex.IsMatch(domain, @"\d+\.\d+\.\d+\.\d+");
		}

		private async Task<Boolean?> testIssued()
		{
			var issuedFile = new FileInfo(issuedPath);

			Console.WriteLine($"File '{issuedFile.FullName}' exists: {issuedFile.Exists}");

			if (!issuedFile.Exists)
				return null;

			var issuedContent = await File.ReadAllTextAsync(issuedPath);
			var issued = Boolean.Parse(issuedContent);

			var checkDays = issued ? 60 : 5;
			var validUntil = issuedFile.LastWriteTime.AddDays(checkDays);
			var stillValid = validUntil > DateTime.Now;

			Console.WriteLine($"Issued: {issued}");
			Console.WriteLine($"Validity: {validUntil}");
			Console.WriteLine($"Valid: {stillValid}");

			return stillValid ? issued : null;
		}

		private async Task recordIssued(Boolean state)
		{
			await File.WriteAllTextAsync(issuedPath, state.ToString());
		}
	}
}
