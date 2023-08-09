namespace C5_PJ_Restaurante_API.Models
{
    public class tb_tarjeta
    {
        public int id_tarjeta { get; set; }
        public int id_usuario { get; set; }
        public string? numero_tarjeta { get; set; }
        public string? cvv_tarjeta { get; set; }
        public string? fecha_tarjeta { get; set; }
        public string? nombre_tarjeta { get; set; }
        public string? fechareg_tarjeta { get; set; }
        public string? estado_tarjeta { get; set; }
    }
}
