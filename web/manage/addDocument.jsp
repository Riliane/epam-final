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
    <title><%=bundle.getString("addDocument")%>
    </title>
</head>
<body>
<div class="form-container"><form action="adddocument" method="post">
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
</form></div>
</body>
</html>
