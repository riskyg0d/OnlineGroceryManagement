<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.entity.Customer" %>
<%@ page import="java.sql.ResultSet" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Item</title>
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
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            min-height: 100vh;
        }
        nav {
            background-color: #ff6f00;
            color: #fff;
            padding: 15px 20px;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .logo {
            font-size: 24px;
            font-weight: 600;
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
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

        .message-container {
            text-align: center;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            width: 100%;
            max-width: 600px;
        }
        .message-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #03456B;
        }
        .message-container a {
            text-decoration: none;
            color: #03456B;
            font-weight: 500;
            font-size: 18px;
        }
        .message-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="./commons/publicNavBar.jsp"/>
    <div class="message-container">
        <% 
            Customer customer = (Customer) session.getAttribute("customer");
            if (customer == null) {
                response.sendRedirect("LoginPage.jsp");
                return;
            }

            int customerId = customer.getCustomerId();
            String customerEmail = customer.getEmail();
            String productId = request.getParameter("productId");

            if (productId == null || productId.isEmpty()) {
                out.println("<h2>Invalid product ID.</h2>");
                out.println("<a href='Cart.jsp'>Go back to Cart</a>");
                return;
            }

            String productName = "";
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // First, get the product name based on productId
                String getProductNameSql = "SELECT ProductName FROM Products WHERE ProductID = ?";
                stmt = DBHelper.getPreparedStatement(getProductNameSql);
                stmt.setInt(1, Integer.parseInt(productId));
                rs = stmt.executeQuery();

                if (rs.next()) {
                    productName = rs.getString("ProductName");
                }

                // Now, delete the product from the cart
                String deleteSql = "DELETE FROM WishlistTable WHERE ProductID = ? AND cid = ?";
                stmt = DBHelper.getPreparedStatement(deleteSql);
                stmt.setInt(1, Integer.parseInt(productId));
                stmt.setInt(2, customerId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<h2>" + productName + " has been successfully removed from the Wishlist.</h2>");
                } else {
                    out.println("<h2>Failed to remove item. Please try again.</h2>");
                }
                out.println("<a href='Wishlist.jsp'>Go back to Wishlist</a>");
            } catch (Exception e) {
                out.println("<h2>Error: " + e.getMessage() + "</h2>");
                out.println("<a href='Wishlist.jsp'>Go back to Wishlist</a>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    DBHelper.close(); // Close the DBHelper resources
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>