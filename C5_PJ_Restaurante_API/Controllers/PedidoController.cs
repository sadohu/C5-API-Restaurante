﻿using Microsoft.AspNetCore.Mvc;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Repository;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PedidoController : Controller
    {
        private IPedido iPedido;

        public PedidoController()
        {
            iPedido = new PedidoRepository();
        }

        [HttpPost("SavePedido")]
        public async Task<ActionResult<string>> ApiSavePedido(Pedido pedido)
        {
            return Ok(await Task.Run(() => iPedido.SavePedido(pedido)));
        }

        [HttpPost("updateEstadoPedido")]
        public async Task<ActionResult<string>> Actualizar(tb_pedido pedido)
        {
            return Ok(await Task.Run(() => iPedido.Update(pedido)));
        }
    }
}
