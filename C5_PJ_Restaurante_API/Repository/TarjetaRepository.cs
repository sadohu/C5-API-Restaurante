using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class TarjetaRepository : ITarjeta
    {
        private string connectionString;

        public TarjetaRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<tb_tarjeta> Get(int id)
        {
            List<tb_tarjeta> lista = new();
            using (SqlConnection cn = new(connectionString))
            {
                SqlCommand cmd = new("SP_GETTARJETA", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@ID_USUARIO", id);
                cn.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new tb_tarjeta()
                    {
                        id_tarjeta = dr.GetInt32(0),
                        id_usuario = dr.GetInt32(1),
                        numero_tarjeta = dr.GetString(2),
                        cvv_tarjeta = dr.GetString(3),
                        fecha_tarjeta = dr.GetString(4),
                        nombre_tarjeta = dr.GetString(5),
                    });
                }
                cn.Close();
            }
            return lista;
        }

        public string Add(tb_tarjeta tarjeta)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_INSERTTARJETA", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID_USUARIO", tarjeta.id_usuario);
                    cmd.Parameters.AddWithValue("@NUMERO", tarjeta.numero_tarjeta);
                    cmd.Parameters.AddWithValue("@CVV", tarjeta.cvv_tarjeta);
                    cmd.Parameters.AddWithValue("@FECHA", tarjeta.fecha_tarjeta);
                    cmd.Parameters.AddWithValue("@NOMBRE", tarjeta.nombre_tarjeta);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se registró la tarjeta exitosamente.";
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

        public string Update(tb_tarjeta tarjeta)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_UPDATETARJETA", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID_TARJETA", tarjeta.id_tarjeta);
                    cmd.Parameters.AddWithValue("@NUMERO", tarjeta.numero_tarjeta);
                    cmd.Parameters.AddWithValue("@CVV", tarjeta.cvv_tarjeta);
                    cmd.Parameters.AddWithValue("@FECHA", tarjeta.fecha_tarjeta);
                    cmd.Parameters.AddWithValue("@NOMBRE", tarjeta.nombre_tarjeta);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se actualizó la tarjeta exitosamente.";
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

        public string Delete(tb_tarjeta tarjeta)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_DELETETARJETA", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID_TARJETA", tarjeta.id_tarjeta);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se eliminó la tarjeta exitosamente.";
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
