/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.curso.controlador;

import com.curso.dao.LibroDAO;
import com.curso.modelo.Libro;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author aguer
 */


@WebServlet("/libros")
public class LibroServlet extends HttpServlet {

    private final LibroDAO libroDAO = new LibroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "listar";
        }

        switch (action) {
            case "nuevo":
                mostrarFormulario(request, response, null);
                break;

            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Libro libro = libroDAO.obtenerPorId(idEditar);
                mostrarFormulario(request, response, libro);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = libroDAO.eliminar(idEliminar);
                request.getSession().setAttribute("mensaje",
                        eliminado ? "Libro eliminado correctamente." : "No se pudo eliminar el libro.");
                response.sendRedirect("libros?action=listar");
                break;

            case "listar":
            default:
                listar(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String descripcion = request.getParameter("descripcion");
        String imagenUrl = request.getParameter("imagenUrl");

        if (titulo == null || titulo.trim().isEmpty()
                || autor == null || autor.trim().isEmpty()) {

            request.setAttribute("error", "Título y autor son obligatorios.");
            Libro libroConError = new Libro();
            if (idParam != null && !idParam.isEmpty()) {
                libroConError.setId(Integer.parseInt(idParam));
            }
            libroConError.setTitulo(titulo);
            libroConError.setAutor(autor);
            libroConError.setDescripcion(descripcion);
            libroConError.setImagenUrl(imagenUrl);

            mostrarFormulario(request, response, libroConError);
            return;
        }

        Libro libro = new Libro();
        libro.setTitulo(titulo.trim());
        libro.setAutor(autor.trim());
        libro.setDescripcion(descripcion);
        libro.setImagenUrl(imagenUrl);

        boolean exito;
        if (idParam == null || idParam.trim().isEmpty()) {
            exito = libroDAO.insertar(libro);
        } else {
            libro.setId(Integer.parseInt(idParam));
            exito = libroDAO.actualizar(libro);
        }

        request.getSession().setAttribute("mensaje",
                exito ? "Libro guardado correctamente." : "Ocurrió un error al guardar.");

        response.sendRedirect("libros?action=listar");
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Libro> libros = libroDAO.listarTodos();
        request.setAttribute("libros", libros);
        RequestDispatcher rd = request.getRequestDispatcher("listar.jsp");
        rd.forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response, Libro libro)
            throws ServletException, IOException {
        request.setAttribute("libro", libro);
        RequestDispatcher rd = request.getRequestDispatcher("formulario.jsp");
        rd.forward(request, response);
    }
}