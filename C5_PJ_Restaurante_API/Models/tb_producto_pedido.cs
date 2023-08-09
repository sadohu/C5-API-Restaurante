namespace C5_PJ_Restaurante_API.Models
{
    public class tb_producto_pedido
    {
        public int id_producto_pedido { get; set; }
        public int id_pedido { get; set; }
        public int id_producto { get; set; }
        public int cantidad_producto { get; set; }
    }
}
