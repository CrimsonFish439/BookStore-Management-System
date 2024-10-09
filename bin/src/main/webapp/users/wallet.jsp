<%@ include file="/common2/userHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Wallet</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Wallet Balance: ₹<c:out value="${wallet.balance}" /></h2>
        <form action="<%=request.getContextPath()%>/wallet" method="post">
            <input type="hidden" name="action" value="addFunds">
            <div class="form-group">
                <label for="amount">Amount to Add:</label>
                <input type="number" id="amount" name="amount" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Add Funds</button>
        </form>
        <form action="<%=request.getContextPath()%>/wallet" method="post">
            <input type="hidden" name="action" value="deductFunds">
            <div class="form-group">
                <label for="deductAmount">Amount to Deduct:</label>
                <input type="number" id="deductAmount" name="amount" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-danger">Deduct Funds</button>
        </form>
    </div>

<%@ include file="/common2/userFooter.jsp" %>
</body>
</html>
