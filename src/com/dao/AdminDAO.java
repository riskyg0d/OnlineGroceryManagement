
package com.dao;

import java.sql.PreparedStatement;

import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.util.List;

import com.entity.Admin;
import com.entity.Customer;
import com.entity.Product;
import com.helper.DBHelper;

public class AdminDAO {
		// Admin Home 

	    /**
	     * Get the count of registered customers
	     *
	     * @return int - Number of registered customers
	     * @throws SQLException
	     */
	    public int getRegisteredCustomerCount() throws SQLException {
	        String sql = "SELECT COUNT(*) AS CustomerCount FROM Customer_Registration";
	        try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getInt("CustomerCount");
	            }
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return 0;
	    }

	    /**
	     * Get the total sales amount
	     *
	     * @return int - Total sales amount
	     * @throws SQLException
	     */
	    public int getTotalSalesAmount() throws SQLException {
	        String sql = "SELECT SUM(ProductPrice) AS SUM_PRODUCT FROM Placedorders";
	        try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getInt("SUM_PRODUCT");
	            }
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return 0;
	    }

	    /**
	     * Get the total number of orders
	     *
	     * @return int - Total number of orders
	     * @throws SQLException
	     */
	    public int getTotalOrders() throws SQLException {
	        String sql = "SELECT COUNT(*) AS TotalOrders FROM Placedorders";
	        try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getInt("TotalOrders");
	            }
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return 0;
	    }
	

	/**
	 * get all Customers from database
	 * 
	 * @return List<Customer>
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<Customer> getAllCustomers() throws ClassNotFoundException, SQLException {
		List<Customer> customers = new ArrayList<>();
		String sql = "SELECT * FROM Customer_Registration";
		PreparedStatement pst = DBHelper.getPreparedStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			Customer customer = new Customer();
			customer.setCustomerId(rs.getInt("CustomerID"));
			customer.setName(rs.getString("CustomerName"));
			customer.setEmail(rs.getString("Email"));
			customer.setPassword(rs.getString("Password"));
			customer.setAddress(rs.getString("Address"));
			customer.setContactNumber(rs.getString("ContactNumber"));
			customers.add(customer);
		}

		return customers;
	}

	/**
	 * Deletes customer using customerID
	 * 
	 * @param customerID
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public boolean DeleteCustomer(int customerID) throws ClassNotFoundException, SQLException {
		int numberOfRecords = -1;
		String sql = "delete from Customer_Registration where CustomerID = ?";
		PreparedStatement pst = DBHelper.getPreparedStatement(sql);
		pst.setInt(1, customerID);
		numberOfRecords = pst.executeUpdate();
		return numberOfRecords > 0;
	}

	/**
	 * Registering customer using the relevant details
	 * 
	 * @param customer
	 * @return numberOfRecords
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */

	public boolean RegisterCustomer(Customer customer) throws ClassNotFoundException, SQLException {
		int numberOfRecords = -1;
		String sql = "insert into Customer_Registration(CustomerID,CustomerName,Email,Password,Address,ContactNumber) values(?,?,?,?,?,?)";
		PreparedStatement pst = DBHelper.getPreparedStatement(sql);
		pst.setInt(1, customer.getCustomerId());
		pst.setString(2, customer.getName());
		pst.setString(3, customer.getEmail());
		pst.setString(4, customer.getPassword());
		pst.setString(5, customer.getAddress());
		pst.setString(6, customer.getContactNumber());
		numberOfRecords = pst.executeUpdate();
		return numberOfRecords > 0;
	}

	/**
	 * Get all products
	 * 
	 * @return List<Product>
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<Product> getAllProducts() throws ClassNotFoundException, SQLException {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM products";
		PreparedStatement pst = DBHelper.getPreparedStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			Product product = new Product();
			product.setId(rs.getInt("productId"));
			product.setName(rs.getString("productName"));
			product.setPrice(rs.getDouble("productPrice"));
			product.setImgUrl(rs.getString("imgUrl"));
			product.setDescription(rs.getString("productDescription"));
			products.add(product);
		}

		return products;
	}

	/**
	 * 
	 * @param product
	 * @return numberOfRecords
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public int addProduct(Product product) throws SQLException, ClassNotFoundException {
		int numberOfRecords = -1;
		String sql = "INSERT INTO products (ProductName, productPrice, imgUrl, productDescription,pQuantity) VALUES (?, ?, ?, ?,?)";
		try (PreparedStatement pst = DBHelper.getPreparedStatement(sql)) {
			// Set the product details into the PreparedStatement
			pst.setString(1, product.getName());
			pst.setDouble(2, product.getPrice());
			pst.setString(3, product.getImgUrl());
			pst.setString(4, product.getDescription());
			pst.setInt(5, product.getQuantity());
			numberOfRecords = pst.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Error while adding product: " + e.getMessage());
			throw e;
		}

		return numberOfRecords;
	}

	/**
	 * Deletes product using product ID
	 * 
	 * @param productID
	 * @return numberOfRecords
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public boolean DeleteProduct(int productID) throws ClassNotFoundException, SQLException {
		int numberOfRecords = -1;
		String sql = "delete from products where productID = ?";
		PreparedStatement pst = DBHelper.getPreparedStatement(sql);
		pst.setInt(1, productID);
		numberOfRecords = pst.executeUpdate();
		return numberOfRecords > 0;
	}

	/**
	 * Search product using the ProductName
	 * 
	 * @param ProductName
	 * @return List<Product>
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public List<Product> SearchProduct(String ProductName) throws ClassNotFoundException, SQLException {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM products where productName = ?";
		PreparedStatement pst = DBHelper.getPreparedStatement(sql);
		pst.setString(1, ProductName);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			Product product = new Product();
			product.setId(rs.getInt("productId"));
			product.setName(rs.getString("productName"));
			product.setPrice(rs.getDouble("productPrice"));
			product.setImgUrl(rs.getString("imgUrl"));
			product.setDescription(rs.getString("productDescription"));
			products.add(product);
		}

		return products;
	}

	/**
	 * get Admin details
	 * 
	 * @param admin
	 * @return Admin
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public Admin get(Admin admin) throws ClassNotFoundException, SQLException {
		List<Admin> admins = new ArrayList<>();
		String sql = "select * from Admin where AdminID=? and AdminPassword=?";
		PreparedStatement preparedStatement = DBHelper.getPreparedStatement(sql);
		preparedStatement.setInt(1, admin.getAdminId());
		preparedStatement.setString(2, admin.getPassword());
		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			int aid = rs.getInt("AdminID");
			String password = rs.getString("AdminPassword");
			Admin temp = new Admin(aid, password);
			admins.add(temp);
		}
		if (admins.size() <= 0) {
			return null;
		}
		return admins.get(0);
	}
	/**
	 * update product quantity
	 * 
	 * @param product
	 * @return boolean
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public boolean updateProduct(Product product,int id) throws ClassNotFoundException, SQLException {
	    String sql = "UPDATE products SET " +
	                 "productName = ?, " +
	                 "productPrice = ?, " +
	                 "productDescription = ?, " +
	                 "imgUrl = ?, " +
	                 "pQuantity = ? " +
	                 "WHERE productId = ?";
	    PreparedStatement preparedStatement = DBHelper.getPreparedStatement(sql);
	        // Setting the parameters from the Product object
	        preparedStatement.setString(1, product.getName());
	        preparedStatement.setDouble(2, product.getPrice());
	        preparedStatement.setString(3, product.getDescription());
	        preparedStatement.setString(4, product.getImgUrl());
	        preparedStatement.setInt(5, product.getQuantity());
	        preparedStatement.setInt(6, id);

	        // Execute the update query
	        int rowsAffected = preparedStatement.executeUpdate();
	       
	        return rowsAffected > 0; // Returns true if at least one row was updated
	   
	}}
	


