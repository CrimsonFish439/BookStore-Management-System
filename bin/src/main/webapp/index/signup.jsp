<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <style>
        body {
            background-color: #f7f7f7;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        .form-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .form-box {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        .form-box h3 {
            margin-bottom: 20px;
            text-align: center;
        }
        .form-footer {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }
        .form-footer a {
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
        }
        .form-footer a:hover {
            text-decoration: underline;
        }
        footer {
            position: relative;
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
    <div class="form-container">
        <div class="form-box">
            <h3>Sign Up</h3>
            <form id="signupForm" action="<%=request.getContextPath()%>/signup" method="post" class="needs-validation" novalidate>
                <div class="form-group">
                    <label for="signup-firstname">First Name:</label>
                    <input type="text" id="signup-firstname" name="firstname" class="form-control" required>
                    <div class="invalid-feedback">Please enter your first name.</div>
                </div>

                <div class="form-group">
                    <label for="signup-lastname">Last Name:</label>
                    <input type="text" id="signup-lastname" name="lastname" class="form-control" required>
                    <div class="invalid-feedback">Please enter your last name.</div>
                </div>

                <div class="form-group">
                    <label for="signup-email">Email:</label>
                    <input type="email" id="signup-email" name="email" class="form-control" required>
                    <div class="invalid-feedback">Please enter a valid email.</div>
                </div>

                <div class="form-group">
                    <label for="signup-password">Password:</label>
                    <input type="password" id="signup-password" name="password" class="form-control" required>
                    <div class="invalid-feedback">
                        Password must be at least 8 characters long, contain at least one special character, one number, and one uppercase letter.
                    </div>
                </div>

                <div class="form-group">
                    <label for="signup-confirm-password">Confirm Password:</label>
                    <input type="password" id="signup-confirm-password" name="confirmPassword" class="form-control" required>
                    <div class="invalid-feedback">Passwords do not match.</div>
                </div>

                <div class="form-group">
                    <label for="signup-phone">Phone Number:</label>
                    <input type="tel" id="signup-phone" name="phone" class="form-control" pattern="^\d{10}$" required>
                    <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
                </div>

                <button type="submit" class="btn btn-primary">Sign Up</button>

                <div class="form-footer mt-3">
                    <a href="signin.jsp">Already have an account? Sign In</a>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %>

    <script>
        // Custom password validation
        const password = document.getElementById('signup-password');
        const confirmPassword = document.getElementById('signup-confirm-password');

        function validatePasswordStrength() {
            const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordPattern.test(password.value)) {
                password.setCustomValidity("Password must be at least 8 characters long, contain at least one special character, one number, and one uppercase letter.");
            } else {
                password.setCustomValidity("");
            }
        }

        function validatePasswordMatch() {
            if (password.checkValidity() && password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity("Passwords do not match");
            } else {
                confirmPassword.setCustomValidity("");
            }
        }

        password.addEventListener('input', function() {
            validatePasswordStrength();
            validatePasswordMatch(); // Revalidate the confirm password when the password changes
        });

        confirmPassword.addEventListener('input', validatePasswordMatch);

        // Bootstrap form validation
        (function () {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');

            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    validatePasswordStrength();
                    validatePasswordMatch();

                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }

                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>
