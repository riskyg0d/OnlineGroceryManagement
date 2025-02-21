<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Footer</title>
<style>
    .footer {
        background: #012f4c;
        color: white;
        padding: 40px 20px;
    }

    .footer .container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .footer-content {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 30px;
    }

    .footer-section {
        flex: 1;
        min-width: 250px;
    }

    .footer-section h2 {
        font-size: 1.5rem;
        margin-bottom: 15px;
    }

    .footer-section p,
    .footer-section ul {
        font-size: 0.9rem;
        line-height: 1.6;
    }

    .footer-section ul {
        list-style: none;
        padding: 0;
    }

    .footer-section ul li {
        margin-bottom: 10px;
    }

    .footer-section ul li a {
        text-decoration: none;
        color: #7ca6c8;
        transition: color 0.3s;
    }

    .footer-section ul li a:hover {
        color: #fff;
    }

    .footer-bottom {
        text-align: center;
        padding-top: 20px;
        font-size: 0.8rem;
        border-top: 1px solid #7ca6c8;
        margin: 0 auto;
        width: calc(100% - 40px); /* Makes the line shorter with 20px gap on each side */
        max-width: 1200px; /* Ensures it doesn't stretch too wide on larger screens */
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            gap: 30px;
        }
    }
</style>
</head>
<body>

<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <!-- About Section -->
            <div class="footer-section about">
                <h2>About Us</h2>
                <p>
                    Welcome to FreshMart, your go-to destination for fresh groceries and quality products. 
                    We aim to deliver the best shopping experience right to your doorstep.
                </p>
            </div>
            <!-- Quick Links Section -->
            <div class="footer-section links">
                <h2>Quick Links</h2>
                <ul>
                    <li><a href="HomePage.jsp">Home</a></li>
                    <li><a href="MyProfile.jsp">My Profile</a></li>
                    <li><a href="Wishlist.jsp">Wishlist</a></li>
                    <li><a href="Cart.jsp">Cart</a></li>
                </ul>
            </div>
            <!-- Contact Section -->
            <div class="footer-section contact">
                <h2>Contact Us</h2>
                <p>Email: support@FreshMart.com</p>
                <p>Phone: +91 123 456 7890</p>
                <p>Address: 123 Market Street, Mumbai, India</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 FreshMart. All rights reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>
