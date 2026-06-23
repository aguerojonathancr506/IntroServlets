package dao;

import database.Conexion;
import modelo.Producto;
import modelo.TipoProducto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    public List<Producto> listarTodos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT p.id, p.nombre, p.precio, p.stock, p.id_tipo, t.nombre AS nombreTipo "
                   + "FROM Productos p "
                   + "INNER JOIN TiposProducto t ON p.id_tipo = t.id "
                   + "ORDER BY t.nombre, p.nombre";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
                p.setIdTipo(rs.getInt("id_tipo"));
                p.setNombreTipo(rs.getString("nombreTipo"));
                lista.add(p);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar productos: " + e.getMessage());
        }

        return lista;
    }

    public Producto buscarPorId(int id) {
        Producto p = null;
        String sql = "SELECT p.id, p.nombre, p.precio, p.stock, p.id_tipo, t.nombre AS nombreTipo "
                   + "FROM Productos p "
                   + "INNER JOIN TiposProducto t ON p.id_tipo = t.id "
                   + "WHERE p.id = ?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
                p.setIdTipo(rs.getInt("id_tipo"));
                p.setNombreTipo(rs.getString("nombreTipo"));
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar producto: " + e.getMessage());
        }

        return p;
    }
    public boolean insertar(Producto p) {
        String sql = "INSERT INTO Productos (nombre, precio, stock, id_tipo) VALUES (?, ?, ?, ?)";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setDouble(2, p.getPrecio());
            ps.setInt(3, p.getStock());
            ps.setInt(4, p.getIdTipo());

            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            System.out.println("Error al insertar producto: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Producto p) {
        String sql = "UPDATE Productos SET nombre=?, precio=?, stock=?, id_tipo=? WHERE id=?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setDouble(2, p.getPrecio());
            ps.setInt(3, p.getStock());
            ps.setInt(4, p.getIdTipo());
            ps.setInt(5, p.getId());

            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            System.out.println("Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM Productos WHERE id=?";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            System.out.println("Error al eliminar producto: " + e.getMessage());
            return false;
        }
    }

    public List<TipoProducto> listarTipos() {
        List<TipoProducto> lista = new ArrayList<>();
        String sql = "SELECT id, nombre FROM TiposProducto ORDER BY nombre";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TipoProducto t = new TipoProducto();
                t.setId(rs.getInt("id"));
                t.setNombre(rs.getString("nombre"));
                lista.add(t);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar tipos: " + e.getMessage());
        }

        return lista;
    }
}
