<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.entity.Customer" %>
<%@ page import="com.helper.DBHelper_Cart" %>
<%@ page import="com.helper.DBHelper" %>
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
        html, body{
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        body {
            background-color: #ffffff; /* White background */
            color: #333; /* Dark gray text */
        }

        .cart-container {
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
            color: 03456B; /* blue dark for the link */
            font-weight: 500;
            font-size: 18px;
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
            color: #fff; /* White text for headers */
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        .delete-btn {
            background-color: #03456B; /* Dark blue */
            color: #fff; /* White text */
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .delete-btn:hover {
            background-color: red; /* Red on hover */
        }

        .summary {
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9; /* Light background for the summary */
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .order-btn {
            background-color: #03456B; /* Dark blue for the button */
            color: #fff; /* White text */
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
            background-color: #012f4c; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <jsp:include page="./commons/publicNavBar.jsp"/>
    <div class="cart-container">
    <% 
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }
        String customerEmail = customer.getEmail();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBHelper_Cart.getConnection();
            String sql = "SELECT p.productId, p.productName, p.productPrice, p.imgUrl,p.pquantity, " +
                         "SUM(c.no_of_items) AS totalQuantity, " +
                         "SUM(c.TotalAmount) AS totalAmount " +
                         "FROM CartTable c " +
                         "JOIN products p ON c.ProductID = p.productId " +
                         "WHERE c.Email = ? and p.pquantity>0 " +
                         "GROUP BY p.productId, p.productName, p.productPrice, p.imgUrl,pquantity";
            stmt = DBHelper_Cart.getPreparedStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stmt.setString(1, customerEmail);
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
                    <th>Quantity</th>
                    <th>Subtotal</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                String cname;
                String cnumber;
                int cartQuantity=0;
               
                    Customer customer1 = (Customer) session.getAttribute("customer");
                     cname=customer1.getName();
                      cnumber=customer1.getContactNumber();
                      int id=customer1.getCustomerId();
                
                double grandTotal = 0;
                do {
                    hasItems = true; // Set the flag to true if items exist
                    int productId = rs.getInt("productId");
                    String productName = rs.getString("productName");
                    double productPrice = rs.getDouble("productPrice");
                    int pquantity=rs.getInt("pQuantity");
                    String imgUrl = rs.getString("imgUrl");
                    int totalQuantity = rs.getInt("totalQuantity");
                    double totalAmount = (rs.getInt("productPrice"))*totalQuantity;
                    if(pquantity<totalQuantity){
                    	
                    	out.println("<script>");
                    	out.println("window.alert('"+"Sorry! "+ productName +" has only "+ pquantity +" units');");
                    	out.println("</script>");
                    
                    
                    totalQuantity=pquantity; 
                    totalAmount=totalQuantity*productPrice;
                    String sql1="update carttable set no_of_items=?,totalamount=? where customerid=? and productid=?";
                	PreparedStatement stmt1 =DBHelper.getPreparedStatement(sql1);
                	stmt1.setInt(1,totalQuantity);
                	stmt1.setDouble(2,totalAmount);
                	stmt1.setInt(3,id);
                	stmt1.setInt(4,productId);
                	stmt1.executeUpdate();
                	DBHelper.close();
                    }
                    grandTotal += totalAmount;
                    if(totalQuantity != 0){
                %>
                <tr>
                    <td><img src="<%= imgUrl != null ? imgUrl : "images/default-product.jpg" %>" alt="<%= productName %>" class="product-image"></td>
                    <td><%= productName %></td>
                    <td>Rs. <%= productPrice %></td>
                    <td><%= totalQuantity %></td>
                    <td>Rs. <%= totalAmount %></td>
                    <td><button class="delete-btn" onclick="deleteItem(<%= productId %>)">Remove</button></td>
                </tr>
                <%}
                } while (rs.next());
                //DBHelper_Cart.closeResources(rs, stmt, conn);
                %>
            </tbody>
        </table>
    
        <div class="summary">
            <h3>Summary</h3>
            <p><strong>Total Amount: Rs. <%= grandTotal %></strong></p>
            
            <button class="order-btn" onclick="window.location.href='Orderplaced.jsp'">Order</button>
        </div>

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
                window.location.href = "DeleteItem.jsp?productId=" + productId;
            }
        }
       
    </script>
</body>
</html>
