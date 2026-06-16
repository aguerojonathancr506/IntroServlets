
import database.Database;
import java.sql.Connection;
import java.sql.PreparedStatement;


public class ProductoDAO {


    public boolean insertarProducto(String nombre, String precio, String stock) {


        String sql = "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)";


        try {

            Connection conn = Database.getConnection();

            PreparedStatement stmt = conn.prepareStatement(sql);


            stmt.setString(1, nombre);
            stmt.setString(2, precio);
            stmt.setString(3, stock);


            stmt.executeUpdate();


            stmt.close();
            conn.close();


            return true;


        } catch (Exception e) {


            System.out.println("Error al insertar producto: " + e.getMessage());

            return false;


        }


    }

}