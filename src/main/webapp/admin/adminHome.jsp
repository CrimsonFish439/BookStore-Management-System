<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            background-image: url('https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=1356&h=668&fit=crop'); /* Replace with your image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
        }

        .container {
            flex: 1;
            background-color: rgba(255, 255, 255, 0.85); /* Semi-transparent white background */
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 50px auto;
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .btn-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 40px;
        }

        .btn-group a {
            flex-basis: 45%; /* For even spacing */
            font-size: 20px;
            padding: 20px;
            margin-bottom: 20px;
            text-transform: uppercase;
            transition: all 0.3s ease-in-out;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .btn-group a:hover {
            transform: translateY(-5px); /* Subtle hover lift */
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.2);
        }

        .btn-group a i {
            margin-right: 10px;
            font-size: 22px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white; /* Ensuring white text color */
            border: none;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .btn-info {
            background-color: #17a2b8;
            border: none;
        }

        .btn-info:hover {
            background-color: #117a8b;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        footer {
            background-color: #f8f9fa;
            padding: 20px;
            text-align: center;
            width: 100%;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
            bottom: 0;
            font-size: 14px;
            line-height: 1.5;
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
            <i class="glyphicon glyphicon-book"></i> Manage Books
        </a>
        <a href="orderReports.jsp" class="btn btn-info">
            <i class="glyphicon glyphicon-list-alt"></i> View Order Reports
        </a>
        <a href="<%=request.getContextPath()%>/logout" class="btn btn-danger">
            <i class="glyphicon glyphicon-log-out"></i> Logout
        </a>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
</body>
</html>
