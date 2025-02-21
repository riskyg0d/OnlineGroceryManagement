<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper_Cart" %>
<%@ page import="com.entity.Customer" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Item</title>
</head>
<body>
    <% 
        // Get customer details
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        String customerEmail = customer.getEmail();
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBHelper_Cart.getConnection();

            // Delete item from the CartTable
            String deleteCartSql = "DELETE FROM CartTable WHERE ProductID = ? AND Email = ?";
            pstmt = conn.prepareStatement(deleteCartSql);
            pstmt.setInt(1, productId);
            pstmt.setString(2, customerEmail);
            pstmt.executeUpdate();

            // Delete corresponding item from Orders table
            String deleteOrderSql = "DELETE FROM Orders WHERE ProductName = ? AND ContactNumber = ? AND CustomerName = ?";
            pstmt = conn.prepareStatement(deleteOrderSql);
            pstmt.setString(1, request.getParameter("productName"));
            pstmt.setInt(2, Integer.parseInt(customer.getContactNumber()));
            pstmt.setString(3, customer.getName());
            pstmt.executeUpdate();

            // Redirect to the cart page after deletion
            response.sendRedirect("cart.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error occurred while deleting item: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
