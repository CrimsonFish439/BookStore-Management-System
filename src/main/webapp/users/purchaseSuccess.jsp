<%@ include file="/common2/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Purchase Successful</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Thank You for Shopping with Us!</h2>
        <p>Your purchase has been successfully completed. We hope you enjoy your books!</p>
        <a href="<%= request.getContextPath() %>/users/userHome.jsp" class="btn btn-primary">Continue Shopping</a>
    </div>

<%@ include file="/common2/userFooter.jsp" %>
</body>
</html>
