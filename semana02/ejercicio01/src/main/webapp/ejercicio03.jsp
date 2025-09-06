<%--
  Created by IntelliJ IDEA.
  User: wilso
  Date: 28/08/2025
  Time: 08:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sueldo del obrero</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String prenda = request.getParameter("prenda");
    String categoria = request.getParameter("categoria");
    String cantidadStr = request.getParameter("cantidad");

    boolean datosOK = true;
    int cantidad = 0;
    double tarifa = 0.0;
    double sueldo = 0.0;
    double bonificacion = 0.0;

    if (prenda == null || categoria == null || cantidadStr == null ||
            prenda.isEmpty() || categoria.isEmpty() || cantidadStr.isEmpty()) {
        datosOK = false;
%>
<p style="color:red;">Debe completar todos los campos.</p>
<%
} else {
    try {
        cantidad = Integer.parseInt(cantidadStr);
        if (cantidad < 0) {
            datosOK = false;
%>
<p style="color:red;">Ingrese una cantidad válida.</p>
<%
    }
} catch (Exception e) {
    datosOK = false;
%>
<p style="color:red;">Error en los datos ingresados.</p>
<%
        }
    }

    if (datosOK) {
        // Definir la tarifa según prenda
        switch (prenda.toLowerCase()) {
            case "polo": tarifa = 0.50; break;
            case "camisa": tarifa = 1.00; break;
            case "pantalon": tarifa = 1.50; break;
            default: datosOK = false;
        }

        sueldo = cantidad * tarifa;

        if (cantidad > 700) {
            switch (categoria.toUpperCase()) {
                case "A": bonificacion = 250; break;
                case "B": bonificacion = 150; break;
                case "C": bonificacion = 100; break;
                case "D": bonificacion = 50;  break;
                default: bonificacion = 0;
            }
        }
        double total = sueldo + bonificacion;
        String sueldoF = String.format("S/ %.2f", sueldo);
        String bonifF = String.format("S/ %.2f", bonificacion);
        String totalF = String.format("S/ %.2f", total);
%>
<h2>Resultado</h2>
<table border="1" cellpadding="8" cellspacing="0">
    <tr><th>Prenda</th><td><%= prenda.toUpperCase() %></td></tr>
    <tr><th>Cantidad</th><td><%= cantidad %></td></tr>
    <tr><th>Tarifa</th><td>S/ <%= tarifa %></td></tr>
    <tr><th>Sueldo Base</th><td><%= sueldoF %></td></tr>
    <tr><th>Bonificación</th><td><%= bonifF %></td></tr>
    <tr><th>Total a Cobrar</th><td><strong><%= totalF %></strong></td></tr>
</table>
<%
    }
%>
<br><br>
<a href="ejercicio03.html">⟵ Regresar</a>
</body>
</html>









