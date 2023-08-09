namespace C5_PJ_Restaurante_API.Models
{
    public class tb_pedido
    {
        public int id_pedido { get; set; }
        public int id_usuario_cliente { get; set; }
        public int id_direntrega { get; set; }
        public int id_colaborador_repartidor { get; set; }
        public string? tiempoentrega_pedido { get; set; }
        public string? estado_pedido { get; set; }
    }
}
