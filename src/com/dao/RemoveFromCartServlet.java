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

@WebServlet("/RemoveFromCart")
public class RemoveFromCartServlet extends HttpServlet {
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

        int custId = customer.getCustomerId();
        String email = customer.getEmail();
        String productId = request.getParameter("id");
        String quantityParam = request.getParameter("quantity");
        int quantity = (quantityParam != null && !quantityParam.isEmpty()) ? Integer.parseInt(quantityParam) : 0;

        if (productId == null || productId.isEmpty()) {
            response.getWriter().println("Product ID is missing.");
            return;
        }

        try (ResultSet productDetails = CartDAO.getProductDetails(productId)) {
            if (!productDetails.next()) {
                response.getWriter().println("Product not found.");
                return;
            }

            int productPrice = productDetails.getInt("productPrice");
            int productTotal = productPrice;

            try (ResultSet cartDetails = CartDAO.getCartDetails(productId, email)) {
                if (cartDetails.next()) {
                    int currentQuantity = cartDetails.getInt("no_of_items");
                    int cartTotal = cartDetails.getInt("TotalAmount");

                    if (currentQuantity > 0) {
                        quantity = currentQuantity - 1;
                        cartTotal -= productTotal;

                        if (quantity > 0) {
                            CartDAO.updateCart(productId, email, cartTotal, quantity);
                        } else {
                            CartDAO.removeProductFromCart(productId, email);
                        }
                    }
                }
            }

            response.sendRedirect("HomePage.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
