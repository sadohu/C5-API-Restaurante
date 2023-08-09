namespace C5_PJ_Restaurante_API.Conecction
{
    public class Conecction
    {
        public string connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
    }
}
