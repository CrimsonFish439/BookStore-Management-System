<%@ include file="/common2/userHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Wallet</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            background-image: url('https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=1356&h=668&fit=crop'); /* Add relevant background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .wallet-container {
            background-color: rgba(255, 255, 255, 0.85); /* Semi-transparent background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.2);
            margin-top: 40px;
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            backdrop-filter: blur(10px);
        }

        .wallet-balance {
            font-size: 30px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 30px;
            text-align: center;
        }

        .form-box {
            margin-bottom: 25px;
        }

        .wallet-success, .wallet-error {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .wallet-success {
            color: green;
        }

        .wallet-error {
            color: red;
        }

        .form-group label {
            font-size: 16px;
            font-weight: bold;
        }

        .form-group input {
            height: 40px;
            padding: 10px;
            font-size: 16px;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group input:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }

        .btn-success {
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            padding: 12px;
            font-size: 18px;
            width: 100%;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
            border-radius: 5px;
            padding: 12px;
            font-size: 18px;
            width: 100%;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

    </style>
</head>
<body>

    <div class="container wallet-container">
        <h2 class="wallet-balance">Wallet Balance: $<c:out value="${wallet.balance}" /></h2>

        <!-- Success/Error messages -->
        <c:if test="${param.success == 'addFunds'}">
            <p class="wallet-success">Funds added successfully!</p>
        </c:if>
        <c:if test="${param.error == 'addFunds'}">
            <p class="wallet-error">Failed to add funds. Please try again.</p>
        </c:if>
        <c:if test="${param.error == 'invalidAmount'}">
            <p class="wallet-error">Invalid amount. Please enter a valid amount greater than 0.</p>
        </c:if>

        <div class="row">
            <div class="col-md-6 form-box">
                <form action="${pageContext.request.contextPath}/wallet?action=addFunds" method="post" class="needs-validation" novalidate>
                    <div class="form-group">
                        <label for="amount">Amount to Add:</label>
                        <input type="number" id="amount" name="amount" class="form-control" step="0.01" min="1" required>
                        <div class="invalid-feedback">Please enter a valid amount.</div>
                    </div>
                    <button type="submit" class="btn btn-success">Add Funds</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Bootstrap validation script
        (function () {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
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

        // Frontend validation for amounts
        document.getElementById('amount').addEventListener('input', function (e) {
            if (e.target.value <= 0) {
                e.target.setCustomValidity('Please enter a valid amount greater than 0');
            } else {
                e.target.setCustomValidity('');
            }
        });
    </script>

<%@ include file="/common2/userFooter.jsp" %>
</body>
</html>
