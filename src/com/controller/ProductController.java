package com.controller;

import com.dao.ProductDAO;
import com.entity.Product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 * This controller lists all the products in the homepage from the database.
 */
@WebServlet(urlPatterns = {"/ProductController", "/product"})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductController() {
        super();
    }

    // Handles GET request to fetch all products and forward to HomePage.jsp
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Create an instance of ProductDAO to interact with the database
        ProductDAO productDAO = new ProductDAO();
        
        try {
            // Fetch all products from the database
            List<Product> productList = productDAO.getAllProducts();
            
            // Set the product list as a request attribute to pass it to the JSP
            request.setAttribute("productList", productList);
            
            // Forward the request and product list to HomePage.jsp for rendering
            RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Handle errors gracefully
            response.getWriter().println("Error fetching products: " + e.getMessage());
        }
    }

    // Handles POST request (currently unused)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logic for POST request (if needed)
    }
}

