using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class UsuarioRepository : IUsuario
    {
        private string connectionString;

        public UsuarioRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<tb_usuario> Get()
        {
            List<tb_usuario> list = new();
            using(SqlConnection cnx = new(connectionString))
            {
                SqlCommand cmd = new("SP_LISTARUSUARIO", cnx)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cnx.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    list.Add(new()
                    {
                        id_usuario = (Int32)dr["id_usuario"],
                        id_tipo_usuario = (Int32)dr["id_tipo_usuario"],
                        nom_usuario = (string)dr["nom_usuario"],
                        ape_usuario = (string)dr["ape_usuario"],
                        cel_usuario = (string)dr["cel_usuario"],
                        //id_distrito = (Int32)dr["id_distrito"],
                        email_usuario = (string)dr["email_usuario"],
                        password_usuario = (string)dr["password_usuario"]
                    });
                }
                cnx.Close();
            }
            return list;
        }

        public tb_usuario Login(tb_usuario usuario)
        {
            tb_usuario user = new();
            using (SqlConnection cnx = new(connectionString))
            {
                SqlCommand cmd = new("SP_LOGINUSUARIO", cnx)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@USER", usuario.email_usuario);
                cmd.Parameters.AddWithValue("@PASS", usuario.password_usuario);
                cnx.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    user = new()
                    {
                        id_usuario = (Int32)dr["id_usuario"],
                        id_tipo_usuario = (Int32)dr["id_tipo_usuario"],
                        nom_usuario = (string)dr["nom_usuario"],
                        ape_usuario = (string)dr["ape_usuario"],
                        cel_usuario = (string)dr["cel_usuario"],
                        //id_distrito = (Int32)dr["id_distrito"],
                        email_usuario = (string)dr["email_usuario"],
                        password_usuario = (string)dr["password_usuario"]
                    };
                }
                cnx.Close();
            }
            return user;
        }

        public string Add(tb_usuario usuario)
        {
            string response = "";
            using (SqlConnection cnx = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_INSERTUSUARIO", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@NOMBRE", usuario.nom_usuario);
                    cmd.Parameters.AddWithValue("@APELLIDOS", usuario.ape_usuario);
                    cmd.Parameters.AddWithValue("@TELEFONO", usuario.cel_usuario);
                    cmd.Parameters.AddWithValue("@EMAIL", usuario.email_usuario);
                    cmd.Parameters.AddWithValue("@PASS", usuario.password_usuario);
                    cnx.Open();
                    cmd.ExecuteNonQuery();
                    response = $"Se registró al usuario exitosamente";
                }
                catch (SqlException ex)
                {
                    response = ex.Message;
                    cnx.Close();
                }
                finally {
                    cnx.Close();
                }
            }
            return response;
        }

        public string Update(tb_usuario usuario)
        {
            string response = "";
            using (SqlConnection cnx = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_UPDATEUSUARIO", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID", usuario.id_usuario);
                    cmd.Parameters.AddWithValue("@NOMBRE", usuario.nom_usuario);
                    cmd.Parameters.AddWithValue("@APELLIDOS", usuario.ape_usuario);
                    cmd.Parameters.AddWithValue("@TELEFONO", usuario.cel_usuario);
                    cmd.Parameters.AddWithValue("@EMAIL", usuario.email_usuario);
                    cmd.Parameters.AddWithValue("@PASS", usuario.password_usuario);
                    cnx.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se actualizó al usuario exitosamente.";
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

        public string UpdatePass(tb_usuario usuario)
        {
            string response = "";
            using (SqlConnection cnx = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_UPDATEUSUARIOPASS", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID", usuario.id_usuario);
                    cmd.Parameters.AddWithValue("@PASS", usuario.password_usuario);
                    cnx.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se actualizó la contraseña exitosamente.";
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

        public string Delete(int id)
        {
            string response = "";
            using (SqlConnection cnx = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_DELETEUSUARIO", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ID", id);
                    cnx.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se elíminó al usuario exitosamente.";
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

        public string Valid(tb_usuario usuario)
        {
            string response = "Valid";
            using (SqlConnection cnx = new(connectionString))
            {
                cnx.Open();
                SqlCommand cmd = new("SP_GETUSUARIOEMAIL", cnx)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@USER", usuario.email_usuario);
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    tb_usuario temp = new()
                    {
                        id_usuario = dr.GetInt32(0)
                    };
                    if(usuario.id_usuario !=  temp.id_usuario)
                    {
                        dr.Close();
                        cnx.Close();
                        return response = "Email registrado, por favor use uno distinto.";
                    }
                }
                dr.Close();
                SqlCommand cmd2 = new("SP_GETUSUARIOPHONE", cnx)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd2.Parameters.AddWithValue("@USER", usuario.cel_usuario);
                var dr2 = cmd2.ExecuteReader();
                while (dr2.Read())
                {
                    tb_usuario temp = new()
                    {
                        id_usuario = dr2.GetInt32(0)
                    };
                    if (usuario.id_usuario != temp.id_usuario)
                    {
                        dr2.Close();
                        cnx.Close();
                        return response = "Celular registrado, por favor use uno distinto.";
                    }
                }
                dr2.Close();
                cnx.Close();
            }
            return response;
        }
    }
}
