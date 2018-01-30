<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 25.01.2018
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="addlibrarian" method="post">
    <c:if test="${error==1}">Пароли не совпадают</c:if>
    <c:if test="${error==2}">Неправильный формат даты</c:if>
    <c:if test="${error==3}">Имя пользователя уже существует</c:if>
    <c:if test="${error==4}">Имя пользователя должно содержать хотя бы одну латинскую букву и не содержать пробелов</c:if>
    Имя пользователя <input type="text" name="username" required>
    Пароль <input type="password" name="password" required>
    Повторите пароль <input type="password" name="repeat" required>
    <input type="submit"/>
</form>
</body>
</html>
