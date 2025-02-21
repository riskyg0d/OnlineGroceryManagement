<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Grocery Store</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            background-color: #f4f4f9; /* Light background for contrast */
            color: #333;
        }
        nav {
            background-color: #007bff; /* Primary blue color */
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        nav .logo {
            font-size: 1.8rem;
            font-weight: bold;
        }
        nav .logo a {
            text-decoration: none;
            color: #fff;
            transition: color 0.3s ease;
        }
        nav .logo a:hover {
            color: #cce5ff; /* Light blue hover effect */
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
        }
        nav ul li a {
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            font-size: 18px;
            padding: 10px 20px; /* Increased padding for square buttons */
            background-color: transparent;
            border: 2px solid transparent;
            transition: background-color 0.3s ease, color 0.3s ease, border 0.3s ease;
        }
        nav ul li a:hover {
            background-color: #0056b3; /* Darker blue for hover */
            border: 2px solid #0056b3; /* Adds a visible border on hover */
            color: #fff; /* Keep text white */
        }
        header {
            text-align: center;
            margin: 20px 0;
            font-size: 28px;
            font-weight: 500;
            color: #333;
        }
        /* Responsive Design */
        @media (max-width: 768px) {
            nav {
                flex-direction: column;
                align-items: flex-start;
            }
            nav ul {
                flex-direction: column;
                width: 100%;
                gap: 10px;
            }
            nav ul li a {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <a href="WelcomePage.jsp">Online Grocery Store</a>
    </div>
    <ul>
        <li><a href="LoginPage.jsp">Login</a></li>
        <li><a href="RegisterPage.jsp">Register</a></li>
        <li><a href="AdminLogin.jsp">Admin Login</a></li>
    </ul>
</nav>
</body>
</html>
