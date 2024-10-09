<%@ include file="/common2/userHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            background-image: url('https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=1356&h=668&fit=crop'); /* Replace with your background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.3);
            margin-top: 50px;
            margin-bottom: 50px;
            max-width: 900px;
            backdrop-filter: blur(8px);
        }

        h2 {
            color: #007bff;
            margin-bottom: 30px;
            text-align: center;
        }

        .alert {
            text-align: center;
            font-size: 16px;
        }

        .table {
            background-color: #f9f9f9;
            border-radius: 5px;
            overflow: hidden;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }

        .form-control {
            display: inline-block;
            width: auto;
            text-align: center;
        }

        .btn-default {
            margin-left: 10px;
        }

        .btn-danger {
            width: 100px;
        }

        h4 {
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
        }

        .btn-success {
            width: 100%;
            font-size: 18px;
            padding: 12px;
            margin-top: 20px;
        }

        .btn-success:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Cart</h2>

        <!-- Display error messages -->
        <c:if test="${param.error == 'quantityExceeded'}">
            <div class="alert alert-danger">You cannot add more than the available quantity.</div>
        </c:if>
        <c:if test="${param.error == 'outOfStock'}">
            <div class="alert alert-danger">This book is out of stock.</div>
        </c:if>
        <c:if test="${param.error == 'insufficientFunds'}">
            <div class="alert alert-danger">You do not have enough balance in your wallet to complete this purchase.</div>
        </c:if>
        <c:if test="${param.error == 'deductionFailed'}">
            <div class="alert alert-danger">There was an issue processing your payment. Please try again later.</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty cart}">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${cart}">
                            <tr>
                                <td>${book.title}</td>
                                <td>${book.author}</td>
                                <td>$${book.price}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart?action=updateQuantity" method="post">
                                        <input type="number" name="quantity" value="${book.quantity}" min="1" class="form-control">
                                        <input type="hidden" name="bookId" value="${book.bookId}">
                                        <button type="submit" class="btn btn-default btn-sm">Update</button>
                                    </form>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&bookId=${book.bookId}" class="btn btn-danger btn-sm">Remove</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <h4>Total: $<c:out value="${totalPrice}" /></h4>

                <form action="${pageContext.request.contextPath}/cart?action=buy" method="post">
                    <button type="submit" class="btn btn-success">Buy Now</button>
                </form>
            </c:when>
            <c:otherwise>
                <p>Your cart is empty.</p>
            </c:otherwise>
        </c:choose>
    </div>

<%@ include file="/common2/userFooter.jsp" %>
</body>
</html>
