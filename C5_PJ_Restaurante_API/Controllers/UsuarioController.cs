using C5_PJ_Restaurante_API.Business;
using C5_PJ_Restaurante_API.Models;
using C5_PJ_Restaurante_API.Repository;
using Microsoft.AspNetCore.Mvc;

namespace C5_PJ_Restaurante_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : Controller
    {
        private IUsuario iUsuario;
        public UsuarioController()
        {
            iUsuario = new UsuarioRepository();
        }

        [HttpGet("getUsuario")]
        public async Task<ActionResult<IEnumerable<tb_usuario>>> Listar()
        {
            return Ok(await Task.Run(() => iUsuario.Get()));
        }

        [HttpPost("loginUsuario")]
        public async Task<ActionResult<tb_usuario>> Login(tb_usuario usuario)
        {
            return Ok(await Task.Run(() => iUsuario.Login(usuario)));
        }

        [HttpPost("saveUsuario")]
        public async Task<ActionResult<string>> Agregar(tb_usuario usuario)
        {
            return Ok(await Task.Run(() => iUsuario.Add(usuario)));
        }

        [HttpPut("updateUsuario")]
        public async Task<ActionResult<string>> Actualizar(tb_usuario usuario)
        {
            return Ok(await Task.Run(() => iUsuario.Update(usuario)));
        }

        [HttpPut("changePass")]
        public async Task<ActionResult<string>> CambiarPass(tb_usuario usuario)
        {
            return Ok(await Task.Run(() => iUsuario.UpdatePass(usuario)));
        }

        [HttpPut("deleteUsuario")]
        public async Task<ActionResult<string>> Eliminar(int id_usuario)
        {
            return Ok(await Task.Run(() => iUsuario.Delete(id_usuario)));
        }

        [HttpPost("validUsuario")]
        public async Task<ActionResult<string>> Validar(tb_usuario usuario)
        {
            return Ok(await Task.Run(() => iUsuario.Valid(usuario)));
        }
    }
}
