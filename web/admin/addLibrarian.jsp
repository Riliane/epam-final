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
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title>Добавление библиотекаря</title>
</head>
<body>
<c:if test="${error==1}"><div class="error-message">Пароли не совпадают</div></c:if>
<c:if test="${error==2}"><div class="error-message">Неправильный формат даты</div></c:if>
<c:if test="${error==3}"><div class="error-message">Имя пользователя уже существует</div></c:if>
<c:if test="${error==4}"><div class="error-message">Имя пользователя должно содержать хотя бы одну латинскую букву и не содержать пробелов</div></c:if>
<div class="login-form-container"><form action="addlibrarian" method="post">
    <div class="form-element">Имя пользователя <input type="text" name="username" required></div>
    <div class="form-element">Пароль <input type="password" name="password" required></div>
    <div class="form-element">Повторите пароль <input type="password" name="repeat" required></div>
    <div class="form-element"><input type="submit"/></div>
</form></div>
</body>
</html>
