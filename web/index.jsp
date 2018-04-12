<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %><%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 24.01.2018
  Time: 1:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% Locale locale = (Locale) session.getAttribute("locale");
    String lang = request.getParameter("lang");
    if (lang != null) {
        if (lang.equals("en")) {
            locale = Locale.ENGLISH;
        } else {
            locale = new Locale("ru", "RU");
        }
        session.setAttribute("locale", locale);
    }
    if (locale == null) {
        locale = new Locale("ru", "RU");
        session.setAttribute("locale", locale);
    }
    ResourceBundle bundle = ResourceBundle.getBundle("text", locale);
%>

<html>
<head>
    <title><%=bundle.getString("title")%>
    </title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<div class="topbar clearfix">
    <c:if test="${pageContext.request.remoteUser == null}"><a href="auth.jsp"
                                                              class="topbar-section topbar-link"><%=bundle.getString("loginButton")%>
    </a></c:if>
    <c:if test="${pageContext.request.isUserInRole('admin')}"><a href="admin/admin.jsp"
                                                                 class="topbar-section topbar-link"><%=bundle.getString("adminOptions")%>
    </a></c:if>
    <c:if test="${pageContext.request.isUserInRole('librarian')}"><a href="manage/addDocument.jsp"
                                                                     class="topbar-section topbar-link"><%=bundle.getString("addDocument")%>
    </a></c:if>
    <a href="index.jsp?lang=en" class="topbar-section topbar-language"><img src="gb.png">EN</a>
    <a href="index.jsp?lang=ru" class="topbar-section topbar-language"><img src="ru.png">RU</a>
</div>
<h1><%=bundle.getString("title")%>
</h1><br>

<h2><%=bundle.getString("documentSearch")%>
</h2>
<div class="form-container">
    <form action="document" method="get">
        <div class="form-element"><%=bundle.getString("documentById")%> <input type="number" name="id"></div>
        <input type="submit"/>
    </form>
</div>
<div class="form-container">
    <form action="search" method="get">
        <div class="form-element"><%=bundle.getString("document.title")%> <input type="text" name="name"></div>
        <div class="form-element"><%=bundle.getString("document.author")%> <input type="text" name="author"></div>
        <div class="form-element"><%=bundle.getString("document.publisher")%> <input type="text" name="publisher"></div>
        <div class="form-element"><%=bundle.getString("document.year")%> <input type="number" name="year_of_publishing">
        </div>
        <div class="form-element"><%=bundle.getString("document.series")%> <input type="text" name="series"></div>
        <div class="form-element"><%=bundle.getString("document.number")%> <input type="text" name="periodic_number">
        </div>
        <div class="form-element"><%=bundle.getString("document.topic")%> <input type="text" name="topic"></div>
        <div class="form-element"><%=bundle.getString("document.isbn")%> <input type="number" name="ISBN"></div>
        <input type="submit" value="<%=bundle.getString("submit")%>"/>
    </form>
</div>
<br><c:if test="${list != null}"><c:choose><c:when test="${list.isEmpty()}">
    <%=bundle.getString("noDocumentsFound")%>
</c:when>
    <c:otherwise>
        <%=bundle.getString("searchResults")%>
        <table class="restable">
            <tr>
                <th><%=bundle.getString("document.title")%>
                </th>
                <th><%=bundle.getString("document.author")%>
                </th>
                <th><%=bundle.getString("document.year")%>
                </th>
            </tr>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td><a href="/document?id=${item.getId()}">${item.getName()}</a></td>
                    <td>${item.getAuthor()}</td>
                    <td>${item.getYear()}</td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise></c:choose></c:if>

</body>
</html>
