using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class DistritoRepository : IDistrito
    {
        private string connectionString;

        public DistritoRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<tb_distrito> Get()
        {
            List<tb_distrito> lista = new();
            using (SqlConnection cn = new(connectionString))
            {
                SqlCommand cmd = new("SP_GETDISTRITO", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cn.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new tb_distrito()
                    {
                        id_distrito = dr.GetInt32(0),
                        des_distrito = dr.GetString(1)
                    });
                }
                cn.Close();
            }
            return lista;
        }
    }
}
