using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class ProductoRepository : IProducto
    {
        private string connectionString;

        public ProductoRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<tb_producto> GetProductos()
        {
            List<tb_producto> lista = new();
            using (SqlConnection cn = new(connectionString))
            {
                SqlCommand cmd = new("SP_LISTARPRODUCTO", cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cn.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new tb_producto()
                    {
                        id_producto = dr.GetInt32(0),
                        id_categoria_producto = dr.GetInt32(1),
                        nom_producto = dr.GetString(2),
                        des_producto = dr.GetString(3),
                        preciouni_producto = dr.GetDecimal(4),
                        stock_producto = dr.GetInt32(5),
                        imagen_producto = dr.GetString(6)
                    });
                }
                cn.Close();
            }
            return lista;
        }

        public string Agregar(tb_producto producto)
        {
            string mensaje = "";
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_INSERTPRODUCTO", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@id_categoria_producto", producto.id_categoria_producto);
                    cmd.Parameters.AddWithValue("@nom_producto", producto.nom_producto);
                    cmd.Parameters.AddWithValue("@des_producto", producto.des_producto);
                    cmd.Parameters.AddWithValue("@preciouni_producto", producto.preciouni_producto);
                    cmd.Parameters.AddWithValue("@stock_producto", producto.stock_producto);
                    int i = cmd.ExecuteNonQuery();
                    mensaje = $"Se ha insertado el registro de nombre {producto.nom_producto}";
                }
                catch (SqlException ex) { mensaje = ex.Message; }
                finally { cn.Close(); }
            }
            return mensaje;
        }

        public string Actualizar(tb_producto producto)
        {
            string mensaje = "";
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("SP_UPDATEPRODUCTO", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@id_producto", producto.id_producto);
                    cmd.Parameters.AddWithValue("@id_categoria_producto", producto.id_categoria_producto);
                    cmd.Parameters.AddWithValue("@nom_producto", producto.nom_producto);
                    cmd.Parameters.AddWithValue("@des_producto", producto.des_producto);
                    cmd.Parameters.AddWithValue("@preciouni_producto", producto.preciouni_producto);
                    cmd.Parameters.AddWithValue("@stock_producto", producto.stock_producto);
                    int i = cmd.ExecuteNonQuery();
                    mensaje = $"Se ha actualizado el registro de: {producto.nom_producto}";
                }
                catch (SqlException ex) { mensaje = ex.Message; }
                finally { cn.Close(); }
            }
            return mensaje;
        }

        public string Eliminar(int idproducto)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    SqlCommand command = new SqlCommand("SP_DELETEPRODUCTO", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_producto", idproducto);
                    connection.Open();
                    int filas = command.ExecuteNonQuery();
                    mensaje = $"Se ha eliminado correctamente.";
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
                finally { connection.Close(); }
            }
            return mensaje;
        }

        public IEnumerable<tb_producto> GetProductoPortal()
        {
            List<tb_producto> portal = new List<tb_producto>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand("usp_listadoEcommer", connection);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    portal.Add(new tb_producto()
                    {
                        id_producto = dr.GetInt32(0),
                        nom_producto = dr.GetString(1),
                        des_producto = dr.GetString(2),
                        des_categoria_producto = dr.GetString(3),
                        preciouni_producto = dr.GetDecimal(4),
                        stock_producto = dr.GetInt32(5)
                    });
                }
                connection.Close();
            }
            return portal;
        }
    }
}
