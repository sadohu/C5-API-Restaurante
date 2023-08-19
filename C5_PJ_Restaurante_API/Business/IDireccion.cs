using C5_PJ_Restaurante_API.Models;

namespace C5_PJ_Restaurante_API.Business
{
    public interface IDireccion
    {
        IEnumerable<tb_direntrega_usuario> Get(int id);
        string Add(tb_direntrega_usuario direccion);
        string Update(tb_direntrega_usuario direccion);
        string Delete(int id);
    }
}
