using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class FavoritoRepository : IFavorito
    {
        private string connectionString;

        public FavoritoRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<tb_favorito> Get(int id)
        {
            List<tb_favorito> list = new();
            using (SqlConnection cnx = new(connectionString))
            {
                SqlCommand cmd = new("SP_GETFAVORITO", cnx)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@ID", id);
                cnx.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    list.Add(new()
                    {
                        id_favorito = dr.GetInt32(0),
                        id_usuario = dr.GetInt32(1),
                        id_producto = dr.GetInt32(2),
                    });
                }
                dr.Close();

                foreach(var item in list)
                {
                    SqlCommand cmd2 = new("SP_LISTARPRODUCTOBYID", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd2.Parameters.AddWithValue("@ID", item.id_producto);
                    var dr2 = cmd2.ExecuteReader();
                    while (dr2.Read())
                    {
                        item.producto = new()
                        {
                            id_producto = dr2.GetInt32(0),
                            id_categoria_producto = dr2.GetInt32(1),
                            nom_producto = dr2.GetString(2),
                            des_producto = dr2.GetString(3),
                            preciouni_producto = dr2.GetDecimal(4),
                            stock_producto = dr2.GetInt32(5),
                            imagen_producto = dr2.GetString(6)
                        };
                    }
                    dr2.Close();
                }
                cnx.Close();
            }
            return list;
        }

        public string Add(tb_favorito favorito)
        {
            string response = "El producto ya se encuentra como favorito";
            using (SqlConnection cnx = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_GETFAVORITOVALID", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@USUARIO", favorito.id_usuario);
                    cmd.Parameters.AddWithValue("@PRODUCTO", favorito.id_producto);
                    cnx.Open();
                    var dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        return response;
                    }
                    dr.Close();
                    cnx.Close();

                    SqlCommand cmd2 = new SqlCommand("SP_INSERTFAVORITO", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd2.Parameters.AddWithValue("@USUARIO", favorito.id_usuario);
                    cmd2.Parameters.AddWithValue("@PRODUCTO", favorito.id_producto);
                    cnx.Open();
                    cmd2.ExecuteNonQuery();
                    response = $"Se registró su favorito exitosamente";
                }
                catch (SqlException ex)
                {
                    response = ex.Message;
                    cnx.Close();
                }
                finally
                {
                    cnx.Close();
                }
            }
            return response;
        }

        public string Delete(tb_favorito favorito)
        {
            string response = "";
            using (SqlConnection cnx = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_DELETEFAVORITO", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID", favorito.id_favorito);
                    cnx.Open();
                    cmd.ExecuteNonQuery();
                    response = $"Se eliminó su favorito exitosamente";
                }
                catch (SqlException ex)
                {
                    response = ex.Message;
                    cnx.Close();
                }
                finally
                {
                    cnx.Close();
                }
            }
            return response;
        }
    }
}
