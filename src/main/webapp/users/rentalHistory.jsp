<%@ include file="/common2/userHeader.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rental History</title>
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

        .container {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.2);
            margin-top: 60px;
            margin-bottom: 40px;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }

        h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
        }

        .alert {
            text-align: center;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            text-align: left;
            padding: 12px;
        }

        thead {
            background-color: #007bff;
            color: white;
        }

        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tbody tr:nth-child(odd) {
            background-color: #e9ecef;
        }

        tbody tr:hover {
            background-color: #cce5ff;
        }

        th {
            background-color: #007bff;
            color: white;
            font-size: 16px;
        }

        td {
            font-size: 15px;
            color: #333;
        }

        button.btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            font-size: 14px;
        }

        button.btn-primary:hover {
            background-color: #0056b3;
        }

        p {
            color: #555;
            text-align: center;
            font-size: 16px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Rental History</h2>

        <!-- Success/Error messages -->
        <c:if test="${param.success == 'returnSuccess'}">
            <div class="alert alert-success">Book returned successfully!</div>
        </c:if>
        <c:if test="${param.error == 'returnFailed'}">
            <div class="alert alert-danger">Failed to return the book. Please try again.</div>
        </c:if>

        <!-- Table for Rental History -->
        <c:if test="${not empty rentals}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Rental ID</th>
                        <th>Book ID</th>
                        <th>Rental Start</th>
                        <th>Due Date</th>
                        <th>Return Date</th>
                        <th>Fine</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="rental" items="${rentals}">
                        <tr>
                            <td>${rental.rentalId}</td>
                            <td>${rental.bookId}</td>
                            <td>${rental.rentalStart}</td>
                            <td>${rental.rentalDue}</td>
                            <td><c:choose>
                                    <c:when test="${rental.rentalReturned != null}">
                                        ${rental.rentalReturned}
                                    </c:when>
                                    <c:otherwise>
                                        Not Returned Yet
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${rental.fine}</td>
                            <td>${rental.status}</td>
                            <td>
                                <!-- Show Return button only if the book is not returned yet -->
                                <c:if test="${rental.status == 'active'}">
                                    <form action="${pageContext.request.contextPath}/rental" method="post">
                                        <input type="hidden" name="action" value="returnBook">
                                        <input type="hidden" name="rentalId" value="${rental.rentalId}">
                                        <button type="submit" class="btn btn-primary">Return Book</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- No rentals found message -->
        <c:if test="${empty rentals}">
            <p>No rentals found.</p>
        </c:if>
    </div>

    <%@ include file="/common2/userFooter.jsp"%>
</body>
</html>
