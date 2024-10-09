<%@ include file="/common2/userHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Rentals</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        .rental-container {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .rental-header {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .table {
            width: 100%;
        }
        .table th, .table td {
            text-align: center;
        }
        .btn-return {
            background-color: #28a745;
            color: white;
        }
        .btn-return:hover {
            background-color: #218838;
        }
        .overdue {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container rental-container">
        <h2 class="rental-header">Your Rentals</h2>

        <c:if test="${empty rentals}">
            <p>You currently have no rented books.</p>
        </c:if>

        <c:if test="${not empty rentals}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Book Title</th>
                        <th>Rental Start Date</th>
                        <th>Due Date</th>
                        <th>Late Fee</th>
                        <th>Return</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="rental" items="${rentals}">
                        <tr>
                            <td>${rental.bookTitle}</td>
                            <td><fmt:formatDate value="${rental.rentalDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <fmt:formatDate value="${rental.dueDate}" pattern="yyyy-MM-dd"/>
                                <c:if test="${rental.isOverdue}">
                                    <span class="overdue">(Overdue)</span>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${rental.fine > 0}">
                                    $<fmt:formatNumber value="${rental.fine}" minFractionDigits="2"/>
                                </c:if>
                                <c:if test="${rental.fine == 0}">
                                    No fine
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${rental.isReturned == false}">
                                    <form action="${pageContext.request.contextPath}/rental" method="get">
                                        <input type="hidden" name="action" value="return"/>
                                        <input type="hidden" name="rentalId" value="${rental.rentalId}"/>
                                        <button type="submit" class="btn btn-return">Return Book</button>
                                    </form>
                                </c:if>
                                <c:if test="${rental.isReturned == true}">
                                    Returned
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

<%@ include file="/common2/userFooter.jsp" %>
</body>
</html>
