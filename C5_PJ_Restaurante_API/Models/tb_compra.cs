namespace C5_PJ_Restaurante_API.Models
{
    public class tb_compra
    {
        public int id_compra { get; set; }
        public int id_pedido { get; set; }
        public int id_medio_pago { get; set; }
        public int id_tarjeta { get; set; }
        public decimal monto_compra { get; set; }
        public string? fechareg_compra { get; set; }
        public string? estado_compra { get; set; }
    }
}
