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
    <title>Title</title>
</head>
<body>
<a href="addReader.jsp">Добавить читателя</a>
<a href="addLibrarian.jsp">Добавить библиотекаря</a><br>
<form action="/userinfo" method="get">
    Поиск пользователя по имени пользователя <input type="text" name="id">
    <input type="submit"/></form>
</body>
</html>
