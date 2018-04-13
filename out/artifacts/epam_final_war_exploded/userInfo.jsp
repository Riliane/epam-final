<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Nana
  Date: 26.01.2018
  Time: 11:43
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
    <title><%=bundle.getString("userInfo")%>
    </title>
    <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<body>
<c:choose><c:when test="${user == null}">
    <div class="error-message"><%=bundle.getString("userNotFound")%>
    </div>
</c:when>
    <c:otherwise>
        <h2><%=bundle.getString("userInfo")%>
        </h2>
        <table class="restable"><tr>
            <td><%=bundle.getString("username")%>
            </td>
            <td>${user.getUsername()}</td>
        </tr> <tr>
            <td><%=bundle.getString("role")%>
            </td>
            <td>
                <c:choose><c:when test="${user.getRole() == 'reader'}"><%=bundle.getString("role.reader")%>
                </c:when>
                    <c:when test="${user.getRole() == 'librarian'}"><%=bundle.getString("role.librarian")%>
                    </c:when>
                    <c:when test="${user.getRole() == 'admin'}"><%=bundle.getString("role.admin")%>
                    </c:when>
                </c:choose>
            </td></tr>
            <c:if test="${user.getRole() == 'reader'}"><tr>
                <td><%=bundle.getString("user.firstName")%>
                </td>
                <td>${user.getFirstname()}</td>
            </tr><tr>
                <td><%=bundle.getString("user.lastName")%>
                </td>
                <td>${user.getLastname()}</td>
            </tr><tr>
                <td><%=bundle.getString("user.birthDate")%>
                </td>
                <td>${user.getDate()}</td>
            </tr><tr>
                <td><%=bundle.getString("user.address")%>
                </td>
                <td>${user.getAddress()}</td>
            </tr><tr>
                <td><%=bundle.getString("user.phone")%>
                </td>
                <td>${user.getPhone()}</td>
            </tr></c:if>
        </table>
        <c:if test="${currentList != null && !currentList.isEmpty()}">
            <h2><%=bundle.getString("borrowedDocuments")%></h2><br>
            <table class="restable"><tr>
                <th><%=bundle.getString("document.title")%></th>
                <th><%=bundle.getString("document.author")%></th>
                <th><%=bundle.getString("dateOfBorrow")%></th>
                <th><%=bundle.getString("dateOfReturn")%></th>
            </tr>
            <c:forEach items="${currentList}" var="item"><tr>
                    <td><a href="document?id=${item.getDocument().getId()}">${item.getDocument().getName()}</a></td>
                    <td>${item.getDocument().getAuthor()}</td>
                    <td>${item.getDateOfBorrow()}</td>
                    <td>${item.getDateOfReturn()}</td>
                </tr></c:forEach>
            </table>
        </c:if>
        <c:if test="${archiveList != null && !archiveList.isEmpty()}">
            <h2><%=bundle.getString("borrowHistory")%></h2><br>
            <table class="restable"><tr>
                <th><%=bundle.getString("document.title")%></th>
                <th><%=bundle.getString("document.author")%></th>
                <th><%=bundle.getString("dateOfBorrow")%></th>
                <th><%=bundle.getString("dateOfReturn")%></th>
            </tr>
                <c:forEach items="${archiveList}" var="item"><tr>
                    <td><a href="document?id=${item.getDocument().getId()}">${item.getDocument().getName()}</a></td>
                    <td>${item.getDocument().getAuthor()}</td>
                    <td>${item.getDateOfBorrow()}</td>
                    <td>${item.getDateOfReturn()}</td>
                </tr></c:forEach>
            </table>
        </c:if>
        <c:if test="${pageContext.request.isUserInRole('admin') || pageContext.request.remoteUser == user.getUsername()}">
            <a class="button" href="changePassword.jsp?id=${user.getUsername()}"><%=bundle.getString("changePassword")%>
            </a>
        </c:if>
        <c:if test="${pageContext.request.isUserInRole('admin')}"><a class="button"
                                                                     href="admin/deleteUser.jsp?id=${user.getUsername()}"><%=bundle.getString("delete")%>
        </a> </c:if>

    </c:otherwise></c:choose>

</body>
</html>
