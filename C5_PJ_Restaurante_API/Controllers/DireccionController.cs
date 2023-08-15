using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DireccionController : Controller
    {
        private IDireccion iDireccion;

        public DireccionController()
        {
            iDireccion = new DireccionRepository();
        }

        [HttpGet("getDireccion")]
        public async Task<ActionResult<IEnumerable<tb_direntrega_usuario>>> Listar(int id_usuario)
        {
            return Ok(await Task.Run(() => iDireccion.Get(id_usuario)));
        }

        [HttpPost("saveDireccion")]
        public async Task<ActionResult<string>> Agregar(tb_direntrega_usuario direccion)
        {
            return Ok(await Task.Run(() => iDireccion.Add(direccion)));
        }

        [HttpPut("updateDireccion")]
        public async Task<ActionResult<string>> actualizarProducto(tb_direntrega_usuario direccion)
        {
            return Ok(await Task.Run(() => iDireccion.Update(direccion)));
        }

        [HttpPut("deleteDireccion")]
        public async Task<ActionResult<string>> eliminarProducto(int id_direccion)
        {
            return Ok(await Task.Run(() => iDireccion.Delete(id_direccion)));
        }
    }
}
