<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="com.dao.ProductDAO" %>
<%@ page import="com.entity.Product" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product Quantity</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
        }

        .container {
            padding: 20px;
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus {
            border-color: #3498db;
            outline: none;
        }

        .submit-button {
            background-color: #2980b9;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #1f6fa5;
        }
    </style>
</head>
<body>
<jsp:include page="./commons/AdminNavBar.jsp" />

<div class="container">
    <h2>Update Product Quantity</h2>
    <%
        String productId = request.getParameter("productId");
        if (productId == null || productId.trim().isEmpty()) {
            out.println("<p>Error: No Product ID provided.</p>");
        } else {
            try {
                // Fetch product details from the database
               	 int id=Integer.parseInt(productId);
                ProductDAO a=new ProductDAO();
                Product product=a.getProductById(id);

                if (product!=null) {
                    String productName = product.getName();
                    double productPrice = product.getPrice();
                    String imgUrl = product.getImgUrl();
                    String productDescription = product.getDescription();
                    int productQuantity = product.getQuantity();
    %>
    <form method="post" action="admin">
     <input type="hidden" name="action" value="UpdateProduct">
        <input type="hidden" name="productId" value="<%= productId %>">
        <div class="form-group">
            <label for="productName">Product Name:</label>
            <input type="text" name="productName" value="<%= productName %>" >
        </div>
        <div class="form-group">
            <label for="productPrice">Product Price:</label>
            <input type="number" name="productPrice" value="<%= productPrice %>">
        </div>
        <div class="form-group">
            <label for="imgUrl">Image URL:</label>
            <input type="text" name="imgUrl" value="<%= imgUrl %>" >
        </div>
        <div class="form-group">
            <label for="productDescription">Product Description:</label>
            <input type="text" name="productDescription" value="<%= productDescription %>" >
        </div>
        <div class="form-group">
            <label for="productQuantity">Current Quantity:</label>
            <input type="number" name="productQuantity" value="<%= productQuantity %>" >
        </div>
        
       
        <button type="submit" class="submit-button">Update Product</button>
    </form>
    <%
                } else {
                    out.println("<p>Error: Product not found.</p>");
                }
                
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</div>
</body>
</html>