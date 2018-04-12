<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
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
    <title><%=bundle.getString("addReader")%>
    </title>
</head>
<body>
<c:if test="${error==1}">
    <div class="error-message"><%=bundle.getString("passwordMismatch")%>
    </div>
</c:if>
<div class="login-form-container"><form action="addreader" method="post">
    <div class="form-element"><%=bundle.getString("user.firstName")%> <input type="text" name="firstname" required>
    </div>
    <div class="form-element"><%=bundle.getString("user.lastName")%> <input type="text" name="lastname" required></div>
    <div class="form-element"><%=bundle.getString("user.address")%> <input type="text" name="address" required></div>
    <div class="form-element"><%=bundle.getString("user.phone")%> <input type="text" name="phone" required></div>
    <div class="form-element"><%=bundle.getString("user.birthDate")%> <input type="date" name="dateofbirth" required>
    </div>
    <div class="form-element"><%=bundle.getString("password")%> <input type="password" name="password" required></div>
    <div class="form-element"><%=bundle.getString("repeatPassword")%> <input type="password" name="repeat" required>
    </div>
    <div class="form-element"><input type="submit" value="<%=bundle.getString("submit")%>"/></div>
</form></div>
</body>
</html>
