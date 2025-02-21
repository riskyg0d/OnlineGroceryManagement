package com.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.entity.Customer;
import com.dao.CustomerDAO;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the form data
        String customerName = request.getParameter("customerName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");

        // Assuming the customer ID is stored in the session
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        // Update the customer object with new data
        customer.setName(customerName);
        customer.setEmail(email);
        customer.setPassword(password);
        customer.setContactNumber(contactNumber);
        customer.setAddress(address);

        try {
            // Use CustomerDAO to update the customer in the database
            CustomerDAO customerDAO = new CustomerDAO();
            int rowsUpdated = customerDAO.UpdateCustomer(customer);

            if (rowsUpdated > 0) {
                // If the update was successful, update the session attribute
                session.setAttribute("customer", customer);
                response.sendRedirect("MyProfile.jsp"); // Redirect to the profile page
            } else {
                response.getWriter().println("Error updating profile. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
