<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 26.01.2018
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<c:choose><c:when test="${user == null}">
    <div class="error-message">Пользователь не найден</div>
</c:when>
    <c:otherwise>
        <h2>Информация о пользователе</h2>
        <table class="restable"><tr>
        <td>Имя пользователя</td><td>${user.getUsername()}</td>
    </tr> <tr>
        <td>Роль</td><td>
        <c:choose><c:when test="${user.getRole() == 'reader'}">Читатель</c:when>
            <c:when test="${user.getRole() == 'librarian'}">Библиотекарь</c:when>
            <c:when test="${user.getRole() == 'admin'}">Администратор</c:when>
        </c:choose>
    </td></tr>
        <c:if test="${user.getRole() == 'reader'}"><tr>
        <td>Имя</td><td>${user.getFirstname()}</td>
    </tr><tr>
        <td>Фамилия</td><td>${user.getLastname()}</td>
    </tr><tr>
        <td>Дата рождения</td><td>${user.getDate()}</td>
    </tr><tr>
        <td>Адрес</td><td>${user.getAddress()}</td>
    </tr><tr>
        <td>Контактный телефон</td><td>${user.getPhone()}</td>
        </tr></c:if>
        </table>
        <c:if test="${pageContext.request.isUserInRole('admin') || pageContext.request.remoteUser == user.getUsername}">
        <a class="button" href="changePassword.jsp?id=${user.getUsername()}">Сменить пароль</a>
        </c:if>
        <c:if test="${pageContext.request.isUserInRole('admin')}"><a class="button" href="admin/deleteUser.jsp?id=${user.getUsername()}">Удалить</a> </c:if>

    </c:otherwise></c:choose>

</body>
</html>
