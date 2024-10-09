<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.crimsonlogic.bms3.model.User" %>

<c:choose>
    <c:when test="${not empty sessionScope.user}">
        <!-- Display the navigation bar only if the user is logged in -->
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/adminHome.jsp">
                        <img alt="Website Icon" src="<%=request.getContextPath()%>/images/website-icon.png">
                    </a>
                </div>
                <ul class="nav navbar-nav">
                    <li><a href="<%=request.getContextPath()%>/admin/adminHome.jsp">Home</a></li>
                    <li><a href="<%=request.getContextPath()%>/admin/addBook.jsp">Add Book</a></li>
                    <li><a href="<%=request.getContextPath()%>/admin/displayBooks.jsp">View/Edit Books</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="<%=request.getContextPath()%>/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                </ul>
            </div>
        </nav>
    </c:when>
    <c:otherwise>
        <!-- Display a simplified version or nothing if not logged in -->
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">BookStore</a>
                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="<%=request.getContextPath()%>/index/signin.jsp"><span class="glyphicon glyphicon-log-in"></span> Sign In</a></li>
                </ul>
            </div>
        </nav>
    </c:otherwise>
</c:choose>
