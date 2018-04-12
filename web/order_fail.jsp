<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 25.01.2018
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title><%=bundle.getString("error")%>
    </title>
</head>
<body>
<div class="error-message">
    <%=bundle.getString("orderForbidden")%><br>
    <c:choose><c:when test="${error == 1}"><%=bundle.getString("tooManyBorrowed")%>
    </c:when>
        <c:when test="${error == 2}"><%=bundle.getString("overdueBorrowed")%>
        </c:when>
        <c:otherwise><%=bundle.getString("unknownReason")%>
        </c:otherwise>
</c:choose></div>
</body>
</html>
