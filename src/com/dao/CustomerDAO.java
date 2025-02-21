package com.dao;


import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.util.List;

import com.controller.PasswordUtil;
import com.entity.Customer;
import com.helper.DBHelper;

public class CustomerDAO {
    public boolean RegisterCustomer(Customer customer) throws SQLException, ClassNotFoundException {
        int numberOfRecords = -1;
        String sql = "INSERT INTO Customer_Registration(CustomerID, CustomerName, Email, Password, Address, ContactNumber) VALUES(?,?,?,?,?,?)";
        try (PreparedStatement pst = DBHelper.getPreparedStatement(sql)) {
            pst.setInt(1, customer.getCustomerId());
            pst.setString(2, customer.getName());
            pst.setString(3, customer.getEmail());
            pst.setString(4, customer.getPassword());
            pst.setString(5, customer.getAddress());
            pst.setString(6, customer.getContactNumber());
            numberOfRecords = pst.executeUpdate();
        }
        return numberOfRecords > 0;
    }

  
    public int UpdateCustomer(Customer customer) throws SQLException, ClassNotFoundException {
        int numberOfRecords = -1;
        String sql = "UPDATE Customer_Registration SET CustomerName=?, Email=?, Password=?, Address=?, ContactNumber=? WHERE CustomerID=?";
        try (PreparedStatement pst = DBHelper.getPreparedStatement(sql)) {
            pst.setString(1, customer.getName());
            pst.setString(2, customer.getEmail());
            pst.setString(3, customer.getPassword());
            pst.setString(4, customer.getAddress());
            pst.setString(5, customer.getContactNumber());
            pst.setInt(6, customer.getCustomerId());
            numberOfRecords = pst.executeUpdate();
        }
        return numberOfRecords;
    }

    public List<Customer> searchCustomerByName(String customerName) throws SQLException, ClassNotFoundException {
        List<Customer> customerList = new ArrayList<>();
        String sql = "SELECT CustomerID, CustomerName, Email, Password, Address, ContactNumber FROM Customer_Registration WHERE LOWER(CustomerName) = LOWER(?)";
        try (PreparedStatement pst = DBHelper.getPreparedStatement(sql)) {
            pst.setString(1, customerName);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer(
                    rs.getInt("CustomerID"),
                    rs.getString("CustomerName"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("Address"),
                    rs.getString("ContactNumber")
                );
                customerList.add(customer);
            }
        }
        if (customerList.isEmpty()) {
            throw new SQLException("Customer not found");
        }
        return customerList;
    }

 
    public Customer get(Customer customer) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        String sql = "SELECT * FROM Customer_Registration WHERE Email = ?";
        try (PreparedStatement preparedStatement = DBHelper.getPreparedStatement(sql)) {
            preparedStatement.setString(1, customer.getEmail());
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
            	 String storedHashedPassword = rs.getString("Password");
            	 String enteredPassword = customer.getPassword(); // This should be the password passed from the controller
                 
                 // Check if the entered password is null
                 if (enteredPassword == null || enteredPassword.trim().isEmpty()) {
                     System.out.println("Password is null or empty in CustomerDAO.");
                     return null;
                 }
                 // Verify the password by hashing the entered password and comparing with the stored hash
                 if (PasswordUtil.verifyPassword(enteredPassword, storedHashedPassword)) {
                     return new Customer(
                         rs.getInt("CustomerID"),
                         rs.getString("CustomerName"),
                         rs.getString("Email"),
                         storedHashedPassword,  // Store the hashed password
                         rs.getString("Address"),
                         rs.getString("ContactNumber")
                     );
                 }
            }
        }
        return null; 
    }


    public boolean isCustomerIDUnique(int customerID) throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM Customer_Registration WHERE CustomerID = ?";
        try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
            pstmt.setInt(1, customerID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0; // True if no record found
            }
        }
        return false;
    }
}
