namespace API_Caso2.Entities
{
    public class Casa
    {
        public long IdCasa { get; set; }
        public string? DescripcionCasa { get; set; }
        public decimal PrecioCasa { get; set; }
        public string? Estado { get; set; }
        public string? UsuarioAlquiler { get; set; }
        public string? FechaAlquiler { get; set; }
    }
    public class CasaRespuesta
    {
        public Casa? data { get; set; }
        public List<Casa>? datos { get; set; }
        public string? Codigo { get; set; }
        public string? Mensaje { get; set; }

    }
}
