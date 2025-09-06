<%--
  Created by IntelliJ IDEA.
  User: wilso
  Date: 27/08/2025
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    double n1 = Double.parseDouble(request.getParameter("txtn1"));
    double n2 = Double.parseDouble(request.getParameter("txtn2"));
    double s = n1 + n2;
    double r = n1 - n2;
    double d = n1 / n2;
    double m = n1 * n2;


    out.print("la suma es: "+ s + "<br>");
    out.print("la resta es: "+ r + "<br>");
    out.print("la divicion es: "+ d + "<br>");
    out.print("la multiplicacion es: "+ m + "<br>");

%>
<a href="apli01.html">Regresar</a>

</body>
</html>
