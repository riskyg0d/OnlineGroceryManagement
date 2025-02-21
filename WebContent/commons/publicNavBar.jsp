<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Grocery Store</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            padding-top: 60px; /* Prevent content from hiding behind the fixed navbar */
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Navbar Styling */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(to right, #03456B, #012f4c);
            color: white;
            padding: 10px 20px;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar .logo {
            font-size: 1.5rem; /* Smaller font size for logo */
            font-weight: bold;
        }

        .navbar .logo a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .navbar .logo a:hover {
            color: #7ca6c8;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 15px; /* Reduced gap for a compact look */
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 0.9rem; /* Smaller font size for links */
            font-weight: 500; /* Slightly lighter weight */
            padding: 8px 12px; /* Reduced padding for a clean look */
            border-radius: 4px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: #7ca6c8; /* Hover effect with light blue */
            color: #012f4c;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }
            .nav-links {
                flex-direction: column;
                width: 100%;
                gap: 10px;
            }
            .nav-links a {
                display: block;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <nav class="navbar">
                <div class="logo">
                    <a href="WelcomePage.jsp">FreshMart</a>
                </div>
                <ul class="nav-links">
                    <li><a href="HomePage.jsp">Home</a></li>
                    <li><a href="MyProfile.jsp">My Profile</a></li>
                    <li><a href="Wishlist.jsp">My Wishlist</a></li>
                    <li><a href="Cart.jsp">Cart</a></li>
                    <li><a href="Logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>
