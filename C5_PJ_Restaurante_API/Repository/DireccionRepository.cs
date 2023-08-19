using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class DireccionRepository : IDireccion
    {
        private string connectionString;

        public DireccionRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<tb_direntrega_usuario> Get(int id)
        {
            List<tb_direntrega_usuario> lista = new();
            using (SqlConnection cn = new(connectionString))
            {
                SqlCommand cmd = new("SP_GETDIRECCION", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@ID_USUARIO", id);
                cn.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new tb_direntrega_usuario()
                    {
                        id_usuario = dr.GetInt32(0),
                        id_direntrega = dr.GetInt32(1),
                        //id_distrito = dr.GetInt32(2),
                        nombre_direntrega = dr.GetString(3),
                        des_direntrega = dr.GetString(4),
                        detalle_direntrega = dr.GetString(5)
                    });
                }
                cn.Close();
            }
            return lista;
        }

        public string Add(tb_direntrega_usuario direccion)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_INSERTDIRECCION", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID_USUARIO", direccion.id_usuario);
                    //cmd.Parameters.AddWithValue("@ID_DISTRITO", direccion.id_distrito);
                    cmd.Parameters.AddWithValue("@NOMBRE", direccion.nombre_direntrega);
                    cmd.Parameters.AddWithValue("@DESCRIPCION", direccion.des_direntrega);
                    cmd.Parameters.AddWithValue("@DETALLE", direccion.detalle_direntrega);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se registró la dirección exitosamente.";
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

        public string Update(tb_direntrega_usuario direccion)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_UPDATEDIRECCION", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID_DIRECCION", direccion.id_direntrega);
                    //cmd.Parameters.AddWithValue("@ID_DISTRITO", direccion.id_distrito);
                    cmd.Parameters.AddWithValue("@NOMBRE", direccion.nombre_direntrega);
                    cmd.Parameters.AddWithValue("@DESCRIPCION", direccion.des_direntrega);
                    cmd.Parameters.AddWithValue("@DETALLE", direccion.detalle_direntrega);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se actualizó la dirección exitosamente.";
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
                    SqlCommand cmd = new("SP_DELETEDIRECCION", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID_DIRECCION", id);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se eliminó la dirección exitosamente.";
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
