using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoController : Controller
    {
        private IProducto iProducto;

        public ProductoController()
        {
            iProducto = new ProductoRepository();
        }

        [HttpGet("getProductos")]
        public async Task<ActionResult<IEnumerable<tb_producto>>> mproductos()
        {
            return Ok(await Task.Run(() => iProducto.GetProductos()));
        }

        [HttpGet("getProductosbyid")]
        public async Task<ActionResult<IEnumerable<tb_producto>>> mproductos(int id)
        {
            return Ok(await Task.Run(() => iProducto.GetProductos().Where(item => item.id_producto == id).FirstOrDefault()));
        }

        [HttpPost("agregarProductos")]
        public async Task<ActionResult<string>> agregarProducto(tb_producto reg)
        {
            return Ok(await Task.Run(() => iProducto.Agregar(reg)));
        }

        [HttpPut("actualizarProductos")]
        public async Task<ActionResult<string>> actualizarProducto(tb_producto reg)
        {
            return Ok(await Task.Run(() => iProducto.Actualizar(reg)));
        }

        [HttpPut("eliminarProductos")]
        public async Task<ActionResult<string>> eliminarProducto(int idproducto)
        {
            return Ok(await Task.Run(() => iProducto.Eliminar(idproducto)));
        }

        [HttpGet("getProductosPortal")]
        public async Task<ActionResult<IEnumerable<tb_producto>>> getProductoPortal()
        {
            return Ok(await Task.Run(() => iProducto.GetProductoPortal()));
        }

        [HttpGet("getProductosbyid")]
        public async Task<ActionResult<IEnumerable<tb_producto>>> getProductoByCategoria(int id_categoria_producto)
        {
            return Ok(await Task.Run(() => iProducto.GetProductoByCategoria(id_categoria_producto)));
        }

        [HttpGet("getProductosbyid")]
        public async Task<ActionResult<IEnumerable<tb_producto>>> getProductoByNombre(string nombre)
        {
            return Ok(await Task.Run(() => iProducto.GetProductoByNombre(nombre)));
        }
    }
}
