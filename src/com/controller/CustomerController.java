//package com.controller;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.Random;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import com.dao.CustomerDAO;
//import com.entity.Customer;
//
///**
// * This controller controls the customer functionality like login, register, update.
// */
//@WebServlet(urlPatterns = {"/CustomerController", "/customer"})
//public class CustomerController extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    private CustomerDAO customerDAO;
//
//    public CustomerController() {
//        super();
//    }
//
//    @Override
//    public void init() throws ServletException {
//        this.customerDAO = new CustomerDAO();
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.getWriter().append("Served at: ").append(request.getContextPath());
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//
//        try {
//            if (action.equalsIgnoreCase("login")) {
//                String mail = request.getParameter("email").trim();
//                // int converted_cust_id = Integer.parseInt(customerId);
//                String password = request.getParameter("password").trim();
//
//                //Customer customer = this.customerDAO.get(new Customer(converted_cust_id, password));
//                Customer customer = this.customerDAO.get(new Customer(mail, password));
//
//                if (customer != null) {
//                    HttpSession session = request.getSession();
//                    session.setAttribute("customer", customer);
//                    session.setAttribute("role", "customer");
//                    response.sendRedirect("HomePage.jsp");
//                } else {
//                    request.setAttribute("error", "Invalid EmailID or Password");
//                    request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
//                }
//            } else if (action.equalsIgnoreCase("register")) {
//                try {
//                    String customerName = request.getParameter("customerName");
//                    String email = request.getParameter("email");
//                    String password = request.getParameter("password");
//                    String address = request.getParameter("address");
//                    String contactNumber = request.getParameter("contactNumber");
//
//                    int customerID = generateUniqueCustomerID();
//
//                    Customer customer = new Customer(customerID, customerName, email, password, address, contactNumber);
//
//                    boolean isRegistered = customerDAO.RegisterCustomer(customer);
//                    if (isRegistered) {
//                        request.setAttribute("customer", customer);
//                        request.getRequestDispatcher("/Customer_Successfully_Registered.jsp").forward(request, response);
//                    } else {
//                        request.setAttribute("error", "Registration failed.");
//                        request.getRequestDispatcher("/registerPage.jsp").forward(request, response);
//                    }
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    request.setAttribute("error", "An error occurred during registration.");
//                    request.getRequestDispatcher("/registerPage.jsp").forward(request, response);
//                }
//            } else if (action.equalsIgnoreCase("update")) {
//                String customerName = request.getParameter("customerName");
//                String email = request.getParameter("email");
//                String password = request.getParameter("password");
//                String address = request.getParameter("address");
//                String contactNumber = request.getParameter("contactNumber");
//                Customer customer = new Customer(customerName, email, password, address, contactNumber);
//
//                HttpSession httpSession = request.getSession();
//                Customer sCustomer = (Customer) httpSession.getAttribute("customer");
//                customer.setCustomerId(sCustomer.getCustomerId());
//                this.customerDAO.UpdateCustomer(customer);
//                response.sendRedirect("HomePage.jsp");
//            }
//        } catch (ClassNotFoundException | SQLException e) {
//            e.printStackTrace();
//            request.setAttribute("error", "An unexpected error occurred.");
//            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
//        }
//    }
//
//    /**
//     * Generates Unique CustomerID
//     * @return customerID
//     * @throws ClassNotFoundException
//     * @throws SQLException 
//     */
//    private int generateUniqueCustomerID() throws ClassNotFoundException, SQLException {
//        Random random = new Random();
//        int customerID;
//        boolean isUnique;
//        do {
//            customerID = 10000 + random.nextInt(90000); // Generate a 5-digit number
//            isUnique = customerDAO.isCustomerIDUnique(customerID); // Check uniqueness in the database
//        } while (!isUnique);
//        return customerID;
//    }
//}
package com.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CustomerDAO;
import com.entity.Customer;
import com.helper.DBHelper;

/**
 * This controller handles customer functionality like login, register, update.
 */
@WebServlet(urlPatterns = { "/CustomerController", "/customer" })
public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public CustomerController() {
        super();
    }

    @Override
    public void init() throws ServletException {
        this.customerDAO = new CustomerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equalsIgnoreCase("register")) {
                handleRegistration(request, response);
            } else if (action.equalsIgnoreCase("login")) {
                handleLogin(request, response);
            } else if (action.equalsIgnoreCase("update")) {
                handleUpdate(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String customerName = request.getParameter("customerName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");

            // Hash the password before saving it
            String hashedPassword = PasswordUtil.hashPassword(password);

            int customerID = generateUniqueCustomerID();

            Customer customer = new Customer(customerID, customerName, email, hashedPassword, address, contactNumber);

            boolean isRegistered = customerDAO.RegisterCustomer(customer);
            if (isRegistered) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/Customer_Successfully_Registered.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed.");
                request.getRequestDispatcher("/registerPage.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during registration.");
            request.getRequestDispatcher("/registerPage.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

        	String mail = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();

            // Fetch the customer from the database by customer ID
            Customer customerFromDb = customerDAO.get(new Customer(mail, password));

            if (customerFromDb != null) {
                // Verify the password by hashing the entered password and comparing with the stored hash
                boolean isPasswordCorrect = PasswordUtil.verifyPassword(password, customerFromDb.getPassword());

                if (isPasswordCorrect) {
                    HttpSession session = request.getSession();
                    session.setAttribute("customer", customerFromDb); // Store the customer object in session
                    session.setAttribute("role", "customer");
                    response.sendRedirect("HomePage.jsp");
                } else {
                    request.setAttribute("error", "Invalid ID or Password");
                    request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
                }
            } else {
                // Handle the case where no customer is found with the given customerId
                request.setAttribute("error", "Customer not found");
                request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error verifying password.");
            request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
        }
    }


    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        // Retrieve the new customer details from the request parameters
        String customerName = request.getParameter("customerName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String contactNumber = request.getParameter("contactNumber");
        
        // Hash the password before updating it in the database
        String hashedPassword = null;
        if (password != null && !password.trim().isEmpty()) {
            try {
                hashedPassword = PasswordUtil.hashPassword(password);
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error while hashing the password.");
                request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                return; // Prevent further processing if password hashing fails
            }
        }

        // Create a Customer object with the updated details (including hashed password if provided)
        Customer customer = new Customer(customerName, email, hashedPassword != null ? hashedPassword : password, address, contactNumber);

        // Retrieve the logged-in customer from the session
        HttpSession httpSession = request.getSession();
        Customer sCustomer = (Customer) httpSession.getAttribute("customer");

        // Set the customerId from the session to ensure the correct customer is updated
        customer.setCustomerId(sCustomer.getCustomerId());

        // Call the DAO method to update the customer in the database
        int isUpdated = this.customerDAO.UpdateCustomer(customer);

        if (isUpdated==1) {
            // If update was successful, redirect to the home page or show success message
        	httpSession.setAttribute("customer", customer);
            response.sendRedirect("HomePage.jsp");
        } else {
            // If update failed, show an error message
            request.setAttribute("error", "An error occurred while updating your details.");
            request.getRequestDispatcher("updatePage.jsp").forward(request, response);
        }
    }


    private int generateUniqueCustomerID() throws ClassNotFoundException, SQLException {
        Random random = new Random();
        int customerID;
        boolean isUnique;
        do {
            customerID = 10000 + random.nextInt(90000); // Generate a 5-digit number
            isUnique = customerDAO.isCustomerIDUnique(customerID); // Check uniqueness in the database
        } while (!isUnique);
        return customerID;
    }
}

