<%@ include file="/common2/userHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Checkout</h2>

        <!-- Error Handling -->
        <c:if test="${param.error == 'insufficientFunds'}">
            <div class="alert alert-danger">Insufficient funds in your wallet.</div>
        </c:if>
        <c:if test="${param.error == 'deductionFailed'}">
            <div class="alert alert-danger">There was an issue processing your wallet payment. Please try again.</div>
        </c:if>
        <c:if test="${param.error == 'invalidCard'}">
            <div class="alert alert-danger">Invalid card details. Please try again.</div>
        </c:if>

        <!-- Checkout Form -->
        <form action="${pageContext.request.contextPath}/processPayment" method="post">
            <div class="form-group">
                <label for="paymentMethod">Select Payment Method:</label>
                <div class="radio">
                    <label><input type="radio" name="paymentMethod" value="wallet" checked> Wallet</label>
                </div>
                <div class="radio">
                    <label><input type="radio" name="paymentMethod" value="card"> Credit/Debit Card</label>
                </div>
            </div>

            <!-- Card Payment Details (only shown if card is selected) -->
            <div id="cardDetails" style="display:none;">
                <div class="form-group">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber" class="form-control">
                </div>
                <div class="form-group">
                    <label for="expiryDate">Expiry Date:</label>
                    <input type="text" id="expiryDate" name="expiryDate" class="form-control">
                </div>
                <div class="form-group">
                    <label for="cvv">CVV:</label>
                    <input type="text" id="cvv" name="cvv" class="form-control">
                </div>
            </div>

            <button type="submit" class="btn btn-primary">Confirm Purchase</button>
        </form>
    </div>

    <script>
    // Toggle card details visibility
    document.querySelector('input[value="card"]').addEventListener('change', function() {
        document.getElementById('cardDetails').style.display = 'block';
    });
    document.querySelector('input[value="wallet"]').addEventListener('change', function() {
        document.getElementById('cardDetails').style.display = 'none';
    });

    // Ensure card fields are validated if card is selected
    document.querySelector('form').addEventListener('submit', function(event) {
        if (document.querySelector('input[value="card"]').checked) {
            if (!document.getElementById('cardNumber').value || !document.getElementById('expiryDate').value || !document.getElementById('cvv').value) {
                event.preventDefault();
                alert("Please fill out all card details.");
            }
        }
    });
</script>


<%@ include file="/common2/userFooter.jsp" %>
</body>
</html>
