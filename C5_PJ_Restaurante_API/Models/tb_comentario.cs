namespace C5_PJ_Restaurante_API.Models
{
    public class tb_comentario
    {
        public int id_comentario { get; set; }
        public int id_usuario_cliente { get; set; }
        public string? des_comentario { get; set; }
        public decimal cantestrella_comentario { get; set; }
        public string? estado_comentario { get; set; }

    }
}
