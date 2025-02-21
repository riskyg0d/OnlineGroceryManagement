package com.helper;
/**
 * DBHelper Wishlist code for connection with the DataBase for the cart functionality
 */
import java.sql.*;

public final class DBHelper_Wishlist {
	    private static Connection conn;
	    private static final String URI =  "jdbc:derby:C:\\Users\\neele\\MyDB;create=true";

	    public static Connection getConnection() throws ClassNotFoundException, SQLException {
	        if (conn == null || conn.isClosed()) {
	            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
	            
	            conn = DriverManager.getConnection(URI);
	        }
	        return conn;
	    }

	    public static PreparedStatement getPreparedStatement(String sql, int resultSetType, int resultSetConcurrency) throws SQLException, ClassNotFoundException {
	        Connection connection = getConnection();
	        return connection.prepareStatement(sql, resultSetType, resultSetConcurrency);
	    }

	    public static void closeResources(ResultSet rs, Statement stmt, Connection conn) {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

