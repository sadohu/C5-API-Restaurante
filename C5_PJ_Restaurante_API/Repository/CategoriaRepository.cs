using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

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
            List<tb_categoria_producto> lista = new();
            using (SqlConnection cn = new(connectionString))
            {
                cn.Open();
                SqlCommand cmd = new("SP_GETCATEGORIA", cn);
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

        public string Add(tb_categoria_producto categoria)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_INSERTCATEGORIA", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@DESCRIPCION", categoria.des_categoria_producto);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se registró la categoría exitosamente.";
                }
                catch (Exception ex)
                {
                    response = ex.Message;
                    cn.Close();
                }
                finally
                {
                    cn.Close();
                }
            }
            return response;
        }

        public string Update(tb_categoria_producto categoria)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_UPDATECATEGORIA", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID", categoria.id_categoria_producto);
                    cmd.Parameters.AddWithValue("@DESCRIPCION", categoria.des_categoria_producto);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se actualizó la categoría exitosamente.";
                }
                catch (Exception ex)
                {
                    response = ex.Message;
                    cn.Close();
                }
                finally
                {
                    cn.Close();
                }
            }
            return response;
        }

        public string Delete(int id)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_DELETECATEGORIA", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID", id);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se eliminó la categoría exitosamente.";
                }
                catch (Exception ex)
                {
                    response = ex.Message;
                    cn.Close();
                }
                finally
                {
                    cn.Close();
                }
            }
            return response;
        }
    }
}
