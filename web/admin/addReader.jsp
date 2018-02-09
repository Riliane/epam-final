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
    <title>Добавление читателя</title>
</head>
<body>
<c:if test="${error==1}"><div class="error-message">Пароли не совпадают</div></c:if>
<c:if test="${error==2}"><div class="error-message">Неправильный формат даты</div></c:if>
<div class="login-form-container"><form action="addreader" method="post">
    <div class="form-element">Имя <input type="text" name="firstname" required></div>
    <div class="form-element">Фамилия <input type="text" name="lastname" required></div>
    <div class="form-element">Адрес <input type="text" name="address" required></div>
    <div class="form-element">Контактный телефон <input type="text" name="phone" required></div>
    <div class="form-element">Дата рождения <input type="date" name="dateofbirth" required></div>
    <div class="form-element">Пароль <input type="password" name="password" required></div>
    <div class="form-element">Повторите пароль <input type="password" name="repeat" required></div>
    <div class="form-element"><input type="submit"/></div>
</form></div>
</body>
</html>
