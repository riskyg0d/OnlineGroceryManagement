<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.entity.Customer" %>
<%@ page import="com.helper.DBHelper_Cart" %>
<%@ page import="com.helper.DBHelper" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            background-color: #ffffff; /* White background */
            color: #333; /* Dark gray text */
        }

        nav {
            background-color: #ff6f00; /* Orange background */
            color: #fff;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .wishlist-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }

        .empty-cart {
            text-align: center;
            margin-top: 50px;
        }

        .empty-cart h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .empty-cart a {
            text-decoration: none;
            color: #03456B; /* Dark blue for the "View Products" link */
            font-weight: 500;
            font-size: 18px;
        }

        .empty-cart a:hover {
            text-decoration: underline;
            color: #ff6f00; /* Change to orange on hover */
        }

        .cart-grid {
            display: block;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .cart-table th, .cart-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .cart-table th {
            background-color: #03456B; /* Dark blue header */
            color: #fff;
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        .delete-btn,.add-btn{
            background-color: #03456B; /* Dark blue buttons */
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .add-btn:hover{
            background-color: #0056b3; /* Darker blue on hover */
        }

        .delete-btn:hover {
            background-color: red; /* Red on hover for delete button */
        }

        .summary {
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9; /* Light gray background */
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .order-btn {
            background-color: #03456B; /* Dark blue order button */
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            text-align: center;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .order-btn:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <jsp:include page="./commons/publicNavBar.jsp"/>
    <div class="wishlist-container">
    <% 
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }
        String customerEmail = customer.getEmail();
        int id=customer.getCustomerId();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBHelper_Cart.getConnection();
            String sql = "SELECT p.productId, p.productName, p.productPrice, p.imgUrl " +
                          "FROM WishlistTable c " +
                          "JOIN products p ON c.ProductID = p.productId " +
                          "WHERE c.cid = ? " +
                          "GROUP BY p.productId, p.productName, p.productPrice, p.imgUrl";
            stmt = DBHelper_Cart.getPreparedStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            boolean hasItems = false; // Flag to check if the cart has items
    %>

    <div class="cart-grid" id="cartWithItems">
        <% if (rs.next()) { %>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product Image</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Add To Cart</th>
                    <th>Action</th>
                    
                </tr>
            </thead>
            <tbody>
                <%
                String cname;
                String cnumber;
                int cartQuantity=0;
                Customer customer1 = (Customer) session.getAttribute("customer");
                cname = customer1.getName();
                cnumber = customer1.getContactNumber();
                
                double grandTotal = 0;
                do {
                    hasItems = true; // Set the flag to true if items exist
                    int productId = rs.getInt("productId");
                    String productName = rs.getString("productName");
                    double productPrice = rs.getDouble("productPrice");
                    String imgUrl = rs.getString("imgUrl");
                    grandTotal += productPrice;
                %>
                <tr>
                    <td><img src="<%= imgUrl != null ? imgUrl : "images/default-product.jpg" %>" alt="<%= productName %>" class="product-image"></td>
                    <td><%= productName %></td>
                    <td>Rs. <%= productPrice %></td>
                    <td><form action="AddToCart" method="post">
                    <input type="hidden" name="id" value="<%= productId %>">
                    <button type="submit" class="add-btn" onclick="AddToCart"> AddToCART</button></form></td>
                    <td><button class="delete-btn" onclick="deleteItem(<%= productId %>)">Remove</button></td>
                </tr>
                <%
                } while (rs.next());
                %>
            </tbody>
        </table>

        <% } else { %>
        <div class="empty-cart">
            <h2>Your cart is empty</h2>
            <a href="HomePage.jsp">View Products</a>
        </div>
        <% } %>
    </div>
    <% 
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
    %>
</div>
	<jsp:include page="./commons/Footer.jsp"/>
    <script>
        function deleteItem(productId) {
            if (confirm("Are you sure you want to delete this item?")) {
                window.location.href = "DeleteWishlistItems.jsp?productId=" + productId;
            }
        }
    </script>
</body>
</html>
