using C5_PJ_Restaurante_API.Models;

namespace C5_PJ_Restaurante_API.Business
{
    public interface IUsuario
    {
        IEnumerable<tb_usuario> Get();
        tb_usuario Login(tb_usuario usuario);
        string Add(tb_usuario usuario);
        string Update(tb_usuario usuario);
        string UpdatePass(tb_usuario usuario);
        string Delete(int id);
    }
}
