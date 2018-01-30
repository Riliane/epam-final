<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 26.01.2018
  Time: 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
Вы уверены, что хотите удалить пользователя ${param.id}?<br>
<a href="deleteUser?id=${param.id}">Подтвердить</a>
</body>
</html>
