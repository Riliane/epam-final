<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 25.01.2018
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title>Администрирование</title>
</head>
<body>
<a class="button" href="addReader.jsp">Добавить читателя</a>
<a class="button" href="addLibrarian.jsp">Добавить библиотекаря</a><br>
<div class="form-container"><form action="/userinfo" method="get">
    <div class="form-element">Поиск пользователя по имени пользователя <input type="text" name="id"></div>
    <div class="form-element"><input type="submit"/></div></form></div>
</body>
</html>
