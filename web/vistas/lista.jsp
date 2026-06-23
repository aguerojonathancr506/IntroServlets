<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>
<%@ page import="modelo.TipoProducto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tienda - Lista de Productos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="ProductoServlet?accion=listar">
            <i class="bi bi-shop"></i> Tienda Online
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="ProductoServlet?accion=listar">
                        <i class="bi bi-list-ul"></i> Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ProductoServlet?accion=nuevo">
                        <i class="bi bi-plus-circle"></i> Nuevo Producto
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <h2 class="mb-3">Lista de Productos</h2>

    <%
        String mensaje = (String) session.getAttribute("mensaje");
        String error = (String) session.getAttribute("error");
        if (mensaje != null) {
            session.removeAttribute("mensaje");
    %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle"></i> <%= mensaje %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>
    <% if (error != null) {
        session.removeAttribute("error");
    %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-x-circle"></i> <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="d-flex justify-content-end mb-3">
        <a href="ProductoServlet?accion=nuevo" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Agregar Producto
        </a>
    </div>

    <%
        List<Producto> productos = (List<Producto>) request.getAttribute("productos");
        List<TipoProducto> tipos = (List<TipoProducto>) request.getAttribute("tipos");

        if (tipos != null && productos != null) {
            for (TipoProducto tipo : tipos) {
                // Filtrar productos de este tipo
                boolean hayProductos = false;
                for (Producto p : productos) {
                    if (p.getIdTipo() == tipo.getId()) {
                        hayProductos = true;
                        break;
                    }
                }
                if (!hayProductos) continue;
    %>
    <h5 class="mt-4 text-secondary border-bottom pb-1">
        <i class="bi bi-tag"></i> <%= tipo.getNombre() %>
    </h5>
    <table class="table table-striped table-hover table-bordered align-middle">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Nombre</th>
                <th>Precio</th>
                <th>Stock</th>
                <th class="text-center">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Producto p : productos) {
                    if (p.getIdTipo() == tipo.getId()) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td>$<%= String.format("%.2f", p.getPrecio()) %></td>
                <td>
                    <% if (p.getStock() < 5) { %>
                    <span class="badge bg-danger"><%= p.getStock() %></span>
                    <% } else { %>
                    <span class="badge bg-success"><%= p.getStock() %></span>
                    <% } %>
                </td>
                <td class="text-center">
                    <a href="ProductoServlet?accion=editar&id=<%= p.getId() %>"
                       class="btn btn-warning btn-sm me-1">
                        <i class="bi bi-pencil"></i> Editar
                    </a>
                    <a href="ProductoServlet?accion=eliminar&id=<%= p.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('¿Estás seguro de eliminar este producto?')">
                        <i class="bi bi-trash"></i> Eliminar
                    </a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
    <%
            }
        }
    %>

    <% if (productos == null || productos.isEmpty()) { %>
    <div class="alert alert-info">
        <i class="bi bi-info-circle"></i> No hay productos registrados todavía.
        <a href="ProductoServlet?accion=nuevo">Agregar uno ahora</a>.
    </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
