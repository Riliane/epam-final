<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 26.01.2018
  Time: 0:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title>Добавить документ</title>
</head>
<body>
<div class="form-container"><form action="adddocument" method="post">
    <div class="form-element">Заглавие<input type="text" name="name" required></div>
    <div class="form-element">Автор <input type="text" name="author" required></div>
    <div class="form-element">Издатель <input type="text" name="publisher"></div>
    <div class="form-element">Год издания <input type="number" name="year_of_publishing"></div>
    <div class="form-element">Серия <input type="text" name="series"></div>
    <div class="form-element">Номер (для периодических изданий) <input type="text" name="periodic_number"></div>
    <div class="form-element">Тема <input type="text" name="topic"></div>
    <div class="form-element">ISBN/ISSN <input type="number" name="ISBN"></div>
    <div class="form-element"><input type="submit"/></div>
</form></div>
</body>
</html>
