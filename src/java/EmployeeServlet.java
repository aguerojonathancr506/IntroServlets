import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<h1>LISTA DE EMPLEADOS</h1>");

            try (Connection conn = Database.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM empleados");
                 ResultSet rs = stmt.executeQuery()) {

                boolean hayDatos = false;

                while (rs.next()) {
                    hayDatos = true;

                    out.println("<h2>" + rs.getString("nombre") + "</h2>");
                    out.println("<p>Departamento: " + rs.getString("departamento") + "</p>");
                    out.println("<hr>");
                }

                if (!hayDatos) {
                    out.println("<p>No hay empleados en la base de datos.</p>");
                }

            } catch (Exception e) {
                out.println("<h3 style='color:red;'>ERROR EN BD: " + e.getMessage() + "</h3>");
                e.printStackTrace();
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String departamento = request.getParameter("departamento");

        String sql = "INSERT INTO empleados (nombre, departamento) VALUES (?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nombre);
            stmt.setString(2, departamento);

            stmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/EmployeeServlet");

        } catch (Exception e) {
            throw new ServletException("ERROR EN INSERT", e);
        }
    }
}