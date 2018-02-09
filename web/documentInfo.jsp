<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 24.01.2018
  Time: 23:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Информация о документе</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<c:choose><c:when test="${doc == null}">
    <div class="error-message">Документ не найден</div>
</c:when>
<c:otherwise>
    <h2>Информация о документе</h2>
    <table class="restable"><c:if test="${doc.getName() != null}"><tr>
        <td>Заглавие</td><td>${doc.getName()}</td>
    </tr></c:if> <c:if test="${doc.getAuthor() != null}"><tr>
        <td>Автор</td><td>${doc.getAuthor()}</td>
    </tr></c:if> <c:if test="${doc.getPublisher() != null}"><tr>
        <td>Издатель</td><td>${doc.getPublisher()}</td>
    </tr></c:if> <c:if test="${doc.getYear() != 0}"><tr>
        <td>Год издания</td><td>${doc.getYear()}</td>
    </tr></c:if> <c:if test="${doc.getSeries() != null}"><tr>
        <td>Серия</td><td>${doc.getSeries()}</td>
    </tr></c:if> <c:if test="${doc.getPeriodicNumber() != null}"><tr>
        <td>Номер выпуска</td><td>${doc.getPeriodicNumber()}</td>
    </tr></c:if> <c:if test="${doc.getTopic() != null}"><tr>
        <td>Тема</td><td>${doc.getTopic()}</td>
    </tr></c:if> <c:if test="${doc.getIsbn() != 0}"><tr>
        <td>ISBN</td><td>${doc.getIsbn()}</td>
    </tr></c:if>
    </table>

    <c:if test="${!doc.isRepaired() && !isBorrowed && (pageContext.request.remoteUser == null || pageContext.request.isUserInRole('reader'))}">
        <a href="order?id=${doc.getId()}" class="button">Заказать</a> </c:if>
    <c:if test="${pageContext.request.isUserInRole('librarian')}">
        <c:if test="${isBorrowed}"><a href="manage/return?id=${doc.getId()}" class="button">Возврат</a><br>
        <c:choose><c:when test="${!doc.isRepaired()}">
            <a href="manage/repair?id=${doc.getId()}&set=true" class="button">Поврежден</a><br>
        </c:when><c:otherwise><a href="manage/repair?id=${doc.getId()}&set=false" class="button">Восстановлен</a><br></c:otherwise></c:choose></c:if>
        <a href="manage/delete?id=${doc.getId()}" class="button">Удалить</a><br>
    </c:if>
</c:otherwise>
</c:choose>

</body>
</html>
