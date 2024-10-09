<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
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
            <h3>Sign In</h3>
            
            <!-- Displaying an error message if loginError=true -->
            <% if ("true".equals(request.getParameter("loginError"))) { %>
                <div class="alert alert-danger" role="alert">
                    Invalid email or password. Please try again.
                </div>
            <% } %>
            
            <form id="signinForm" action="<%=request.getContextPath()%>/login" method="post" class="needs-validation" novalidate>
                <div class="form-group">
                    <label for="signin-email">Email:</label>
                    <input type="email" id="signin-email" name="email" class="form-control" required>
                    <div class="invalid-feedback">Please enter a valid email.</div>
                </div>

                <div class="form-group">
                    <label for="signin-password">Password:</label>
                    <input type="password" id="signin-password" name="password" class="form-control" required>
                    <div class="invalid-feedback">Please enter your password.</div>
                </div>

                <button type="submit" class="btn btn-primary">Sign In</button>

                <div class="form-footer mt-3">
                    <a href="signup.jsp">Create a new account</a>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %>

    <script>
        (function () {
            'use strict';

            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation');

            // Loop over them and prevent submission if the form is invalid
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
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
