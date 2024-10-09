<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="com.crimsonlogic.bms3.utils.DatabaseConnection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookstore</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
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
            font-family: 'Arial', sans-serif;
        }

        .container {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.2);
            margin-top: 60px;
            margin-bottom: 60px;
        }

        h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
            font-size: 32px;
        }

        h3 {
            color: #007bff;
            margin-bottom: 25px;
            font-weight: bold;
            font-size: 24px;
            border-bottom: 2px solid #007bff;
            display: inline-block;
        }

        .card {
            background: linear-gradient(to right, #f7f7f7, #ffffff);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease-in-out;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-weight: bold;
            font-size: 1.5rem;
            color: #333;
        }

        .card-subtitle {
            font-size: 1rem;
            color: #555;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 1rem;
            color: #666;
            margin-bottom: 15px;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #0056b3, #004099);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .alert {
            margin-bottom: 20px;
        }

        /* Spacing between rows of books */
        .row {
            margin-bottom: 30px;
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
		<div class="alert alert-success" role="alert">Book rented
			successfully!</div>
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
				out.println("</div>"); // Close the previous row
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
					<h5 class="card-title"><%=rs.getString("title")%></h5>
					<h6 class="card-subtitle mb-2">
						by
						<%=rs.getString("author")%></h6>
					<p class="card-text"><%=rs.getString("description")%></p>
					<p class="card-text">
						Price: $<%=rs.getDouble("price")%></p>
					<p class="card-text">
						Available:
						<%=rs.getInt("quantity")%></p>
					<div class="btn-group">
						<a href="<%=request.getContextPath()%>/cart?action=buy" class="btn btn-primary">Buy Now</a> <a
							href="<%=request.getContextPath()%>/rental?action=rent&bookId=<%=rs.getInt("book_id")%>"
							class="btn btn-secondary">Rent</a> <a
							href="<%=request.getContextPath()%>/cart?action=add&bookId=<%=rs.getInt("book_id")%>"
							class="btn btn-success">Add to Cart</a>
					</div>
				</div>
			</div>
		</div>

		<%
		}
		out.println("</div>"); // Close the last row
		} catch (SQLException e) {
		e.printStackTrace();
		} finally {
		if (rs != null)
		rs.close();
		if (ps != null)
		ps.close();
		if (conn != null)
		conn.close();
		}
		%>
		<script>
			window.onload = function() {
				const urlParams = new URLSearchParams(window.location.search);

				if (urlParams.has('success')) {
					if (urlParams.get('success') === 'rentSuccess') {
						alert("Book rented successfully!");
					}
				}

				if (urlParams.has('error')) {
					if (urlParams.get('error') === 'rentFailed') {
						alert("Failed to rent the book. Please try again.");
					} else if (urlParams.get('error') === 'outOfStock') {
						alert("This book is out of stock.");
					}
				}
			};
		</script>
	</div>

	<jsp:include page="/common2/userFooter.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
