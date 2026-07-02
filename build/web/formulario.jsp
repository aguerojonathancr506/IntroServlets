<%-- 
    Document   : formulario
    Created on : Jul 2, 2026, 11:13:40 PM
    Author     : aguer
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.curso.modelo.Libro" %>
<%
    Libro libro = (Libro) request.getAttribute("libro");
    String error = (String) request.getAttribute("error");

    String titulo = (libro != null && libro.getTitulo() != null) ? libro.getTitulo() : "";
    String autor = (libro != null && libro.getAutor() != null) ? libro.getAutor() : "";
    String descripcion = (libro != null && libro.getDescripcion() != null) ? libro.getDescripcion() : "";
    String imagenUrl = (libro != null && libro.getImagenUrl() != null) ? libro.getImagenUrl() : "";
    boolean esEdicion = (libro != null && libro.getId() != 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= esEdicion ? "Editar Libro" : "Nuevo Libro" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <span class="navbar-brand mb-0 h1">Libros Online</span>
        <a href="libros?action=listar" class="btn btn-secondary">← Volver al listado</a>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm" style="max-width: 600px; margin: 0 auto;">
        <div class="card-body">
            <h4 class="card-title mb-3">
                <%= esEdicion ? "Editar libro" : "Registrar nuevo libro" %>
            </h4>

            <% if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <form action="libros" method="post">

                <% if (esEdicion) { %>
                    <input type="hidden" name="id" value="<%= libro.getId() %>">
                <% } %>

                <div class="mb-3">
                    <label class="form-label">Título *</label>
                    <input type="text" class="form-control" name="titulo"
                           value="<%= titulo %>" required maxlength="150">
                </div>

                <div class="mb-3">
                    <label class="form-label">Autor *</label>
                    <input type="text" class="form-control" name="autor"
                           value="<%= autor %>" required maxlength="100">
                </div>

                <div class="mb-3">
                    <label class="form-label">Descripción</label>
                    <textarea class="form-control" name="descripcion" rows="3"><%= descripcion %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">URL de la imagen</label>
                    <input type="url" class="form-control" name="imagenUrl"
                           value="<%= imagenUrl %>" placeholder="https://...">
                </div>

                <button type="submit" class="btn btn-success">Guardar</button>
                <a href="libros?action=listar" class="btn btn-outline-secondary">Cancelar</a>
            </form>
        </div>
    </div>
</div>

</body>
</html>
