using Microsoft.AspNetCore.Mvc;

namespace TLS.Controllers
{
	public class TlsController : Controller
	{
		public IActionResult Index()
		{
			return Ok();
		}
	}
}
