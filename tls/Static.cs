using System;
using System.IO;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.FileProviders;

namespace TLS
{
	static class Static
	{
		public static void Certificate(IApplicationBuilder app)
		{
			addStaticPath(app, ".well-known");
		}

		private static void addStaticPath(IApplicationBuilder app, String folder)
		{
			if (!Directory.Exists(folder))
				return;

			app.UseStaticFiles(new StaticFileOptions
			{
				FileProvider = new PhysicalFileProvider(
					Path.Combine(Directory.GetCurrentDirectory(), folder)),
				RequestPath = "/" + folder,
			});
		}
	}
}
