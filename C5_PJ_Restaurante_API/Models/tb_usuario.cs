namespace C5_PJ_Restaurante_API.Models
{
    public class tb_usuario
    {
        public int id_usuario { get; set; }
        public int id_tipo_usuario { get; set; }
        public string? cod_usuario { get; set; }
        public string? nom_usuario { get; set; }
        public string? ape_usuario { get; set; }
        public string? tel_usuario { get; set; }
        public string? cel_usuario { get; set; }
        public int id_distrito { get; set; }
        public string? dir_usuario { get; set; }
        public string? dni_usuario { get; set; }
        public string? email_usuario { get; set; }
        public string? password_usuario { get; set; }
        public string? imagen_usuario { get; set; }
        public string? estado_usuario { get; set; }
    }
}
