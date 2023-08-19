using C5_PJ_Restaurante_API.Models;

namespace C5_PJ_Restaurante_API.Business
{
    public interface ITarjeta
    {
        IEnumerable<tb_tarjeta> Get(int id);
        string Add(tb_tarjeta tarjeta);
        string Update(tb_tarjeta tarjeta);
        string Delete(tb_tarjeta tarjeta);
    }
}
