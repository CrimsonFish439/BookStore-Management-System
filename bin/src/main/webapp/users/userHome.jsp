<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.crimsonlogic.bms3.utils.DatabaseConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookstore</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <style>
        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            border-radius: 10px;
        }

        .card:hover {
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.3);
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-weight: bold;
            font-size: 1.25rem;
        }

        .card-subtitle {
            font-size: 1rem;
            color: #6c757d;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        .btn-success:hover {
            background-color: #218838;
        }
        
        .card-text {
        	font-family: "Lucida Console", "Courier New", monospace;
        }
    </style>
</head>
<body>

<jsp:include page="/common2/userHeader.jsp" />

<div class="container mt-4">
<% 
    String success = request.getParameter("success");
    if ("rent".equals(success)) { 
%>
        <div class="alert alert-success" role="alert">
            Book rented successfully!
        </div>
<% 
    } 
%>
    <h2>Welcome to your Book Store!</h2>
    <h2>Books by Genre</h2>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String query = "SELECT * FROM books WHERE genre IS NOT NULL ORDER BY genre, title";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            String currentGenre = "";
            boolean isFirstGenre = true;

            while (rs.next()) {
                String genre = rs.getString("genre");
                
                if (!genre.equals(currentGenre)) {
                    if (!isFirstGenre) {
                        out.println("</div>");
                    }
                    currentGenre = genre;
                    isFirstGenre = false;
                    out.println("<h3 class='mt-5'>" + genre + "</h3>");
                    out.println("<div class='row'>");
                }
    %>

    <div class="col-md-4">
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title"><%= rs.getString("title") %></h5>
                <h6 class="card-subtitle mb-2">by <%= rs.getString("author") %></h6>
                <p class="card-text"><%= rs.getString("description") %></p>
                <p class="card-text">Price: ₹<%= rs.getDouble("price") %></p>
                <p class="card-text">Available: <%= rs.getInt("quantity") %></p>
                <div class="btn-group">
                    <a href="#" class="btn btn-primary">Buy Now</a>
                    <a href="<%=request.getContextPath()%>/rental?action=rent&bookId=<%= rs.getInt("book_id") %>" class="btn btn-secondary">Rent</a>
                    <a href="<%=request.getContextPath()%>/cart?action=add&bookId=<%= rs.getInt("book_id") %>" class="btn btn-success">Add to Cart</a>
                </div>
            </div>
        </div>
    </div>

    <%
            }
            out.println("</div>");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    %>

</div>

<jsp:include page="/common2/userFooter.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
