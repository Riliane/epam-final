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
    <title>Title</title>
</head>
<body>
<form action="adddocument" method="post">
    Заглавие<input type="text" name="name" required>
    Автор <input type="text" name="author" required>
    Издатель <input type="text" name="publisher">
    Год издания <input type="number" name="year_of_publishing">
    Серия <input type="text" name="series">
    Номер (для периодических изданий) <input type="text" name="periodic_number">
    Тема <input type="text" name="topic">
    ISBN/ISSN <input type="number" name="ISBN">
    <input type="submit"/>
</form>
</body>
</html>
