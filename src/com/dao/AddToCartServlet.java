package com.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.CartDAO;
import com.entity.Customer;

@WebServlet("/AddToCart")
public class AddToCartServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        String productId = request.getParameter("id");
        String quantityParam = request.getParameter("quantity");
        int quantity = (quantityParam != null && !quantityParam.isEmpty()) ? Integer.parseInt(quantityParam) : 1;

        if (productId == null || productId.isEmpty()) {
            response.getWriter().println("Product ID is missing.");
            return;
        }

        int productPrice = 0;

        try (ResultSet productDetails = CartDAO.getProductDetails(productId)) {
            if (productDetails.next()) {
                productPrice = productDetails.getInt("productPrice");
            } else {
                response.getWriter().println("Product not found.");
                return;
            }

            String email = customer.getEmail();
            int totalAmount = productPrice * quantity;

            if (CartDAO.isProductInCart(productId, email)) {
                try (ResultSet cartDetails = CartDAO.getCartDetails(productId, email)) {
                    if (cartDetails.next()) {
                        int currentQuantity = cartDetails.getInt("no_of_items");
                        int currentTotal = cartDetails.getInt("TotalAmount");

                        quantity += currentQuantity;
                        totalAmount += currentTotal;
                    }
                }
                CartDAO.updateCart(productId, email, quantity, totalAmount);
            } else {
                CartDAO.addProductToCart(productId, email, quantity, totalAmount);
            }

            response.sendRedirect("Cart.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
