package com.controller;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.Customer;
import com.helper.DBHelper;

/**
 * This controller removes the products from the cart.
 */
@WebServlet("/RemoveFromCart")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        // Fetch customer details
        int cust_id = customer.getCustomerId();
        String email = customer.getEmail();

        // Retrieve product ID and quantity parameters
        String product_id = request.getParameter("id");
        String quantityParam = request.getParameter("quantity");
        int quantity = (quantityParam != null && !quantityParam.isEmpty()) ? Integer.parseInt(quantityParam) : 0;

        if (product_id == null || product_id.isEmpty()) {
            response.getWriter().println("Product ID is missing.");
            return;
        }

        int product_price = 0;
        int product_total = 0;
        int cart_total = 0;
        boolean productExistsInCart = false;

        try {
            // Retrieve product details
            String sql = "SELECT * FROM PRODUCTS WHERE productId = ?";
            try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
                pstmt.setString(1, product_id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        product_price = rs.getInt("productPrice");
                        product_total = product_price; // Single product price
                    } else {
                        response.getWriter().println("Product not found.");
                        return;
                    }
                }
            }

            // Check if the product exists in the cart
            String sql1 = "SELECT * FROM CartTable WHERE ProductID = ? AND Email = ?";
            try (PreparedStatement pstmt1 = DBHelper.getPreparedStatement(sql1)) {
                pstmt1.setString(1, product_id);
                pstmt1.setString(2, email);
                try (ResultSet rs1 = pstmt1.executeQuery()) {
                    if (rs1.next()) {
                        cart_total = rs1.getInt("TotalAmount");

                        int currentQuantity = rs1.getInt("no_of_items");
                        if (currentQuantity > 0) {
                            quantity = currentQuantity - 1; // Decrease the quantity
                            cart_total -= product_total;
                            productExistsInCart = true;
                        }
                    }
                }
            }

            // Update cart if product exists
            if (productExistsInCart) {
                if (quantity > 0) {
                    String sql2 = "UPDATE CartTable SET TotalAmount = ?, no_of_items = ? WHERE ProductID = ? AND Email = ?";
                    try (PreparedStatement pstmt2 = DBHelper.getPreparedStatement(sql2)) {
                        pstmt2.setInt(1, cart_total);
                        pstmt2.setInt(2, quantity);
                        pstmt2.setString(3, product_id);
                        pstmt2.setString(4, email);
                        pstmt2.executeUpdate();
                    }
                } else {
                    // Remove product from the cart if quantity is zero
                    String sql3 = "DELETE FROM CartTable WHERE ProductID = ? AND Email = ?";
                    try (PreparedStatement pstmt3 = DBHelper.getPreparedStatement(sql3)) {
                        pstmt3.setString(1, product_id);
                        pstmt3.setString(2, email);
                        pstmt3.executeUpdate();
                    }
                }
            }

            response.sendRedirect("HomePage.jsp");

        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
