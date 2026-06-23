<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>
<%@ page import="modelo.TipoProducto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tienda - Formulario Producto</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="ProductoServlet?accion=listar">
            <i class="bi bi-shop"></i> Tienda Online
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="ProductoServlet?accion=listar">
                        <i class="bi bi-list-ul"></i> Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="ProductoServlet?accion=nuevo">
                        <i class="bi bi-plus-circle"></i> Nuevo Producto
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <%
        Producto producto = (Producto) request.getAttribute("producto");
        boolean esEditar = (producto != null);
        List<TipoProducto> tipos = (List<TipoProducto>) request.getAttribute("tipos");
    %>

    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-<%= esEditar ? "pencil" : "plus-lg" %>"></i>
                        <%= esEditar ? "Editar Producto" : "Nuevo Producto" %>
                    </h5>
                </div>
                <div class="card-body">

                    <form action="${pageContext.request.contextPath}/ProductoServlet" method="post">

                        <% if (esEditar) { %>
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= producto.getId() %>">
                        <% } else { %>
                        <input type="hidden" name="accion" value="insertar">
                        <% } %>

                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre del Producto</label>
                            <input type="text" class="form-control" id="nombre" name="nombre"
                                   value="<%= esEditar ? producto.getNombre() : "" %>"
                                   placeholder="Ej. Laptop HP"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="precio" class="form-label">Precio ($)</label>
                            <input type="number" class="form-control" id="precio" name="precio"
                                   value="<%= esEditar ? producto.getPrecio() : "" %>"
                                   step="0.01" min="0"
                                   placeholder="0.00"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="stock" class="form-label">Stock</label>
                            <input type="number" class="form-control" id="stock" name="stock"
                                   value="<%= esEditar ? producto.getStock() : "" %>"
                                   min="0"
                                   placeholder="0"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label for="idTipo" class="form-label">Tipo de Producto</label>
                            <select class="form-select" id="idTipo" name="idTipo" required>
                                <option value="">-- Selecciona un tipo --</option>
                                <%
                                    if (tipos != null) {
                                        for (TipoProducto t : tipos) {
                                            boolean seleccionado = esEditar && producto.getIdTipo() == t.getId();
                                %>
                                <option value="<%= t.getId() %>" <%= seleccionado ? "selected" : "" %>>
                                    <%= t.getNombre() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i>
                                <%= esEditar ? "Actualizar" : "Guardar" %>
                            </button>
                            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listar" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Cancelar
                            </a>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
