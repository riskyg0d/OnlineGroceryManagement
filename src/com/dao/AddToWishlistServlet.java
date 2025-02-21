package com.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.WishlistDAO;
import com.entity.Customer;

@WebServlet("/AddToWishlist")
public class AddToWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));
        int customerId = customer.getCustomerId();

        try {
            if (WishlistDAO.isProductInWishlist(customerId, productId)) {
                WishlistDAO.removeProductFromWishlist(customerId, productId);
            } else {
                WishlistDAO.addProductToWishlist(customerId, productId);
            }
            response.sendRedirect("Wishlist.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

