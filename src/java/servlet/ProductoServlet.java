package servlet;

import dao.ProductoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Producto;
import modelo.TipoProducto;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    private ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listar(request, response);
                break;
            case "nuevo":
                mostrarFormularioNuevo(request, response);
                break;
            case "editar":
                mostrarFormularioEditar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("insertar".equals(accion)) {
            insertar(request, response);
        } else if ("actualizar".equals(accion)) {
            actualizar(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Producto> productos = dao.listarTodos();
        List<TipoProducto> tipos = dao.listarTipos();

        request.setAttribute("productos", productos);
        request.setAttribute("tipos", tipos);
        request.getRequestDispatcher("vistas/lista.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<TipoProducto> tipos = dao.listarTipos();
        request.setAttribute("tipos", tipos);
        request.getRequestDispatcher("vistas/formulario.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Producto producto = dao.buscarPorId(id);
        List<TipoProducto> tipos = dao.listarTipos();

        request.setAttribute("producto", producto);
        request.setAttribute("tipos", tipos);
        request.getRequestDispatcher("vistas/formulario.jsp").forward(request, response);
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int idTipo = Integer.parseInt(request.getParameter("idTipo"));

        Producto p = new Producto();
        p.setNombre(nombre);
        p.setPrecio(precio);
        p.setStock(stock);
        p.setIdTipo(idTipo);

        boolean ok = dao.insertar(p);

        if (ok) {
            request.getSession().setAttribute("mensaje", "Producto agregado correctamente.");
        } else {
            request.getSession().setAttribute("error", "No se pudo agregar el producto.");
        }

        response.sendRedirect("ProductoServlet?accion=listar");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int idTipo = Integer.parseInt(request.getParameter("idTipo"));

        Producto p = new Producto();
        p.setId(id);
        p.setNombre(nombre);
        p.setPrecio(precio);
        p.setStock(stock);
        p.setIdTipo(idTipo);

        boolean ok = dao.actualizar(p);

        if (ok) {
            request.getSession().setAttribute("mensaje", "Producto actualizado correctamente.");
        } else {
            request.getSession().setAttribute("error", "No se pudo actualizar el producto.");
        }

        response.sendRedirect("ProductoServlet?accion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean ok = dao.eliminar(id);

        if (ok) {
            request.getSession().setAttribute("mensaje", "Producto eliminado correctamente.");
        } else {
            request.getSession().setAttribute("error", "No se pudo eliminar el producto.");
        }

        response.sendRedirect("ProductoServlet?accion=listar");
    }
}
