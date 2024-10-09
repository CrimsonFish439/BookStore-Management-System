<%@ include file="/common2/userHeader.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            background-image: url('https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=1356&h=668&fit=crop'); /* Add a relevant background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            background: rgba(255, 255, 255, 0.75);
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
            background-color: #dbe9f1;
        }

        tbody tr:nth-child(odd) {
            background-color: #f1f7fb;
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
        <h2>Order History</h2>
        <c:if test="${not empty orders}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Book ID</th>
                        <th>Order Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.bookId}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty orders}">
            <p>No orders found.</p>
        </c:if>
    </div>
    
    <%@ include file="/common2/userFooter.jsp"%>
</body>
</html>
