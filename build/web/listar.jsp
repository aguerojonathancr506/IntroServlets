<%-- 
    Document   : Listar
    Created on : Jul 2, 2026, 11:13:28 PM
    Author     : aguer
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.curso.modelo.Libro" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Libros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <span class="navbar-brand mb-0 h1">Libros Online</span>
        <a href="libros?action=nuevo" class="btn btn-success">Agregar Libro</a>
    </div>
</nav>

<div class="container">

    <%
        String mensaje = (String) session.getAttribute("mensaje");
        if (mensaje != null) {
    %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <%= mensaje %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <%
            session.removeAttribute("mensaje");
        }

        List<Libro> libros = (List<Libro>) request.getAttribute("libros");

        if (libros == null || libros.isEmpty()) {
    %>
        <div class="alert alert-warning">No hay libros registrados.</div>
    <%
        }
    %>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
            if (libros != null) {
                for (Libro libro : libros) {
        %>
        <div class="col">
            <div class="card h-100 shadow-sm">
                <img src="<%= libro.getImagenUrl() %>" class="card-img-top" alt="<%= libro.getTitulo() %>"
                     style="height: 280px; object-fit: cover;"
                     onerror="this.src='https://via.placeholder.com/300x280?text=Sin+imagen'">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= libro.getTitulo() %></h5>
                    <h6 class="card-subtitle mb-2 text-muted"><%= libro.getAutor() %></h6>
                    <p class="card-text flex-grow-1"><%= libro.getDescripcion() %></p>
                    <div class="d-flex gap-2 mt-2">
                        <a href="libros?action=editar&id=<%= libro.getId() %>"
                           class="btn btn-outline-primary btn-sm">Editar</a>
                        <a href="libros?action=eliminar&id=<%= libro.getId() %>"
                           class="btn btn-outline-danger btn-sm"
                           onclick="return confirm('¿Seguro que deseas eliminar este libro?');">Eliminar</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
