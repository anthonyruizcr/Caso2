using Microsoft.Extensions.Configuration;
using System.Net.Http;
using Web_Caso2.Entities;
using Web_Caso2.Services;

namespace Web_Caso2.Models
{
    public class CasasModel(HttpClient _httpClient, IConfiguration _configuration) : ICasasModel
    {
        public CasaRespuesta? ConsultarCasas()
        {
            string url = _configuration.GetSection("settings:UrlWebApi").Value + "api/Casa/Consulta";

            var resp = _httpClient.GetAsync(url).Result;

            if (resp.IsSuccessStatusCode)
                return resp.Content.ReadFromJsonAsync<CasaRespuesta>().Result;

            return null;
        }
    }
}
