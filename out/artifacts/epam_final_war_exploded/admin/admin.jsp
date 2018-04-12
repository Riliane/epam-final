<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
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
    ResourceBundle bundle = ResourceBundle.getBundle("text", locale);%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <title><%=bundle.getString("adminOptions")%>
    </title>
</head>
<body>
<a class="button" href="addReader.jsp"><%=bundle.getString("addReader")%>
</a>
<a class="button" href="addLibrarian.jsp"><%=bundle.getString("addLibrarian")%>
</a><br>
<div class="form-container"><form action="/userinfo" method="get">
    <div class="form-element"><%=bundle.getString("userSearch")%> <br>
        <%=bundle.getString("userByUsername")%> <input type="text" name="id"></div>
    <div class="form-element"><input type="submit" value="<%=bundle.getString("submit")%>"/></div>
</form>
    <form action="/readersearch" method="get">
        <div class="form-element"><%=bundle.getString("user.firstName")%> <input type="text" name="first_name"></div>
        <div class="form-element"><%=bundle.getString("user.lastName")%> <input type="text" name="last_name"></div>
        <div class="form-element"><%=bundle.getString("user.birthDate")%> <input type="date" name="date_of_birth"></div>
        <div class="form-element"><%=bundle.getString("user.address")%> <input type="text" name="address">
        </div>
        <div class="form-element"><%=bundle.getString("user.phone")%> <input type="text" name="phone"></div>
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
                <th><%=bundle.getString("username")%>
                </th>
                <th><%=bundle.getString("user.firstName")%>
                </th>
                <th><%=bundle.getString("user.lastName")%>
                </th>
                <th><%=bundle.getString("user.birthDate")%>
                </th>
            </tr>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td><a href="/userinfo?id=${item.getUsername()}">${item.getUsername()}</a></td>
                    <td>${item.getFirstname()}</td>
                    <td>${item.getLastname()}</td>
                    <td>${item.getDate()}</td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise></c:choose></c:if>
</body>
</html>
