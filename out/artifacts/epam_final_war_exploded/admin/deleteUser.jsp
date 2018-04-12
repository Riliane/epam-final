<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% Locale locale = (Locale) session.getAttribute("locale");
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
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title><%=bundle.getString("deleteUser")%></title>
</head>
<body>
<div class="message"> <%=bundle.getString("deleteUserConfirm1")%> ${param.id}<%=bundle.getString("deleteUserConfirm2")%><br>
<a href="deleteUser?id=${param.id}" class="button"><%=bundle.getString("confirm")%></a></div>
</body>
</html>
