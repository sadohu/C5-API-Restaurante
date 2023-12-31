﻿using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TarjetaController : Controller
    {
        private ITarjeta iTarjeta;

        public TarjetaController()
        {
            iTarjeta = new TarjetaRepository();
        }

        [HttpGet("getTarjeta")]
        public async Task<ActionResult<IEnumerable<tb_tarjeta>>> Listar(int id_usuario)
        {
            return Ok(await Task.Run(() => iTarjeta.Get(id_usuario)));
        }

        [HttpPost("saveTarjeta")]
        public async Task<ActionResult<string>> Agregar(tb_tarjeta tarjeta)
        {
            return Ok(await Task.Run(() => iTarjeta.Add(tarjeta)));
        }

        [HttpPut("updateTarjeta")]
        public async Task<ActionResult<string>> actualizarProducto(tb_tarjeta tarjeta)
        {
            return Ok(await Task.Run(() => iTarjeta.Update(tarjeta)));
        }

        [HttpPut("deleteTarjeta")]
        public async Task<ActionResult<string>> eliminarProducto(tb_tarjeta tarjeta) { 
            return Ok(await Task.Run(() => iTarjeta.Delete(tarjeta)));
        }
    }
}
