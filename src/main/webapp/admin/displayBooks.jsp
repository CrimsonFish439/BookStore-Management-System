<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/common/header.jsp" %>
<%@ page import="com.crimsonlogic.bms3.model.Book" %>
<%@ page import="com.crimsonlogic.bms3.dao.BookDao" %>
<%@ page import="com.crimsonlogic.bms3.dao.BookDaoImpl" %>
<%@ page import="java.util.List" %>

<%
    // Fetch the list of books from the database
    BookDao bookDao = new BookDaoImpl();
    List<Book> books = bookDao.getAllBooks();
    request.setAttribute("books", books);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book List</title>
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
            background-image: url('https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=1356&h=668&fit=crop'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }
        .container {
            flex: 1;
            padding: 40px;
            max-width: 1200px;
            margin: auto;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
            font-size: 28px;
        }

        .table-container {
            background-color: rgba(255, 255, 255, 0.75);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        .table {
            width: 100%;
            border-radius: 5px;
            overflow: hidden;
            margin-top: 20px;
        }

        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 15px;
        }

        .table td {
            text-align: center;
            padding: 15px;
            font-size: 14px;
        }

        .table tr:nth-child(even) {
            background-color: #dbe9f1; /* Light blue for even rows */
        }

        .table tr:nth-child(odd) {
            background-color: #f1f7fb; /* Slightly lighter blue for odd rows */
        }

        .btn-warning {
            background-color: #ffc107;
            color: white;
            border: none;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn {
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 5px;
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
        }
    </style>
</head>
<body>

<div class="container">
    <div class="table-container">
        <h2 class="text-center">Book List</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Genre</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.genre}</td>
                        <td><fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/></td>
                        <td>${book.quantity}</td>
                        <td>${book.description}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/editBook.jsp?bookId=${book.bookId}" class="btn btn-warning">Edit</a>
                            <a href="${pageContext.request.contextPath}/book?action=delete&bookId=${book.bookId}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this book?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
</body>
</html>
