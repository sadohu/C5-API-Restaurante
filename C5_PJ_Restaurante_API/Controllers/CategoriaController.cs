using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriaController : Controller
    {
        private ICategoria iCategoria;

        public CategoriaController()
        {
            iCategoria = new CategoriaRepository();
        }

        [HttpGet("getCategoria")]
        public async Task<ActionResult<IEnumerable<tb_categoria_producto>>> Listar()
        {
            return Ok(await Task.Run(() => iCategoria.GetCategoriaProductos()));
        }

        [HttpPost("saveCategoria")]
        public async Task<ActionResult<string>> Agregar(tb_categoria_producto categoria)
        {
            return Ok(await Task.Run(() => iCategoria.Add(categoria)));
        }

        [HttpPut("updateCategoria")]
        public async Task<ActionResult<string>> actualizarProducto(tb_categoria_producto categoria)
        {
            return Ok(await Task.Run(() => iCategoria.Update(categoria)));
        }

        [HttpPut("deleteCategoria")]
        public async Task<ActionResult<string>> eliminarProducto(int id)
        {
            return Ok(await Task.Run(() => iCategoria.Delete(id)));
        }
    }
}
