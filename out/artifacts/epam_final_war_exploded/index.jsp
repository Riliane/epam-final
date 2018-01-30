<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 24.01.2018
  Time: 1:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
  <head>
    <title>Электронный каталог библиотеки</title>
      <link rel="stylesheet" type="text/css" href="/style.css">
  </head>
  <body>
  <div class="topbar clearfix">
      <c:if test="${pageContext.request.remoteUser == null}"><a href="auth.jsp" class="topbar-section">Войти</a></c:if>
      <c:if test="${pageContext.request.isUserInRole('admin')}"><a href="admin/admin.jsp" class="topbar-section">Управление</a></c:if>
  </div>
  <h1>Электронный каталог библиотеки</h1><br>

  <h2>Поиск документов</h2>
  <div class="form-container"><form action="document" method="get">
      <div class="form-element">По шифру: <input type="number" name="id"></div>
      <input type="submit"/>
  </form></div>
  <div class="form-container"><form action="search" method="get">
      <div class="form-element">Заглавие <input type="text" name="name"></div>
      <div class="form-element">Автор <input type="text" name="author"></div>
      <div class="form-element">Издатель <input type="text" name="publisher"></div>
      <div class="form-element">Год издания <input type="number" name="year_of_publishing"></div>
      <div class="form-element">Серия <input type="text" name="series"></div>
      <div class="form-element">Номер (для периодических изданий) <input type="text" name="periodic_number"></div>
      <div class="form-element">Тема <input type="text" name="topic"></div>
      <div class="form-element">ISBN/ISSN <input type="number" name="ISBN"></div>
      <input type="submit"/>
  </form></div>
  <br><c:if test="${list != null}"><c:choose><c:when test="${list.isEmpty()}">
      Документов не найдено
  </c:when>
  <c:otherwise>
      Результаты поиска:
      <table class="restable">
          <tr><th>Заглавие</th><th>Автор</th><th>Год издания</th></tr>
          <c:forEach items="${list}" var="item">
              <tr>
                  <td><a href = "/document?id=${item.getId()}">${item.getName()}</a></td>
                  <td>${item.getAuthor()}</td>
                  <td>${item.getYear()}</td>
              </tr>
          </c:forEach>
      </table>
  </c:otherwise></c:choose></c:if>

  </body>
</html>
