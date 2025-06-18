<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>

</head>
<body>
<%
    if(session.getAttribute("username")==null){
        response.sendRedirect("pages/login.jsp");
    }else{
        response.sendRedirect("pages/dashboard.jsp");
    }
%>
</body>
</html>