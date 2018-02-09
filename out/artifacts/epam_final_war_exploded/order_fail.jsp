<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 25.01.2018
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title>Ошибка</title>
</head>
<body>
<div class="error-message">
Вы не можете заказать документ по следующей причине:<br>
<c:choose><c:when test="${error == 1}">Вы уже имеете слишком много документов на руках. Верните другие документы.</c:when>
    <c:when test="${error == 2}">У вас на руках есть документы, не возвращенные в срок. Верните документы.</c:when>
    <c:otherwise>Неизвестная причина</c:otherwise>
</c:choose></div>
</body>
</html>
