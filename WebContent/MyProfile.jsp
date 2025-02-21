<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.entity.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            background-color: #ffffff;
            color: #333;
        }
        
        nav {
            background-color: #ff6f00;
            color: #fff;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        nav .logo {
            font-size: 24px;
            font-weight: 600;
        }
        .logo a {
            text-decoration: none;
            color: inherit;
            font-weight: bold;
            font-size: 1.5rem;
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
        }
        nav ul li {
            position: relative;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        nav ul li a:hover {
            color: #fdd835;
        }
        header {
            text-align: center;
            margin: 20px 0;
            font-size: 28px;
            font-weight: 500;
        }
        .profile-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .profile-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-details {
            margin-bottom: 20px;
        }
        .profile-details label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .profile-details input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .profile-actions {
            text-align: center;
        }
        .profile-actions button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            margin: 0 10px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .profile-actions button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function enableEditMode() {
            const inputs = document.querySelectorAll('.profile-details input');
            inputs.forEach(input => input.removeAttribute('readonly'));
            document.getElementById('editBtn').style.display = 'none';
            document.getElementById('updateBtn').style.display = 'inline-block';
        }
    </script>
</head>
<body>
    <jsp:include page="./commons/publicNavBar.jsp"/>

    <%
    	if (session.getAttribute("customer")!=null){
    		Customer customer=(Customer) session.getAttribute("customer");
    %>
    <header>Welcome, <span id="customerName" ><%= customer.getName()%></span></header>
    <div class="profile-container">
        <h2>My Profile</h2>
        <form action="customer" method="post">
            <input type="hidden" value="update" name="action"/>
            <div class="profile-details">
                <label for="name">Name</label>
                <input type="text" id="name" name="customerName" value="<%= customer.getName()%>" readonly>

                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= customer.getEmail()%>" readonly>
                
                <label for="Password">Password</label>
                <input type="password" id="password" name="password" value="<%= customer.getPassword()%>" readonly>
                
                <label for="ContactNumber">Contact Number</label>
                <input type="text" name="contactNumber" id="contactNumber" value="<%= customer.getContactNumber()%>" maxlength="10" readonly>

                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="<%= customer.getAddress()%>" readonly>
            </div>
            <div class="profile-actions">
                <button type="button" id="editBtn" onclick="enableEditMode()">Edit</button>
                <button type="submit" id="updateBtn" style="display: none;">Update</button>
            </div>
        </form>
    </div>
    <%
    }
    else {
        response.sendRedirect("LoginPage.jsp");
    }
    %>
</body>
</html>
