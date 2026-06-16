<%-- 
    Document   : productos
    Created on : Jun 16, 2026, 9:57:01 PM
    Author     : aguer
--%>

<%@page import="database.Database"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Productos</title>
</head>
    <body>
        <h1>Lista de productos</h1>
        <table border="1">
    <tr>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Stock</th>
    </tr>

    <%
    Connection conn = Database.getConnection();
    String sql = "SELECT nombre, precio, stock FROM productos";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
    while(rs.next()){
    %>

    <tr>
        <td><%= rs.getString("nombre") %></td>
        <td><%= rs.getString("precio") %></td>
        <td><%= rs.getString("stock") %></td>
    </tr>

    <%
 }
        rs.close();
        stmt.close();
        conn.close();
    %>

    </table>
        <br>
            <a href="index.html">
            Volver al registro
            </a>
    </body>
</html>
