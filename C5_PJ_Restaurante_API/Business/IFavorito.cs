using C5_PJ_Restaurante_API.Models;

namespace C5_PJ_Restaurante_API.Business
{
    public interface IFavorito
    {
        IEnumerable<tb_favorito> Get(int id);
        string Add(tb_favorito favorito);
        string Delete(tb_favorito favorito);
    }
}
