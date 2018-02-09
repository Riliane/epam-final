<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 26.01.2018
  Time: 12:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Смена пароля</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body><c:choose>
    <c:when test="${pageContext.request.isUserInRole('admin') || pageContext.request.remoteUser == id}">
        <div class="login-form-container"><form action="changePassword" method="post">
        <input type="text" value="${param.id}" name="id" hidden>
            <div class="form-element">Новый пароль <input type="password" name="password" required></div>
            <div class="form-element">Повторите пароль <input type="password" name="repeat" required></div>
            <div class="form-element"><input type="submit"/></div>
        </form></div>
    </c:when>

    <c:otherwise><%response.sendError(HttpServletResponse.SC_FORBIDDEN);%>;</c:otherwise>
</c:choose>

</body>
</html>
