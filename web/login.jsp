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
    <title>Вход в систему</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<div class="login-form-container">
<form method="POST" action="j_security_check">
    <div class="form-element">Имя пользователя:<input type="text" name="j_username"></div><br>
    <div class="form-element">Пароль:<input type="password" name="j_password"></div>
    <div class="form-element"><input type="submit" value="Войти" ></div>
</form>
</div>
</body>
</html>
