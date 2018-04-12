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
    <title><%=bundle.getString("changePassword")%></title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body><c:choose>
    <c:when test="${pageContext.request.isUserInRole('admin') || pageContext.request.remoteUser == id}">
        <div class="login-form-container"><form action="changePassword" method="post">
        <input type="text" value="${param.id}" name="id" hidden>
            <div class="form-element"><%=bundle.getString("newPassword")%> <input type="password" name="password" required></div>
            <div class="form-element"><%=bundle.getString("repeatPassword")%> <input type="password" name="repeat" required></div>
            <div class="form-element"><input type="submit"/></div>
        </form></div>
    </c:when>

    <c:otherwise><%response.sendError(HttpServletResponse.SC_FORBIDDEN);%>;</c:otherwise>
</c:choose>

</body>
</html>
