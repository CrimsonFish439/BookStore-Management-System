<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<%@ page import="com.crimsonlogic.bms3.model.Book" %>
<%@ page import="com.crimsonlogic.bms3.dao.BookDao" %>
<%@ page import="com.crimsonlogic.bms3.dao.BookDaoImpl" %>

<%
    // Get the bookId from the request
    String bookIdParam = request.getParameter("bookId");
    int bookId = Integer.parseInt(bookIdParam);

    // Fetch the book details from the database
    BookDao bookDao = new BookDaoImpl();
    Book book = bookDao.getBookById(bookId);

    if (book == null) {
        out.println("<h3>Book not found!</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
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
        }
        .container {
            flex: 1;
        }
        footer {
            background-color: #f8f9fa;
            padding: 10px;
            text-align: center;
            position: relative;
            width: 100%;
            bottom: 0;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            margin: auto;
        }
        .form-container h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .btn-primary {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
    <div class="form-container">
        <h2>Edit Book</h2>
        <form action="<%=request.getContextPath()%>/book?action=update" method="post" class="needs-validation" id="editBookForm" novalidate>
            <input type="hidden" name="bookId" value="<%= request.getParameter("bookId") %>">

            <div class="form-group">
                <label for="title">Book Title:</label>
                <input type="text" id="title" name="title" class="form-control" value="<%= book.getTitle() %>" required>
                <div class="invalid-feedback">Please enter the book title.</div>
            </div>

            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" class="form-control" value="<%= book.getAuthor() %>" required>
                <div class="invalid-feedback">Please enter the author's name.</div>
            </div>

			<div class="form-group">
				<label for="genre">Genre:</label> 
				<input type="text" id="genre" name="genre" class="form-control" value="<%=book.getGenre()%>" required>
				<div class="invalid-feedback">Please enter the genre.</div>
			</div>
			<div class="form-group">
               <label for="price">Price:</label>
               <input type="number" step="0.01" id="price" name="price" class="form-control" value="<%= book.getPrice() %>" required>
               <div class="invalid-feedback">Please enter the price.</div>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" class="form-control" value="<%= book.getQuantity() %>" required>
                <div class="invalid-feedback">Please enter the quantity.</div>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control" rows="4" required><%= book.getDescription() %></textarea>
                <div class="invalid-feedback">Please enter a description for the book.</div>
            </div>

            <button type="submit" class="btn btn-primary">Update Book</button>
        </form>
    </div>
</div>

<script>
    // Custom validation script
    (function () {
        'use strict';

        window.addEventListener('load', function () {
            // Fetch the form we want to apply custom validation to
            var form = document.getElementById('editBookForm');

            form.addEventListener('submit', function (event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            }, false);
        }, false);
    })();
</script>

<%@ include file="/common/footer.jsp" %>
</body>
</html>
