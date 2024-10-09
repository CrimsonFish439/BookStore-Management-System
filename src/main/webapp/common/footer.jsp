<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        footer {
            background-color: rgba(0, 0, 0, 0.8); 
            padding: 20px;
            text-align: center;
            width: 100%;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
            position: relative;
            bottom: 0;
            font-size: 14px;
            color: #fff;
            line-height: 1.5;
        }

        footer p {
            margin: 10px 0;
            color: #ccc;
        }

        footer .footer-content {
            display: flex;
            justify-content: space-between;
            max-width: 1000px;
            margin: 0 auto;
            padding: 10px 0;
            flex-wrap: wrap;
        }

        footer .footer-section {
            flex: 1;
            padding: 10px;
            min-width: 250px;
        }

        footer h4 {
            font-size: 16px;
            color: #f1f1f1;
            font-weight: bold;
            margin-bottom: 10px;
        }

        footer p, footer a {
            color: #ccc;
        }

        footer a {
            text-decoration: none;
            font-weight: bold;
        }

        footer a:hover {
            color: #ff9800;
            text-decoration: underline;
        }

        footer .social-icons a {
            margin: 0 10px;
            font-size: 18px;
            color: #ccc;
        }

        footer .social-icons a:hover {
            color: #ff9800;
        }

        footer .contact-info p {
            margin: 5px 0;
        }

        footer .social-icons {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <footer>
        <p>&copy; 2024 BookStore Management System. All rights reserved.</p>

        <div class="footer-content">
            <div class="footer-section">
                <h4>About Us</h4>
                <p>Welcome to BookStore Management System, your one-stop shop for all things related to book management. We provide a comprehensive platform for users to manage, buy, and rent books, offering a seamless experience for both administrators and customers.</p>
            </div>

            <div class="footer-section contact-info">
                <h4>Contact Us</h4>
                <p>Email: support@bookstore.com</p>
                <p>Phone: +91 8020827367</p>
                <p>Address: 123, Summit B, 7th Floor, Brigade Metropolis, Bengaluru</p>
            </div>
        </div>

        <div class="social-icons">
            <a href="#"><i class="fa fa-facebook"></i> Facebook</a>
            <a href="#"><i class="fa fa-twitter"></i> Twitter</a>
            <a href="#"><i class="fa fa-linkedin"></i> LinkedIn</a>
        </div>
    </footer>

    
</body>
</html>
