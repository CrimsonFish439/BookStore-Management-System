<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
            margin: 0;
            padding-top: 50px;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .btn-group {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }
        .btn-group a {
            width: 30%;
            font-size: 18px;
            padding: 15px;
        }
        .btn-group a i {
            margin-right: 10px;
        }
        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #f8f9fa;
            padding: 10px;
            text-align: center;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>
<div class="container">
    <h2>Welcome, Admin</h2>
    <p>Manage the bookstore from this dashboard.</p>
    
    <div class="btn-group">
        <a href="addBook.jsp" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i> Add New Book
        </a>
        <a href="displayBooks.jsp" class="btn btn-secondary">
            <i class="glyphicon glyphicon-book"></i> View/Edit Books
        </a>
        <a href="logout.jsp" class="btn btn-danger">
            <i class="glyphicon glyphicon-log-out"></i> Logout
        </a>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
</body>
</html>
