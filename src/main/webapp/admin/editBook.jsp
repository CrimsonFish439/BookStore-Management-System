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
        .help-block {
            color: red;
            display: none;
            font-size: 12px;
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
                    <span class="help-block">Please enter the book title (minimum 3 characters).</span>
                </div>

                <div class="form-group">
                    <label for="author">Author:</label>
                    <input type="text" id="author" name="author" class="form-control" value="<%= book.getAuthor() %>" required>
                    <span class="help-block">Please enter the author's name (minimum 3 characters).</span>
                </div>

                <div class="form-group">
                    <label for="genre">Genre:</label>
                    <input type="text" id="genre" name="genre" class="form-control" value="<%=book.getGenre()%>" required>
                    <span class="help-block">Please enter the genre.</span>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" step="0.01" id="price" name="price" class="form-control" value="<%= book.getPrice() %>" required>
                    <span class="help-block">Please enter a valid price greater than 0.</span>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" value="<%= book.getQuantity() %>" required>
                    <span class="help-block">Please enter the quantity (must be positive).</span>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" class="form-control" rows="4" required><%= book.getDescription() %></textarea>
                    <span class="help-block">Please enter a description (minimum 10 characters).</span>
                </div>

                <button type="submit" class="btn btn-primary" id="submitButton" disabled>Update Book</button>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('editBookForm');
            const title = document.getElementById('title');
            const author = document.getElementById('author');
            const genre = document.getElementById('genre');
            const price = document.getElementById('price');
            const quantity = document.getElementById('quantity');
            const description = document.getElementById('description');
            const submitButton = document.getElementById('submitButton');

            // Validation Functions
            const isValidTitle = () => title.value.trim().length >= 3;
            const isValidAuthor = () => /^[A-Za-z\s]{3,}$/.test(author.value.trim());
            const isValidGenre = () => genre.value.trim() !== '';
            const isValidPrice = () => parseFloat(price.value) > 0;
            const isValidQuantity = () => parseInt(quantity.value) > 0;
            const isValidDescription = () => description.value.trim().length >= 10;

            // Field interaction tracker
            const fieldInteractionTracker = {
                title: false,
                author: false,
                genre: false,
                price: false,
                quantity: false,
                description: false,
            };

            // Helper function to show/hide error message
            const validateField = (field, validationFunc, fieldName) => {
                const helpBlock = field.nextElementSibling;
                if (validationFunc()) {
                    helpBlock.style.display = 'none';
                    return true;
                } else if (fieldInteractionTracker[fieldName]) {
                    helpBlock.style.display = 'block'; // Only show error if field has been interacted with
                    return false;
                }
                return false;
            };

            // Validate all fields and enable/disable the submit button
            const validateForm = () => {
                const titleValid = validateField(title, isValidTitle, 'title');
                const authorValid = validateField(author, isValidAuthor, 'author');
                const genreValid = validateField(genre, isValidGenre, 'genre');
                const priceValid = validateField(price, isValidPrice, 'price');
                const quantityValid = validateField(quantity, isValidQuantity, 'quantity');
                const descriptionValid = validateField(description, isValidDescription, 'description');

                // Enable submit button if all fields are valid
                submitButton.disabled = !(titleValid && authorValid && genreValid && priceValid && quantityValid && descriptionValid);
            };

            // Add event listeners to track interaction and validate on blur or change
            const setupValidationListeners = () => {
                title.addEventListener('input', function () {
                    fieldInteractionTracker.title = true;
                    validateForm();
                });

                author.addEventListener('input', function () {
                    fieldInteractionTracker.author = true;
                    validateForm();
                });

                genre.addEventListener('input', function () {
                    fieldInteractionTracker.genre = true;
                    validateForm();
                });

                price.addEventListener('input', function () {
                    fieldInteractionTracker.price = true;
                    validateForm();
                });

                quantity.addEventListener('input', function () {
                    fieldInteractionTracker.quantity = true;
                    validateForm();
                });

                description.addEventListener('input', function () {
                    fieldInteractionTracker.description = true;
                    validateForm();
                });
            };

            setupValidationListeners();

            // Final validation on form submit
            form.addEventListener('submit', function (event) {
                validateForm();
                if (submitButton.disabled) {
                    event.preventDefault(); // Prevent form submission if any field is invalid
                }
            });
        });
    </script>

    <%@ include file="/common/footer.jsp" %>
</body>
</
