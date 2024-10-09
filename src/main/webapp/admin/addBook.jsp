<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
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

        .form-container {
            flex: 1;
            background-color: rgba(255, 255, 255, 0.85); /* Semi-transparent white background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            margin: 100px auto; /* Adds margin to center the form vertically */
        }

        .form-container h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 20px;
            background-color: #007bff;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-primary:disabled {
            background-color: grey;
            cursor: not-allowed;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group input, .form-group textarea, .form-group select {
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 14px;
            width: 100%;
        }

        .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }

        .help-block {
            color: red;
            display: none;
            font-size: 12px;
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
    <div class="scrollable-content">
        <div class="form-container">
            <h2>Add a New Book</h2>

            <form id="addBookForm" action="<%=request.getContextPath()%>/book?action=add" method="post">
                <div class="form-group">
                    <label for="title">Book Title:</label>
                    <input type="text" id="title" name="title" class="form-control">
                    <span class="help-block">Book title must be at least 3 characters long.</span>
                </div>

                <div class="form-group">
                    <label for="author">Author:</label>
                    <input type="text" id="author" name="author" class="form-control">
                    <span class="help-block">Author name must be at least 3 characters long and contain no numbers.</span>
                </div>

                <div class="form-group">
                    <label for="genre">Genre:</label>
                    <select id="genre" name="genre" class="form-control">
                        <option value="" disabled selected>Select genre</option>
                        <option value="Fiction">Fiction</option>
                        <option value="Non-Fiction">Non-Fiction</option>
                        <option value="Science Fiction">Science Fiction</option>
                        <option value="Fantasy">Fantasy</option>
                        <option value="Mystery">Mystery</option>
                    </select>
                    <span class="help-block">Please select a genre.</span>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" step="0.01" id="price" name="price" class="form-control">
                    <span class="help-block">Please enter a valid price greater than 0.</span>
                </div>

                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control">
                    <span class="help-block">Please enter a valid quantity (must be a positive number).</span>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" class="form-control" rows="4"></textarea>
                    <span class="help-block">Description must be at least 10 characters long.</span>
                </div>

                <button type="submit" class="btn btn-primary" id="submitButton" disabled>Add Book</button>
            </form>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('addBookForm');
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
            const isValidGenre = () => genre.value !== '';
            const isValidPrice = () => parseFloat(price.value) > 0;
            const isValidQuantity = () => parseInt(quantity.value) > 0;
            const isValidDescription = () => description.value.trim().length >= 10;

            // Field validation triggers based on interaction
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
                    helpBlock.style.display = 'block'; // Only show error if the field has been interacted with
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
                title.addEventListener('input', function() {
                    fieldInteractionTracker.title = true;
                    validateForm();
                });

                author.addEventListener('input', function() {
                    fieldInteractionTracker.author = true;
                    validateForm();
                });

                genre.addEventListener('change', function() {
                    fieldInteractionTracker.genre = true;
                    validateForm();
                });

                price.addEventListener('input', function() {
                    fieldInteractionTracker.price = true;
                    validateForm();
                });

                quantity.addEventListener('input', function() {
                    fieldInteractionTracker.quantity = true;
                    validateForm();
                });

                description.addEventListener('input', function() {
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
</body>
</html>
