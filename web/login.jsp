<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 25.01.2018
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="POST" action="j_security_check">
    Имя пользователя:<input type="text" name="j_username">
    Пароль:<input type="password" name="j_password">
    <input type="submit" value="Войти" >
</form>
</body>
</html>
