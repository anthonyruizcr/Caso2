using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using API_Caso2.Entities;
using System.Data;
using System.Data.SqlClient;

namespace API_Caso2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CasaController(IConfiguration _config) : ControllerBase
    {
        [HttpGet]
        [Route("Consulta")]
        public IActionResult ConsultarCasas()
        {
            using (var db = new SqlConnection(_config.GetConnectionString("DefaultConnection")))
            {
                CasaRespuesta answer = new CasaRespuesta();

                var resultado = db.Query<Casa>("SP_CONSULTAR_CASAS", commandType: CommandType.StoredProcedure).ToList();

                if (resultado == null)
                {
                    answer.Mensaje = "No hay casas registradas...";
                    answer.Codigo = "-1";

                }
                else
                {
                    answer.datos = resultado;
                }

                return Ok(answer);
            }
        }

        [HttpPost]
        [Route("Alquilar")]
        public IActionResult AlquilarCasa(Casa entity)
        {
            using (var db = new SqlConnection(_config.GetConnectionString("DefaultConnection")))
            {
                Respuesta answer = new Respuesta();

                var resultado = db.Query<Casa>("SP_ALQUILAR_CASA",
                    new
                    {
                        ID = entity.IdCasa,
                        USER = entity.UsuarioAlquiler
                    }, commandType: System.Data.CommandType.StoredProcedure).FirstOrDefault();

                if (resultado.IdCasa != -1 && resultado != null)
                {
                    answer.Codigo = "1";
                    answer.Mensaje = "Alquiler registrado exitosamente.";
                }
                else
                {
                    answer.Codigo = "-1";
                    answer.Mensaje = "Error al alquilar la casa..";
                }
                return Ok(answer);
            }
        }
    }
}
