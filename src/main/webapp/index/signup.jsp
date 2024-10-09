<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
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
        }

        .form-container {
            padding-top: 100px;
            padding-bottom: 50px;
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-box {
            background-color: rgba(255, 255, 255, 0.75); 
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
            background-color: #f8f9fa;
            padding: 20px;
            text-align: center;
            width: 100%;
            margin-top: auto;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

    <!-- Form content -->
    <div class="form-container">
        <div class="form-box">
            <h3>Sign Up</h3>
            <form id="signupForm" action="<%=request.getContextPath()%>/signup" method="post">
                <div class="form-group">
                    <label for="signup-firstname">First Name:</label>
                    <input type="text" id="signup-firstname" name="firstname" class="form-control" placeholder="Enter your first name">
                    <span class="help-block">First name must be at least 3 characters long.</span>
                </div>

                <div class="form-group">
                    <label for="signup-lastname">Last Name:</label>
                    <input type="text" id="signup-lastname" name="lastname" class="form-control" placeholder="Enter your last name">
                    <span class="help-block">Please enter your last name.</span>
                </div>

                <div class="form-group">
                    <label for="signup-email">Email:</label>
                    <input type="email" id="signup-email" name="email" class="form-control" placeholder="Enter your email">
                    <span class="help-block">Please enter a valid email.</span>
                </div>

                <div class="form-group">
                    <label for="signup-password">Password:</label>
                    <input type="password" id="signup-password" name="password" class="form-control" placeholder="Enter your password">
                    <span class="help-block">
                        Password must be at least 8 characters long, contain at least one special character, one number, and one uppercase letter.
                    </span>
                </div>

                <div class="form-group">
                    <label for="signup-confirm-password">Confirm Password:</label>
                    <input type="password" id="signup-confirm-password" name="confirmPassword" class="form-control" placeholder="Confirm your password">
                    <span class="help-block">Passwords do not match.</span>
                </div>

                <div class="form-group">
                    <label for="signup-phone">Phone Number:</label>
                    <input type="tel" id="signup-phone" name="phone" class="form-control" placeholder="Enter your phone number">
                    <span class="help-block">Phone number must be 10 digits long and start with 6, 7, 8, or 9.</span>
                </div>

                <button type="submit" class="btn btn-primary">Sign Up</button>

                <div class="form-footer mt-3">
                    <a href="signin.jsp">Already have an account? Sign In</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('signupForm');
            const firstName = document.getElementById('signup-firstname');
            const lastName = document.getElementById('signup-lastname');
            const email = document.getElementById('signup-email');
            const password = document.getElementById('signup-password');
            const confirmPassword = document.getElementById('signup-confirm-password');
            const phone = document.getElementById('signup-phone');

            // Validate first name (at least 3 letters)
            const isValidFirstName = (name) => {
                return /^[A-Za-z]{3,}$/.test(name);
            };

            // Validate email format
            const isValidEmail = (email) => {
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailPattern.test(email);
            };

            // Validate password strength
            const isValidPassword = (password) => {
                const passwordPattern = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                return passwordPattern.test(password);
            };

            // Check if passwords match
            const doPasswordsMatch = (password, confirmPassword) => {
                return password === confirmPassword;
            };

            // Validate phone number (must start with 6, 7, 8, or 9, and be 10 digits)
            const isValidPhoneNumber = (phone) => {
                return /^[6-9]\d{9}$/.test(phone);
            };

            // Helper function to show or hide error messages
            const validateField = (field, helpBlock, validationFunc) => {
                if (!validationFunc(field.value)) {
                    helpBlock.style.display = 'block';  // Show help block
                } else {
                    helpBlock.style.display = 'none';  // Hide help block
                }
            };

            // Real-time validation event listeners
            firstName.addEventListener('input', function () {
                validateField(firstName, firstName.nextElementSibling, isValidFirstName);
            });

            lastName.addEventListener('input', function () {
                validateField(lastName, lastName.nextElementSibling, value => value.trim() !== '');
            });

            email.addEventListener('input', function () {
                validateField(email, email.nextElementSibling, isValidEmail);
            });

            password.addEventListener('input', function () {
                validateField(password, password.nextElementSibling, isValidPassword);
                validateField(confirmPassword, confirmPassword.nextElementSibling, () => doPasswordsMatch(password.value, confirmPassword.value));
            });

            confirmPassword.addEventListener('input', function () {
                validateField(confirmPassword, confirmPassword.nextElementSibling, () => doPasswordsMatch(password.value, confirmPassword.value));
            });

            phone.addEventListener('input', function () {
                validateField(phone, phone.nextElementSibling, isValidPhoneNumber);
            });

            // Form submission validation
            form.addEventListener('submit', function (event) {
                let isValid = true;

                if (!isValidFirstName(firstName.value)) {
                    firstName.nextElementSibling.style.display = 'block';
                    isValid = false;
                }

                if (lastName.value.trim() === '') {
                    lastName.nextElementSibling.style.display = 'block';
                    isValid = false;
                }

                if (!isValidEmail(email.value)) {
                    email.nextElementSibling.style.display = 'block';
                    isValid = false;
                }

                if (!isValidPassword(password.value)) {
                    password.nextElementSibling.style.display = 'block';
                    isValid = false;
                }

                if (!doPasswordsMatch(password.value, confirmPassword.value)) {
                    confirmPassword.nextElementSibling.style.display = 'block';
                    isValid = false;
                }

                if (!isValidPhoneNumber(phone.value)) {
                    phone.nextElementSibling.style.display = 'block';
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                    event.stopPropagation();
                }
            });
        });
    </script>

    <%@ include file="/common/footer.jsp" %>

</body>
</html>
