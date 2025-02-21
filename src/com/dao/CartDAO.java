package com.dao;

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.entity.CartItem;

import com.helper.DBHelper;
import com.helper.DBHelper_Cart;

public class CartDAO {
	
    
    public static boolean isProductInCart(String productId, String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM CartTable WHERE ProductID = ? AND Email = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, email);
        ResultSet rs = pstmt.executeQuery();
        return rs.next();
    }

    public static ResultSet getProductDetails(String productId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM PRODUCTS WHERE productId = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setString(1, productId);
        return pstmt.executeQuery();
    }

    public static ResultSet getCartDetails(String productId, String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM CartTable WHERE ProductID = ? AND Email = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, email);
        return pstmt.executeQuery();
    }

    public static void addProductToCart(String productId, String email, int quantity, int totalAmount) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO CartTable (ProductID, Email, no_of_items, TotalAmount) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, email);
        pstmt.setInt(3, quantity);
        pstmt.setInt(4, totalAmount);
        pstmt.executeUpdate();
    }

    public static void updateCart(String productId, String email, int quantity, int totalAmount) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE CartTable SET no_of_items = ?, TotalAmount = ? WHERE ProductID = ? AND Email = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setInt(1, quantity);
        pstmt.setInt(2, totalAmount);
        pstmt.setString(3, productId);
        pstmt.setString(4, email);
        pstmt.executeUpdate();
    }

    public static void removeProductFromCart(String productId, String email) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM CartTable WHERE ProductID = ? AND Email = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, email);
        pstmt.executeUpdate();
    }
}

