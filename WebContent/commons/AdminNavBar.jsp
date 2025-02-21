<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
        background-color: #f9f9f9;
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
        background: #012f4c; /* Primary background color */
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
        font-size: 1.5rem;
        font-weight: bold;
    }

    .navbar .logo a {
        color: white;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .navbar .logo a:hover {
        color: #7ca6c8; /* Light hover color for the logo */
    }

    .nav-links {
        list-style: none;
        display: flex;
        gap: 15px;
    }

    .nav-links a {
        color: white;
        text-decoration: none;
        font-size: 1rem;
        font-weight: 500;
        padding: 8px 12px;
        border-radius: 4px;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .nav-links a:hover {
        background-color: #03456b; /* Hover background color for links */
        color: #7ca6c8; /* Hover text color */
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
                    <a href="AdminHome.jsp">Admin Dashboard</a>
                </div>
                <ul class="nav-links">
                    <li><a href="AddProduct.jsp">Add Products</a></li>
                    <li><a href="DisplayOrder.jsp">Orders</a></li>
                    <li><a href="ProductManagement.jsp">Products</a></li>
                    <li><a href="CustomerManagement.jsp">Customers</a></li>
                    <li><a href="Logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>
