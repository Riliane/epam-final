<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
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
    ResourceBundle bundle = ResourceBundle.getBundle("text", locale);
%>
<html>
<head>
    <title><%=bundle.getString("loginPage")%>
    </title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<div class="login-form-container">
<form method="POST" action="j_security_check">
    <div class="form-element"><%=bundle.getString("username")%>:<input type="text" name="j_username"></div>
    <br>
    <div class="form-element"><%=bundle.getString("password")%>:<input type="password" name="j_password"></div>
    <div class="form-element"><input type="submit" value="<%=bundle.getString("loginButton")%>"></div>
</form>
</div>
</body>
</html>
