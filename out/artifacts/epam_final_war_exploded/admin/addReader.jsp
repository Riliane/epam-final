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
<form action="addreader" method="post">
    <c:if test="${error==1}">Пароли не совпадают</c:if>
    <c:if test="${error==2}">Неправильный формат даты</c:if>
    Имя <input type="text" name="firstname" required>
    Фамилия <input type="text" name="lastname" required>
    Адрес <input type="text" name="address" required>
    Контактный телефон <input type="text" name="phone" required>
    Дата рождения <input type="date" name="dateofbirth" required>
    Пароль <input type="password" name="password" required>
    Повторите пароль <input type="password" name="repeat" required>
    <input type="submit"/>
</form>
</body>
</html>
