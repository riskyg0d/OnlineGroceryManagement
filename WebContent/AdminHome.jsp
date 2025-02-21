<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="com.dao.AdminDAO" %>
<%@ page import="com.entity.Admin" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Homepage</title>
  <style>
  body {
    margin: 0;
    font-family: Arial, sans-serif;
    display: flex;
    color: #333;
    background-color: #f9f9f9;
  }

  .admin-homepage {
    display: flex;
    width: 100%;
  }

  /* Sidebar Styles */
  .sidebar {
    width: 200px;
    background-color: #012f4c;
    color: white;
    padding: 20px;
    height: 100vh;
    position: fixed;
  }

  .sidebar h2 {
    text-align: center;
    margin-bottom: 20px;
  }

  .sidebar ul {
    list-style: none;
    padding: 0;
  }

  .sidebar ul li {
    margin: 15px 0;
  }

  .sidebar ul li a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 10px;
    border-radius: 5px;
  }

  .sidebar ul li a:hover {
    background-color: #03456b;
  }

  /* Main Content Styles */
  .main-content {
    margin-left: 250px;
    padding: 20px;
    width: calc(100% - 250px);
  }

  header {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  header h1 {
    margin: 0;
  }

  header p {
    color: #7ca6c8;
  }

  /* Stats Section */
  .stats {
    display: flex;
    gap: 20px;
    margin-top: 20px;
  }

  .stat-card {
    flex: 1;
    background-color: #012f4c;
    color: white;
    text-align: center;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .stat-card h3 {
    margin: 0 0 10px 0;
  }

  .button-container {
    display: flex;
    flex-direction: row;
    gap: 20px;
    align-items: center;
    margin-top: 20px;
  }

  .button-link {
    text-decoration: none;
    background-color: #03456b;
    color: white;
    padding: 15px 25px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: background-color 0.3s ease, transform 0.2s ease;
  }

  .button-link:hover {
    background-color: #7ca6c8;
    transform: translateY(-3px);
  }

  .button-link:active {
    transform: translateY(1px);
  }

  p {
    margin: 10px;
  }
</style>

</head>
<body>
<%
    if (session.getAttribute("admin") != null) {
        Admin admin = (Admin) session.getAttribute("admin");
        
%>
  <div class="admin-homepage">
    <!-- Sidebar -->
    <div class="sidebar">
      <h2>Admin Panel</h2>
      <ul>
        <p> Admin logged </p>
        <p>ID: <%= admin.getAdminId() %></p>
        <li><a href="AdminLogout.jsp">Logout</a></li>
      </ul>
    </div>
    
<%
    } else {
        response.sendRedirect("AdminLogin.jsp");
    }
%>

    <!-- Main Content -->
    <div class="main-content">
      <header>
        <h1>Welcome, Admin!</h1>
        <p>Here is your dashboard to manage your Grocery Store.</p>
      </header><br><br><br>

<%
    AdminDAO adminDashboardDAO = new AdminDAO();
    int registeredCustomers = 0;
    int totalSales = 0;
    int totalOrders = 0;

    try {
        registeredCustomers = adminDashboardDAO.getRegisteredCustomerCount();
        totalSales = adminDashboardDAO.getTotalSalesAmount();
        totalOrders = adminDashboardDAO.getTotalOrders();
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!-- Stats Section -->
<section class="stats">
  
  <div class="stat-card">
    <h3>Total Orders</h3>
    <p><%= totalOrders %></p>
  </div>
  <div class="stat-card">
    <h3>Total Sales</h3>
    <p>₹ <%= totalSales %></p>
  </div>
  <div class="stat-card">
    <h3>Registered Customers</h3>
    <p><%= registeredCustomers %></p>
  </div>
</section><br><br><br>


      <!-- Quick Links -->
      
      <section class="quick-links">
        <h2>Quick Links</h2>
        
        <div class="button-container">
    		<a href="AddProduct.jsp" class="button-link">Add Product</a>
    		<a href="DisplayOrder.jsp" class="button-link">Orders</a>
    		<a href="ProductManagement.jsp" class="button-link">Products</a>
    		<a href="CustomerManagement.jsp" class="button-link">Customers</a>
  		</div>
        
      </section>
    </div>
  </div>
</body>
</html>