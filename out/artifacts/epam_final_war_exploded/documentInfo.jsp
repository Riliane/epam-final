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

    <c:if test="${!doc.isRepaired() && !isBorrowed && (pageContext.request.remoteUser == null || pageContext.request.isUserInRole('reader'))}">
        <a href="order?id=${doc.getId()}" class="button"><%=bundle.getString("order")%>
        </a> </c:if>
    <c:if test="${pageContext.request.isUserInRole('librarian')}">
        <c:if test="${isBorrowed}"><a href="manage/return?id=${doc.getId()}"
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
</c:otherwise>
</c:choose>

</body>
</html>
