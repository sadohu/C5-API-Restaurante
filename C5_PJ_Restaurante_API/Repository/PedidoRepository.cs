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
                try
                {
                    SqlCommand cmd = new("SP_INSERTPEDIDO", cnx)
                    { CommandType = CommandType.StoredProcedure };
                    cmd.Parameters.AddWithValue("@ID_USUARIO_CLIENTE", pedido.id_usuario_cliente);
                    cmd.Parameters.AddWithValue("@ID_DIRENTREGA", pedido.id_dirEntrega);
                    cmd.Parameters.AddWithValue("@ID_TARJETA", pedido.id_tarjeta);
                    cmd.Parameters.AddWithValue("@ID_MEDIO_PAGO", pedido.id_medio_pago);
                    cmd.Parameters.AddWithValue("@MONTO_COMPRA", pedido.monto_compra);
                    cnx.Open();
                    int i = cmd.ExecuteNonQuery();

                    SqlCommand cmd2 = new("SP_INSERTCART", cnx) 
                    { CommandType = CommandType.StoredProcedure };
                    cmd2.Parameters.AddWithValue("@ID_PRODUCTO", pedido.id_usuario_cliente);
                    cmd2.Parameters.AddWithValue("@CANTIDAD_PRODUCTO", pedido.id_dirEntrega);
                    int i2 = cmd2.ExecuteNonQuery();
                    cnx.Close();
                    response = "Registro exitoso";
                }
                catch (Exception ex)
                {
                    response = ex.Message;
                }
            }
            return response;
        }
    }
}
