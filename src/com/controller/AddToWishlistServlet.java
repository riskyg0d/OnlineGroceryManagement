package com.controller;

import java.io.IOException;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.Customer;
import com.helper.DBHelper;

@WebServlet("/AddToWishlist")
public class AddToWishlistServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));
        int cid = customer.getCustomerId();
       

        try {
        	String sql1="Select * from WishlistTable where cid=? and ProductID=? ";
        	PreparedStatement check=DBHelper.getPreparedStatement(sql1);
        	check.setInt(1, cid);
        	check.setInt(2, productId);
        	ResultSet a=check.executeQuery();
        	if(a.next()){
        		String delete="Delete from WishlistTable where cid=? and ProductID=?";
        		PreparedStatement del=DBHelper.getPreparedStatement(delete);
            	del.setInt(1, cid);
            	del.setInt(2, productId);
            	del.executeUpdate();
        	}
        	else{
            // Check if the product is already in the wishlist
            String sql = "INSERT INTO WishlistTable (cid, ProductID) VALUES (?, ?)";
            PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
                pstmt.setInt(1, cid);
                pstmt.setInt(2, productId);
                pstmt.executeUpdate();
                response.sendRedirect("Wishlist.jsp");
                }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
        
    }
}