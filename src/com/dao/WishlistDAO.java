package com.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.helper.DBHelper;

public class WishlistDAO {

    public static boolean isProductInWishlist(int customerId, int productId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM WishlistTable WHERE cid = ? AND ProductID = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setInt(1, customerId);
        pstmt.setInt(2, productId);
        ResultSet rs = pstmt.executeQuery();
        return rs.next();
    }

    public static void addProductToWishlist(int customerId, int productId) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO WishlistTable (cid, ProductID) VALUES (?, ?)";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setInt(1, customerId);
        pstmt.setInt(2, productId);
        pstmt.executeUpdate();
    }

    public static void removeProductFromWishlist(int customerId, int productId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM WishlistTable WHERE cid = ? AND ProductID = ?";
        PreparedStatement pstmt = DBHelper.getPreparedStatement(sql);
        pstmt.setInt(1, customerId);
        pstmt.setInt(2, productId);
        pstmt.executeUpdate();
    }
}
