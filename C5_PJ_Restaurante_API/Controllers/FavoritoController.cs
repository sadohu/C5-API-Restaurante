using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FavoritoController : Controller
    {
        private IFavorito iFavorito;

        public FavoritoController()
        {
            iFavorito = new FavoritoRepository();
        }

        [HttpGet("getFavorito")]
        public async Task<ActionResult<IEnumerable<tb_favorito>>> listarFavorito(int id_usuario)
        {
            return Ok(await Task.Run(() => iFavorito.Get(id_usuario)));
        }

        [HttpPost("saveFavorito")]
        public async Task<ActionResult<string>> agregarFavorito(tb_favorito favorito)
        {
            return Ok(await Task.Run(() => iFavorito.Add(favorito)));
        }

        [HttpPut("deleteFavorito")]
        public async Task<ActionResult<string>> eliminarFavorito(tb_favorito favorito)
        {
            return Ok(await Task.Run(() => iFavorito.Delete(favorito)));
        }
    }
}
