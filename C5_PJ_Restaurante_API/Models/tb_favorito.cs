namespace C5_PJ_Restaurante_API.Models
{
    public class tb_favorito
    {
        public int id_favorito { get; set; }
        public int id_usuario { get; set; }
        public int id_producto { get; set; }
        public tb_producto? producto { get; set; }
    }
}
