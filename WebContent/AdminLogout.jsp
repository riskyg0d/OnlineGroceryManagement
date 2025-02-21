<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%
    // Invalidate session
    session.invalidate();

    // Redirect to Welcome page
    response.sendRedirect("WelcomePage.jsp");
%>