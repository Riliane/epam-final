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
    <div class="form-element"><%=bundle.getString("userSearch")%> <%=bundle.getString("userByUsername")%> <input
            type="text" name="id"></div>
    <div class="form-element"><input type="submit" value="<%=bundle.getString("submit")%>"/></div>
</form>
</div>
</body>
</html>
