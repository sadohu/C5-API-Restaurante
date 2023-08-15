using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DistritoController : Controller
    {
        private IDistrito iDistrito;

        public DistritoController()
        {
            iDistrito = new DistritoRepository();
        }

        [HttpGet("getDistrito")]
        public async Task<ActionResult<IEnumerable<tb_distrito>>> listar()
        {
            return Ok(await Task.Run(() => iDistrito.Get()));
        }
    }
}
