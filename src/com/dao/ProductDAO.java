package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.entity.Product;
import com.helper.DBHelper;

public class ProductDAO {
	/**
	 * Get all products
	 * @return List<Product>
	 */
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        
        String query = "SELECT * FROM products"; 

        try {
            PreparedStatement pst = DBHelper.getPreparedStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImgUrl(rs.getString("imgUrl"));
                productList.add(product);
            }
            DBHelper.close(); 
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
    
    public Product getProductById(int id) throws SQLException, ClassNotFoundException {
    	String query = "SELECT * FROM products where productId=?";
    	PreparedStatement pst = DBHelper.getPreparedStatement(query);
    	pst.setInt(1, id);
    	ResultSet rs = pst.executeQuery();
    	if(rs.next()) {
    		Product product=new Product();
    		product.setId(rs.getInt("productId"));
    		product.setName(rs.getString("productName"));
    		product.setDescription(rs.getString("productDescription"));
    		product.setImgUrl(rs.getString("imgUrl"));
    		product.setQuantity(rs.getInt("pQuantity"));
    		product.setPrice(rs.getDouble("productPrice"));
    		DBHelper.close(); 
    		return product;
    	}
    	else {
    		DBHelper.close(); 
    		return null;
    	}
    	
    }
}


