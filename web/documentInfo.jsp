<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    ResourceBundle bundle = ResourceBundle.getBundle("text", locale);%>
<html>
<head>
    <title><%=bundle.getString("documentInfo")%>
    </title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<c:choose><c:when test="${doc == null}">
    <div class="error-message"><%=bundle.getString("documentNotFound")%>
    </div>
</c:when>
<c:otherwise>
    <h2><%=bundle.getString("documentInfo")%>
    </h2>
    <table class="restable"><c:if test="${doc.getName() != null}"><tr>
        <td><%=bundle.getString("document.title")%>
        </td>
        <td>${doc.getName()}</td>
    </tr></c:if> <c:if test="${doc.getAuthor() != null}"><tr>
        <td><%=bundle.getString("document.author")%>
        </td>
        <td>${doc.getAuthor()}</td>
    </tr></c:if> <c:if test="${doc.getPublisher() != null}"><tr>
        <td><%=bundle.getString("document.publisher")%>
        </td>
        <td>${doc.getPublisher()}</td>
    </tr></c:if> <c:if test="${doc.getYear() != 0}"><tr>
        <td><%=bundle.getString("document.year")%>
        </td>
        <td>${doc.getYear()}</td>
    </tr></c:if> <c:if test="${doc.getSeries() != null}"><tr>
        <td><%=bundle.getString("document.series")%>
        </td>
        <td>${doc.getSeries()}</td>
    </tr></c:if> <c:if test="${doc.getPeriodicNumber() != null}"><tr>
        <td><%=bundle.getString("document.number")%>
        </td>
        <td>${doc.getPeriodicNumber()}</td>
    </tr></c:if> <c:if test="${doc.getTopic() != null}"><tr>
        <td><%=bundle.getString("document.topic")%>
        </td>
        <td>${doc.getTopic()}</td>
    </tr></c:if> <c:if test="${doc.getIsbn() != 0}"><tr>
        <td><%=bundle.getString("document.isbn")%>
        </td>
        <td>${doc.getIsbn()}</td>
    </tr></c:if>
    </table>

    <c:if test="${!doc.isRepaired() && (currentList == null || currentList.isEmpty()) && (pageContext.request.remoteUser == null || pageContext.request.isUserInRole('reader'))}">
        <a href="order?id=${doc.getId()}" class="button"><%=bundle.getString("order")%>
        </a> </c:if>
    <c:if test="${pageContext.request.isUserInRole('librarian')}">
        <c:if test="${currentList != null && !currentList.isEmpty()}"><a href="manage/return?id=${doc.getId()}"
                                                                         class="button"><%=bundle.getString("return")%>
        </a><br>
        <c:choose><c:when test="${!doc.isRepaired()}">
            <a href="manage/repair?id=${doc.getId()}&set=true" class="button"><%=bundle.getString("damaged")%>
            </a><br>
        </c:when><c:otherwise><a href="manage/repair?id=${doc.getId()}&set=false"
                                 class="button"><%=bundle.getString("repaired")%>
        </a><br></c:otherwise></c:choose></c:if>
        <a href="manage/delete?id=${doc.getId()}" class="button"><%=bundle.getString("delete")%>
        </a><br>
    </c:if>
    <c:if test="${pageContext.request.isUserInRole('librarian') || pageContext.request.isUserInRole('admin')}">
        <c:if test="${currentList != null && !currentList.isEmpty()}">
            <h2><%=bundle.getString("borrowedBy")%>
            </h2><br>
            <table class="restable">
                <tr>
                    <th><%=bundle.getString("user.firstName")%>
                    </th>
                    <th><%=bundle.getString("user.lastName")%>
                    </th>
                    <th><%=bundle.getString("dateOfBorrow")%>
                    </th>
                    <th><%=bundle.getString("dateOfReturn")%>
                    </th>
                </tr>
                <c:forEach items="${currentList}" var="item">
                    <tr>
                        <td>
                            <a href="userinfo?id=${item.getReader().getUsername()}">${item.getReader().getFirstname()}</a>
                        </td>
                        <td>
                            <a href="userinfo?id=${item.getReader().getUsername()}">${item.getReader().getLastname()}</a>
                        </td>
                        <td>${item.getDateOfBorrow()}</td>
                        <td>${item.getDateOfReturn()}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <c:if test="${archiveList != null && !archiveList.isEmpty()}">
            <h2><%=bundle.getString("borrowHistory")%>
            </h2><br>
            <table class="restable">
                <tr>
                    <th><%=bundle.getString("user.firstName")%>
                    </th>
                    <th><%=bundle.getString("user.lastName")%>
                    </th>
                    <th><%=bundle.getString("dateOfBorrow")%>
                    </th>
                    <th><%=bundle.getString("dateOfReturn")%>
                    </th>
                </tr>
                <c:forEach items="${archiveList}" var="item">
                    <tr>
                        <td>
                            <a href="userinfo?id=${item.getReader().getUsername()}">${item.getReader().getFirstname()}</a>
                        </td>
                        <td>
                            <a href="userinfo?id=${item.getReader().getUsername()}">${item.getReader().getLastname()}</a>
                        </td>
                        <td>${item.getDateOfBorrow()}</td>
                        <td>${item.getDateOfReturn()}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </c:if>
</c:otherwise>
</c:choose>

</body>
</html>
