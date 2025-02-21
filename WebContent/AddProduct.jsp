<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Product</title>
  <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #eaf4ff;
    }

    nav {
        background-color: #004085;
        color: #fff;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
    }

    nav .logo {
        font-size: 1.5em;
        font-weight: bold;
    }

    nav ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
    }

    nav ul li {
        margin-left: 20px;
    }

    nav ul li a {
        color: #fff;
        text-decoration: none;
        font-weight: 500;
    }

    nav ul li a:hover {
        text-decoration: underline;
    }

    .form-container {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 400px;
        margin: 50px auto;
        border: 2px solid #004085;
    }

    .form-container h1 {
        text-align: center;
        color: #004085;
        margin-bottom: 20px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }

    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        background-color: #f9f9f9;
    }

    .form-group textarea {
        resize: none;
        height: 80px;
    }

    .submit-btn {
        width: 100%;
        padding: 10px;
        background-color: #004085;
        color: #ffffff;
        border: none;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        border-radius: 0; /* Square button */
    }

    .submit-btn:hover {
        background-color: #0056b3;
    }

    .form-group input:focus, .form-group textarea:focus {
        outline: none;
        border-color: #004085;
        box-shadow: 0 0 4px rgba(0, 64, 133, 0.6);
    }
  </style>
</head>
<body>
<jsp:include page="./commons/AdminNavBar.jsp" />
  <div class="form-container">
    <h1>Add Product</h1>
    
    <form action="admin" method="POST" id="AddProduct">
      <input type="hidden" value="addProduct" name="action"/>
      <!-- Product Name -->
      <div class="form-group">
        <label for="productName">Product Name</label>
        <input type="text" id="productName" name="productName" required>
      </div>

      <!-- Product Price -->
      <div class="form-group">
        <label for="productPrice">Product Price</label>
        <input type="number" id="productPrice" name="productPrice" step="0.01" required>
      </div>
      
      <!-- Product Quantity -->
      <div class="form-group">
        <label for="productQuantity">Product Quantity</label>
        <input type="number" id="productQuantity" name="productQuantity" step="1" required>
      </div>

      <!-- Product Description -->
      <div class="form-group">
        <label for="productDescription">Product Description</label>
        <textarea id="productDescription" name="productDescription" required></textarea>
      </div>

      <!-- Product Image -->
      <div class="form-group">
        <label for="productImage">Upload Image</label>
        <input type="text" id="productImage" name="productImage" required>
      </div>

      <!-- Submit Button -->
      <button type="submit" class="submit-btn">Add Product</button>
    </form>
  </div>
</body>
</html>