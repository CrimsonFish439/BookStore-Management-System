<%@ include file="/common2/userHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
        <h2>Your Cart</h2>
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
                                        <input type="number" name="quantity" value="${book.quantity}" min="1" class="form-control" style="width: 70px;">
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
