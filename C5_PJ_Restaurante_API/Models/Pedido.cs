namespace C5_PJ_Restaurante_API.Models
{
    public class Pedido
    {
        public int id_pedido { get; set; }
        public int id_usuario_cliente { get; set; }
        public int id_dirEntrega { get; set; }
        public int id_tarjeta { get; set; }
        public int id_medio_pago { get; set; }
        public decimal monto_compra { get; set; }
        public List<Cart>? carts { get; set; }
    }
}
