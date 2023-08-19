using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace C5_PJ_Restaurante_API.Repository
{
    public class PedidoRepository : IPedido
    {
        private string connectionString;

        public PedidoRepository()
        {
            connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public string SavePedido(Pedido pedido)
        {
            string response = "";
            using (SqlConnection cnx = new(connectionString))
            {
                cnx.Open();
                var transaction = cnx.BeginTransaction();
                try
                {
                    string cmdProcedure = pedido.id_dirEntrega == 0 ? "SP_INSERTPEDIDOVS" : "SP_INSERTPEDIDO";
                    // Insertar pedido
                    SqlCommand cmd = new(cmdProcedure, cnx, transaction)
                    { CommandType = CommandType.StoredProcedure };
                    cmd.Parameters.AddWithValue("@ID_USUARIO_CLIENTE", pedido.id_usuario_cliente);
                    if(pedido.id_dirEntrega > 0)
                        cmd.Parameters.AddWithValue("@ID_DIRENTREGA", pedido.id_dirEntrega);

                    cmd.ExecuteNonQuery();

                    // Obtener el último ID de pedido insertado
                    SqlCommand cmd2 = new("SP_GETLASTPEDIDO", cnx, transaction)
                    { CommandType = CommandType.StoredProcedure };
                    cmd2.Parameters.AddWithValue("@id_usuario_cliente", pedido.id_usuario_cliente);
                    var dr2 = cmd2.ExecuteReader();
                    while(dr2.Read())
                    {
                        pedido.id_pedido = dr2.GetInt32(0);
                    }
                    dr2.Close();

                    // Insertar compra
                    string spInsertCompra = pedido.id_tarjeta == 0 ? "SP_INSERTCOMPRAMONEY" : "SP_INSERTCOMPRACARD";
                    SqlCommand cmd3 = new(spInsertCompra, cnx, transaction);
                    cmd3.CommandType = CommandType.StoredProcedure;
                    cmd3.Parameters.AddWithValue("@ID_PEDIDO", pedido.id_pedido);
                    cmd3.Parameters.AddWithValue("@ID_MEDIO_PAGO", pedido.id_medio_pago);
                    cmd3.Parameters.AddWithValue("@MONTO_COMPRA", pedido.monto_compra);
                    if(pedido.id_tarjeta != 0)
                        cmd3.Parameters.AddWithValue("@ID_TARJETA", pedido.id_tarjeta);
                    cmd3.ExecuteNonQuery();

                    // Insertar detalles de los productos
                    if (pedido.carts != null)
                    {
                        foreach (Cart cart in pedido.carts!)
                        {
                            SqlCommand cmd4 = new("SP_INSERTCART", cnx, transaction)
                            { CommandType = CommandType.StoredProcedure };
                            cmd4.Parameters.AddWithValue("@ID_PEDIDO", pedido.id_pedido);
                            cmd4.Parameters.AddWithValue("@ID_PRODUCTO", cart.id_producto);
                            cmd4.Parameters.AddWithValue("@CANTIDAD", cart.cantidad_producto);
                            cmd4.ExecuteNonQuery();
                        }
                    }

					
					foreach (Cart cart in pedido.carts!)
					{
						SqlCommand cmd5 = new("usp_actualiza_stock", cnx, transaction)
						{ CommandType = CommandType.StoredProcedure };
						cmd5.Parameters.AddWithValue("@idproducto", cart.id_producto);
						cmd5.Parameters.AddWithValue("@cant", cart.cantidad_producto);
						cmd5.ExecuteNonQuery();
					}

					transaction.Commit();
                    response = "Registro exitoso";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    cnx.Close();
                    response = ex.Message;
                }
                finally
                {
                    cnx.Close();
                }
            }
            return response;
        }

        public string Update(tb_pedido pedido)
        {
            string response = "";
            using (SqlConnection cn = new(connectionString))
            {
                try
                {
                    SqlCommand cmd = new("SP_UPDATEPEDIDOESTADO", cn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@ESTADO", pedido.estado_pedido);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    response = "Se actualizó el pedido exitosamente.";
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

        public List<Pedido> GetByUser(int id)
        {
            List<Pedido> list = new();
            using(SqlConnection cnx = new(connectionString))
            {
                SqlCommand cmd = new("SP_GETPEDIDOBYUSER", cnx)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue ("@ID", id);
                cnx.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    list.Add(new()
                    {
                        id_pedido = dr.GetInt32(0),
                        fechaAct_pedido = dr.GetDateTime(1).ToString(),
                        estado_pedido = dr.GetString(2),
                        nombre_direntrega = dr.GetString(3),
                        des_direntrega = dr.GetString(4),
                        des_medio_pago = dr.GetString(5),
                        monto_compra = dr.GetDecimal(6),
                    });
                }
                dr.Close();

                foreach(var item in list)
                {
                    SqlCommand cmd2 = new("SP_GETPEDIDOCART", cnx)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd2.Parameters.AddWithValue("@ID", item.id_pedido);
                    var dr2 = cmd2.ExecuteReader();
                    item.carts = new List<Cart>();
                    while (dr2.Read())
                    {
                        item.carts.Add(new()
                        {
                            id_producto = (Int32)dr2["id_producto"],
                            cantidad_producto = (Int32)dr2["cantidad_producto"]
                        });
                    }
                    dr2.Close();
                }
                cnx.Close();
            }
            return list;
        }
    }
}
