<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title><%=bundle.getString("addLibrarian")%>
    </title>
</head>
<body>
<c:if test="${error==1}">
    <div class="error-message"><%=bundle.getString("passwordMismatch")%>
    </div>
</c:if>
<c:if test="${error==3}">
    <div class="error-message"><%=bundle.getString("usernameTaken")%>
    </div>
</c:if>
<c:if test="${error==4}">
    <div class="error-message"><%=bundle.getString("usernameWrongFormat")%>
    </div>
</c:if>
<div class="login-form-container"><form action="addlibrarian" method="post">
    <div class="form-element"><%=bundle.getString("username")%> <input type="text" name="username" required></div>
    <div class="form-element"><%=bundle.getString("password")%> <input type="password" name="password" required></div>
    <div class="form-element"><%=bundle.getString("repeatPassword")%> <input type="password" name="repeat" required>
    </div>
    <div class="form-element"><input type="submit" value="<%=bundle.getString("submit")%>"/></div>
</form></div>
</body>
</html>
