<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Búsqueda de Medicamentos</title>
</head>
<body>
<h1>Búsqueda de Medicamentos</h1>

<form method="get" action="index01.jsp">
    <label for="especialidad">Especialidad:</label>
    <select name="especialidad" id="especialidad">
        <option value="">--Todas--</option>
        <%
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/farmacia?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8",
                    "root", "")) {
                try (Statement st = con.createStatement();
                     ResultSet rsEsp = st.executeQuery("SELECT descripcionEsp FROM especialidad")) {
                    String sel = request.getParameter("especialidad");
                    while (rsEsp.next()) {
                        String esp = rsEsp.getString("descripcionEsp");
                        String selected = (sel != null && sel.equals(esp)) ? "selected" : "";
        %>
        <option value="<%= esp %>" <%= selected %>><%= esp %></option>
        <%
                    }
                }
            } catch (Exception e) { out.println("<option>Error cargando especialidades</option>"); }
        %>
    </select>

    <label for="tipoMedic">Tipo de Medicamento:</label>
    <select name="tipoMedic" id="tipoMedic">
        <option value="">--Todos--</option>
        <%
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/farmacia?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8",
                    "root", "")) {
                try (Statement st = con.createStatement();
                     ResultSet rsTipo = st.executeQuery("SELECT descripcion FROM tipomedic")) {
                    String sel = request.getParameter("tipoMedic");
                    while (rsTipo.next()) {
                        String tipo = rsTipo.getString("descripcion");
                        String selected = (sel != null && sel.equals(tipo)) ? "selected" : "";
        %>
        <option value="<%= tipo %>" <%= selected %>><%= tipo %></option>
        <%
                    }
                }
            } catch (Exception e) { out.println("<option>Error cargando tipos</option>"); }
        %>
    </select>

    <button type="submit">Buscar</button>
</form>

<hr>

<%
    String especialidad = request.getParameter("especialidad");
    String tipoMedic = request.getParameter("tipoMedic");

    // Ejecuta la búsqueda solo cuando se envía el form (o si hay query params)
    if (especialidad != null || tipoMedic != null) {
        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/farmacia?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8",
                "root", "")) {

            String sql =
                    "SELECT m.descripcionMed, m.Marca, e.descripcionEsp, t.descripcion AS tipoMedic " +
                            "FROM medicamento m " +
                            "JOIN especialidad e ON m.CodEspec = e.CodEspecial " +
                            "JOIN tipomedic t ON m.CodTipoMedic = t.CodTipoMed " +
                            "WHERE (? = '' OR e.descripcionEsp = ?) " +
                            "AND   (? = '' OR t.descripcion = ?)";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, especialidad == null ? "" : especialidad);
                ps.setString(2, especialidad == null ? "" : especialidad);
                ps.setString(3, tipoMedic == null ? "" : tipoMedic);
                ps.setString(4, tipoMedic == null ? "" : tipoMedic);

                try (ResultSet rs = ps.executeQuery()) {
%>
<h2>Resultados de la búsqueda</h2>
<table border="1">
    <tr><th>Medicamento</th><th>Marca</th><th>Especialidad</th><th>Tipo</th></tr>
    <%
        boolean hay = false;
        while (rs.next()) { hay = true; %>
    <tr>
        <td><%= rs.getString("descripcionMed") %></td>
        <td><%= rs.getString("Marca") %></td>
        <td><%= rs.getString("descripcionEsp") %></td>
        <td><%= rs.getString("tipoMedic") %></td>
    </tr>
    <% }
        if (!hay) { %>
    <tr><td colspan="4">No se encontraron resultados</td></tr>
    <% } %>
</table>
<%
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

</body>
</html>
