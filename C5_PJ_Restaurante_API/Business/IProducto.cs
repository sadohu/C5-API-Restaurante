using C5_PJ_Restaurante_API.Models;

namespace C5_PJ_Restaurante_API.Business
{
    public interface IProducto
    {
        IEnumerable<tb_producto> GetProductos();
        string Agregar(tb_producto producto);
        string Actualizar(tb_producto producto);
        string Eliminar(int idproducto);
        IEnumerable<tb_producto> GetProductoPortal();
        IEnumerable<tb_producto> GetProductoByCategoria(int id);
        IEnumerable<tb_producto> GetProductoByNombre(string nombre);
    }
}
