<%--
  Created by IntelliJ IDEA.
  User: wilso
  Date: 27/08/2025
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resultado</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String estado = request.getParameter("estado");
    String hijosStr = request.getParameter("hijos");
    String sueldoStr = request.getParameter("sueldo");

    boolean datosOK = true;
    double sueldo = 0.0;
    int hijos = 0;
    double pctbase = 0.0;
    double pctHijos = 0.0;
    if (estado == null || hijosStr == null || sueldoStr == null ||
        estado.isEmpty() || hijosStr.isEmpty() || sueldoStr.isEmpty()) {
        datosOK = false;
        out.print("se debe completar los campos");
    } else {
        try {
            sueldo = Double.parseDouble(sueldoStr);
            hijos = Integer.parseInt(hijosStr);
            if (sueldo < 0 || hijos < 0) {
                datosOK = false;
                out.print("Ingrese valores validos");
            }
        } catch (Exception e) {
            datosOK = false;
            out.print("error en los datos ingresados");
        }
    }
    if (datosOK) {
        switch (estado.toLowerCase()){
            case "casado": pctbase = 0.13; break;
            case "viudo": pctbase = 0.15; break;
            case "soltero": pctbase = 0.05; break;
            default: datosOK = false;
        }
        pctHijos = hijos * 0.016;
        if (pctHijos > 0.096) pctHijos = 0.096;
        double pctTotal = pctbase + pctHijos;
        double bonificacion = sueldo * pctTotal;
        double neto = sueldo + bonificacion;

        String sueldoF = String.format("s/ %.2f", sueldo);
        String bonifF = String.format("s/ %.2f", bonificacion);
        String netoF = String.format("s/ %.2f", neto);
        String pctTotalF = String.format("%.2f%%", pctTotal*100);
%>
<h2>Resultado</h2>
<table border="1" cellpadding="8" cellspacing="0">
    <tr><th>Estado Civil</th><td><%= estado.substring(0,1).toUpperCase() + estado.substring(1) %></td></tr>
    <tr><th>Hijos</th><td><%= hijos %></td></tr>
    <tr><th>Sueldo Básico</th><td><%= sueldoF %></td></tr>
    <tr><th>Bonificación</th><td><%= bonifF %> (<%= pctTotalF %>)</td></tr>
    <tr><th>Neto a Cobrar</th><td><strong><%= netoF %></strong></td></tr>
</table>
<%
    }
%>

<br><br>
<a href="ejercicio02.html">⟵ Regresar</a>
</body>
</html>
