<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BookStore Admin</title>
    

    <style>
        .navbar-brand img {
            max-height: 40px;
            margin-top: -10px;
        }
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
            background-color: #f8f9fa;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar-header {
            display: flex;
            align-items: center;
        }
        .navbar-nav {
            margin-top: 5px;
        }
        .navbar-nav > li > a {
            font-size: 16px;
            padding-top: 14px;
            padding-bottom: 14px;
            line-height: 20px;
        }
        .navbar-right {
            margin-right: 0;
        }
        .navbar-right .glyphicon-log-out {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <!-- Display the navigation bar only if the user is logged in -->
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/adminHome.jsp">
                            <img alt="Website Icon" src="<%=request.getContextPath()%>/images/projectbooklogo.png">
                        </a>
                    </div>
                    <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav">
                            <li><a href="<%=request.getContextPath()%>/admin/adminHome.jsp">Home</a></li>
                            <li><a href="<%=request.getContextPath()%>/admin/addBook.jsp">Add Book</a></li>
                            <li><a href="<%=request.getContextPath()%>/admin/displayBooks.jsp">Manage Books</a></li>
                            <li><a href="<%=request.getContextPath()%>/admin/orderReports.jsp">View Order Reports</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="<%=request.getContextPath()%>/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </c:when>
        <c:otherwise>
            <!-- Display a simplified version or nothing if not logged in -->
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">BookStore Admin</a>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="<%=request.getContextPath()%>/index/signin.jsp"><span class="glyphicon glyphicon-log-in"></span> Sign In</a></li>
                    </ul>
                </div>
            </nav>
        </c:otherwise>
    </c:choose>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</html>
