<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %><% Locale locale = (Locale) session.getAttribute("locale");
    String lang = request.getParameter("lang");
    if (lang != null) {
        if (lang.equals("en")) {
            locale = Locale.ENGLISH;
        } else {
            locale = new Locale("ru", "RU");
        }
        session.setAttribute("locale", locale);
    }
    if (locale == null) {
        locale = new Locale("ru", "RU");
        session.setAttribute("locale", locale);
    }
    ResourceBundle bundle = ResourceBundle.getBundle("text", locale);%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title><%=bundle.getString("registerSuccess")%></title>
</head>
<body><div class="message">
    <%=bundle.getString("userRegistered")%><br>
    <%=bundle.getString("username")%>: ${username}<br>
    <%=bundle.getString("password")%>: ${password}</div>
</body>
</html>
