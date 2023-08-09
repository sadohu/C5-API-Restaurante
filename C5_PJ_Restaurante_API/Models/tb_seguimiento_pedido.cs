namespace C5_PJ_Restaurante_API.Models
{
    public class tb_seguimiento_pedido
    {
        public int id_seguimiento_pedido { get; set; }
        public int id_pedido { get; set; }
        public string? fechareg_seguimiento_pedido { get; set; }
        public string? estado_seguimmiento_pedido { get; set; }
    }
}
