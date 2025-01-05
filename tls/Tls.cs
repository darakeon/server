using System;
using System.Diagnostics;
using System.IO;
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
			var domain = request.Host.Host;

			issuedPath = $"/etc/letsencrypt/{domain}.issued";

			var email =
				Environment.GetEnvironmentVariable("CERTBOT_EMAIL");

			process = new Process
			{
				StartInfo = new ProcessStartInfo
				{
					FileName = "certbot",
					Arguments = $"--nginx -n --agree-tos -d {domain} -m {email}",
					RedirectStandardOutput = true,
					RedirectStandardError = true,
					UseShellExecute = false,
					CreateNoWindow = true,
				}
			};
		}

		private readonly String issuedPath;
		private readonly Process process;

		private async Task<Boolean> genCertAndCheckRedirect()
		{
			var issued = await testIssued();
			if (issued.HasValue)
				return issued.Value;

			await recordIssued(false);

			var started = process.Start();

			await logConfigs();

			if (!started)
			{
				Console.WriteLine($"Certbot could not be started (code {process.ExitCode})");
				return false;
			}

			await logConfigs();

			await process.WaitForExitAsync();
			var isOk = process.ExitCode == 0;

			await logConfigs();

			var result = isOk
				? process.StandardOutput
				: process.StandardError;

			Console.WriteLine(await result.ReadToEndAsync());

			if (isOk)
				await recordIssued(true);

			return isOk;
		}

		private static async Task logConfigs()
		{
			var configs =
				Directory.GetFiles("/etc/nginx/conf.d", "*.conf");

			foreach (var config in configs)
			{
				Console.WriteLine(await File.ReadAllTextAsync(config));
			}
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
