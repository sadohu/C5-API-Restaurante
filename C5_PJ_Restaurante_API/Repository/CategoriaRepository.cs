using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;

namespace C5_PJ_Restaurante_API.Repository
{
    public class CategoriaRepository : ICategoria
    {
        private string connectionString;

        public CategoriaRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }
        public IEnumerable<tb_categoria_producto> GetCategoriaProductos()
        {
            List<tb_categoria_producto> lista = new List<tb_categoria_producto>();
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                // TODO: Implementar StoreProcedure
                SqlCommand cmd = new SqlCommand("select * from tb_categoria_producto", cn);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new tb_categoria_producto()
                    {
                        id_categoria_producto = dr.GetInt32(0),
                        des_categoria_producto = dr.GetString(1)
                    });
                }
                cn.Close();
            }
            return lista;
        }
    }
}
