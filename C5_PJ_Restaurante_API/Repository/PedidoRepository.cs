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
                    // Insertar pedido
                    SqlCommand cmd = new("SP_INSERTPEDIDO", cnx, transaction)
                    { CommandType = CommandType.StoredProcedure };
                    cmd.Parameters.AddWithValue("@ID_USUARIO_CLIENTE", pedido.id_usuario_cliente);
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
    }
}
