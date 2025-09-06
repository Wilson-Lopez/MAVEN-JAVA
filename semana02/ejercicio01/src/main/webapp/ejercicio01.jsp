<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Resultado - Descuento</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String colegio   = request.getParameter("colegio");
    String categoria = request.getParameter("categoria");
    String cuotaStr  = request.getParameter("cuota");

    boolean datosOK = true;
    double cuota = 0.0;
    double pct = 0.0;

    if (colegio == null || categoria == null || cuotaStr == null ||
            colegio.isEmpty() || categoria.isEmpty() || cuotaStr.isEmpty()) {
        datosOK = false;
        out.print(" Debe completar todos los campos.<br>");
    } else {
        try {
            cuota = Double.parseDouble(cuotaStr);
            if (cuota < 0) {
                datosOK = false;
                out.print(" La cuota no puede ser negativa.<br>");
            }
        } catch(NumberFormatException ex) {
            datosOK = false;
            out.print(" Ingrese un monto de cuota válido.<br>");
        }
    }

    if (datosOK) {
        // Normalizamos
        String col = colegio.toLowerCase();
        String cat = categoria.toUpperCase();

        if ("nacional".equals(col)) {
            if ("A".equals(cat))      pct = 0.50;
            else if ("B".equals(cat)) pct = 0.40;
            else if ("C".equals(cat)) pct = 0.30;
            else datosOK = false;
        } else if ("particular".equals(col)) {
            if ("A".equals(cat))      pct = 0.25;
            else if ("B".equals(cat)) pct = 0.20;
            else if ("C".equals(cat)) pct = 0.15;
            else datosOK = false;
        } else {
            datosOK = false;
        }

        if (!datosOK) {
            out.print(" Valores inválidos para colegio o categoría.<br>");
        } else {
            double descuento = cuota * pct;
            double total     = cuota - descuento;

            // Formateo a 2 decimales
            String cuotaF     = String.format("S/ %.2f", cuota);
            String descuentoF = String.format("S/ %.2f", descuento);
            String totalF     = String.format("S/ %.2f", total);
            String pctF       = String.format("%.0f%%", pct * 100);

%>
<h2>Resultado</h2>
<table border="1" cellpadding="8" cellspacing="0">
    <tr><th>Colegio</th><td><%= col.substring(0,1).toUpperCase() + col.substring(1) %></td></tr>
    <tr><th>Categoría</th><td><%= cat %></td></tr>
    <tr><th>Cuota</th><td><%= cuotaF %></td></tr>
    <tr><th>Descuento</th><td><%= pctF %> (<%= descuentoF %>)</td></tr>
    <tr><th>Importe a pagar</th><td><strong><%= totalF %></strong></td></tr>
</table>
<%
        }
    }
%>

<br><br>
<a href="ejercicio01.html">⟵ Regresar</a>
</body>
</html>
