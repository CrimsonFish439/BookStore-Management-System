<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <!-- Bootstrap CSS for styling only -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
        integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
        crossorigin="anonymous">
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

        /* Ensure some padding around the form */
        .form-container {
            padding-top: 150px; /* Adjust to increase/decrease space from the top */
            padding-bottom: 50px; /* Space between the form and the footer */
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-box {
            background-color: rgba(255, 255, 255, 0.75); /* Semi-transparent background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .form-box h3 {
            margin-bottom: 25px;
            font-size: 24px;
            color: #333;
            text-align: center;
            font-weight: bold;
        }

        .form-group label {
            color: #555;
            font-size: 14px;
            font-weight: bold;
        }

        .form-group input {
            height: 40px;
            padding: 10px;
            font-size: 14px;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group input:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }

        .help-block {
            display: none;
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            margin-top: 15px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .form-footer {
            margin-top: 20px;
            text-align: center;
        }

        .form-footer a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .form-footer a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        footer {
            background-color: rgba(0, 0, 0, 0.8); /* Black with transparency */
            padding: 20px;
            text-align: center;
            width: 100%;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
            bottom: 0;
            font-size: 14px;
            line-height: 1.5;
            color: white;
        }

        footer p {
            margin: 10px 0;
            color: #ccc;
        }

        footer .footer-content {
            display: flex;
            justify-content: space-between;
            max-width: 1000px;
            margin: 0 auto;
            padding: 10px 0;
            flex-wrap: wrap;
        }

        footer .footer-section {
            flex: 1;
            padding: 10px;
            min-width: 250px;
        }

        footer h4 {
            font-size: 16px;
            color: #f1f1f1;
            font-weight: bold;
            margin-bottom: 10px;
        }

        footer a {
            color: #ccc;
            text-decoration: none;
            font-weight: bold;
        }

        footer a:hover {
            color: #ff9800;
            text-decoration: underline;
        }

        footer .social-icons a {
            margin: 0 10px;
            font-size: 18px;
            color: #ccc;
        }

        footer .social-icons a:hover {
            color: #ff9800;
        }
    </style>
</head>
<body>

    <!-- Sign-in form content -->
    <div class="form-container">
        <div class="form-box">
            <h3>Sign In</h3>
            <form id="signinForm" action="<%=request.getContextPath()%>/login" method="post">
                <div class="form-group">
                    <label for="signin-email">Email:</label>
                    <input type="email" id="signin-email" name="email" class="form-control" placeholder="Enter your email">
                    <span class="help-block">Please enter a valid email.</span>
                </div>

                <div class="form-group">
                    <label for="signin-password">Password:</label>
                    <input type="password" id="signin-password" name="password" class="form-control" placeholder="Enter your password">
                    <span class="help-block">Password cannot be empty.</span>
                </div>

                <button type="submit" class="btn btn-primary">Sign In</button>

                <div class="form-footer mt-3">
                    <a href="signup.jsp">Create a new account</a>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %> <!-- Sticky footer is included here -->

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('signinForm');
            const emailField = document.getElementById('signin-email');
            const passwordField = document.getElementById('signin-password');
            const customError = document.getElementById('customError');

            const emailHelpBlock = emailField.nextElementSibling;
            const passwordHelpBlock = passwordField.nextElementSibling;

            // Custom validation function
            const validateField = (field, helpBlock, validationFunc) => {
                if (!validationFunc(field.value)) {
                    helpBlock.style.display = 'block';  // Show help block
                } else {
                    helpBlock.style.display = 'none';  // Hide help block
                }
            };

            // Email validation
            const isValidEmail = (email) => {
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailPattern.test(email);
            };

            // Password validation (only check if it's not empty)
            const isValidPassword = (password) => {
                return password.trim().length > 0;
            };

            // Add input event listeners for real-time validation
            emailField.addEventListener('input', function () {
                validateField(emailField, emailHelpBlock, isValidEmail);
            });

            passwordField.addEventListener('input', function () {
                validateField(passwordField, passwordHelpBlock, isValidPassword);
            });

            form.addEventListener('submit', function (event) {
                // Custom validation on submit
                let isValid = true;

                if (!isValidEmail(emailField.value)) {
                    emailHelpBlock.style.display = 'block';
                    isValid = false;
                }

                if (!isValidPassword(passwordField.value)) {
                    passwordHelpBlock.style.display = 'block';
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                    event.stopPropagation();
                    customError.style.display = 'block';  // Display a custom error message
                } else {
                    customError.style.display = 'none';  // Hide the error if validation passes
                }
            });
            
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('loginError') === 'true') {
                customError.style.display = 'block';
            }
            
        });
        
        
    </script>

</body>
</html>
