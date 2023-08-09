using C5_PJ_Restaurante_API.Models;

namespace C5_PJ_Restaurante_API.Business
{
    public interface ICategoria
    {
        IEnumerable<tb_categoria_producto> GetCategoriaProductos();
    }
}
