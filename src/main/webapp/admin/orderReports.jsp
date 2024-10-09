<%@ include file="/common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Reports</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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

        .container {
            background-color: rgba(255, 255, 255, 0.75);
            padding-top: 100px;
            padding-bottom: 50px;
            border-radius: 10px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
            margin-top: 80px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 28px;
            text-align: center;
        }

        h3, h4 {
            color: #333;
            text-align: center;
        }

        .btn {
            margin-top: 20px;
            width: 100%;
            font-size: 16px;
            padding: 12px;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .table-container {
            margin-top: 20px;
            background-color: rgba(0, 0, 0, 0.05);
            padding-top: 20px;
            padding-bottom: 50px;
            border-radius: 10px;
        }

        .form-group label {
            font-weight: bold;
            color: #333;
        }

        .form-control {
            padding: 12px;
            font-size: 16px;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Order Reports</h2>
    <form action="${pageContext.request.contextPath}/orderReports" method="post">
        <div class="form-group">
            <label for="month">Select Month:</label>
            <select name="month" id="month" class="form-control">
                <option value="1">January</option>
                <option value="2">February</option>
                <option value="3">March</option>
                <option value="4">April</option>
                <option value="5">May</option>
                <option value="6">June</option>
                <option value="7">July</option>
                <option value="8">August</option>
                <option value="9">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
            </select>
        </div>
        <div class="form-group">
            <label for="year">Select Year:</label>
            <input type="number" name="year" id="year" class="form-control" min="2000" max="${currentYear}">
        </div>
        <button type="submit" class="btn btn-primary">Generate Report</button>
    </form>

    <c:if test="${not empty orders}">
        <h3>Orders for ${selectedMonth}/${selectedYear}</h3>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Book ID</th>
                    <th>Order Date</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.userId}</td>
                        <td>${order.bookId}</td>
                        <td>${order.orderDate}</td>
                        <td>${order.price}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <h4>Total Revenue: $<c:out value="${totalRevenue}" /></h4> 
    </c:if>

    <c:if test="${empty orders}">
        <p>No orders found for the selected month and year.</p>
    </c:if>
</div>

<%@ include file="/common/footer.jsp" %>
</body>
</html>
