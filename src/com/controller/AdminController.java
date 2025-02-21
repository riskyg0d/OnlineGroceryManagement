package com.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.AdminDAO;
import com.entity.Admin;
import com.entity.Product;
import com.entity.Customer;
/**
 * This controller controls the admin functionality like login, delete, addproduct, searchproduct
 */
@WebServlet(urlPatterns = { "/AdminController", "/admin" })
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    public AdminController() {
        super();
    }

    @Override
    public void init() throws ServletException {
        this.adminDAO = new AdminDAO(); // Assuming AdminDAO has a no-argument constructor
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equalsIgnoreCase("login")) {
                String adminId = request.getParameter("adminID");
                int convertedAdminId = Integer.parseInt(adminId);
                String password = request.getParameter("password");

                Admin admin = this.adminDAO.get(new Admin(convertedAdminId, password));

                if (admin != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    session.setAttribute("role", "admin");
                    response.sendRedirect("AdminHome.jsp");
                } else {
                    request.setAttribute("error", "Invalid ID or Password");
                    request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
                }

            } else if (action.equalsIgnoreCase("DeleteCustomer")) {
                String customerId = request.getParameter("customerId");
                int convertedCustomerId = Integer.parseInt(customerId);

                boolean isDeleted = adminDAO.DeleteCustomer(convertedCustomerId);

                if (isDeleted) {
                    List<Customer> customers = adminDAO.getAllCustomers();
                    request.setAttribute("customers", customers);
                    request.getRequestDispatcher("/CustomerManagement.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Deletion failed.");
                    request.getRequestDispatcher("/CustomerManagement.jsp").forward(request, response);
                }

            } else if (action.equalsIgnoreCase("addProduct")) {
                try {
                	String productName = request.getParameter("productName");
                    String price = request.getParameter("productPrice");
                    double productPrice = Double.parseDouble(price);
                    int productQuantity=Integer.parseInt(request.getParameter("productQuantity"));
                    String description = request.getParameter("productDescription");
                    String imgUrl = request.getParameter("productImage");

                    // Creating a Product object
                    Product product = new Product(productName, productPrice, description, imgUrl,productQuantity);

                    // Adding the product using DAO
                    int isAdded = adminDAO.addProduct(product);

                    if (isAdded > 0) {
                        // Set success message in request scope
                        String successMessage = "Product with name '" + productName + "' was added successfully.";
                        request.setAttribute("successMessage", successMessage);
                    } else {
                        // Set error message in request scope
                        request.setAttribute("errorMessage", "Product addition failed.");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Invalid price format.");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "An unexpected error occurred.");
                }

                // Redirect back to the AddProduct.jsp page
                request.getRequestDispatcher("/AddProduct.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("DeleteProduct")) {
                String productId = request.getParameter("productId");
                int convertedProductId = Integer.parseInt(productId);

                boolean isDeleted = adminDAO.DeleteProduct(convertedProductId);

                if (isDeleted) {
                    List<Product> products = adminDAO.getAllProducts();
                    request.setAttribute("products", products);
                    request.getRequestDispatcher("/ProductManagement.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Deletion failed.");
                    request.getRequestDispatcher("/ProductManagement.jsp").forward(request, response);
                }

            } else if (action.equalsIgnoreCase("SearchProduct")) {
                String productName = request.getParameter("productName");

                List<Product> products = adminDAO.SearchProduct(productName);

                if (!products.isEmpty()) {
                    request.setAttribute("products", products);
                    request.getRequestDispatcher("/ProductManagement.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "No matching products found.");
                    request.getRequestDispatcher("/ProductManagement.jsp").forward(request, response);
                }

            }
            else if(action.equalsIgnoreCase("UpdateProduct")){
            	int productQuantity=Integer.parseInt(request.getParameter("productQuantity"));
            	int productId=Integer.parseInt(request.getParameter("productId"));
            	String productImg=request.getParameter("imgUrl");
            	String productdescription=request.getParameter("productDescription");
            	String productname=request.getParameter("productName");
            	double productprice=Double.parseDouble(request.getParameter("productPrice"));
//            	request.getRequestDispatcher("/DisplayOrder.jsp").forward(request, response);
            	Product product=new Product(productname,productprice,productdescription,productImg,productQuantity);
            	boolean updateQuantity=adminDAO.updateProduct(product,productId);
            	if(updateQuantity){
            		request.setAttribute("update","Sucess");
            		request.getRequestDispatcher("/ProductManagement.jsp").forward(request, response);
            	}
            	else{
            		request.getRequestDispatcher("/WelcomePage.jsp");
            	}
            }
        }catch(NumberFormatException n){
        	 request.setAttribute("error", "Invalid ID or Password");
             request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        }
    }
}
