using Microsoft.AspNetCore.Mvc;
using Web_Caso2.Services;

namespace Web_Caso2.Controllers
{
    public class CasasController(ICasasModel _casasModel) : Controller
    {
        [HttpGet]
        public IActionResult Consulta()
        {
            var resp = _casasModel.ConsultarCasas();

            return View(resp!.datos);
        }
    }
}
