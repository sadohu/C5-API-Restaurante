namespace C5_PJ_Restaurante_API.Models
{
    public class tb_direntrega_usuario
    {
        public int id_direntrega { get; set; }
        public int id_usuario { get; set; }
        public int id_distrito { get; set; }
        public string? nombre_direntrega { get; set; }
        public string? des_direntrega { get; set; }
        public string? detalle_direntrega { get; set; }
    }
}
