<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Cursos</title>
</head>
<body>
<h2>Listado de Cursos</h2>
<table border="1">
    <tr>
        <th>Código</th>
        <th>Nombre</th>
        <th>Crédito</th>
    </tr>

    <%
        // Configuración de conexión
        String url = "jdbc:mysql://localhost:3306/escuela?useUnicode=true&characterEncoding=UTF-8";
        String username = "root";
        String password = "";

        String query = "SELECT chrCurCodigo, vchCurNombre, intCurCreditos FROM curso";

        try {
            // Cargar el driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Conectar a la base de datos
            try (Connection con = DriverManager.getConnection(url, username, password);
                 PreparedStatement pstmt = con.prepareStatement(query);
                 ResultSet rs = pstmt.executeQuery()) { // Ejecutar consulta segura

                // Mostrar resultados
                while (rs.next()) {
                    String id = rs.getString("chrCurCodigo");
                    String name = rs.getString("vchCurNombre");
                    int credito = rs.getInt("intCurCreditos");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= name %></td>
        <td><%= credito %></td>
    </tr>
    <%
                }
            }
        } catch (ClassNotFoundException e) {
            out.println("<p style='color:red;'>Error: No se encontró el driver JDBC.</p>");
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error de conexión a la base de datos: " + e.getMessage() + "</p>");
        }
    %>
</table>
</body>
</html>