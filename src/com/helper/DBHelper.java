package com.helper;


/**
 * DBHelper code for connection with the DataBase
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public final class DBHelper {
	private static Connection conn;
	private static PreparedStatement pst;
	private static final String URI = "jdbc:derby:C:\\Users\\neele\\MyDB;create=true";

	public static PreparedStatement getPreparedStatement(String sql) throws ClassNotFoundException, SQLException {
		Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
		conn = DriverManager.getConnection(URI);
		pst = conn.prepareStatement(sql);
		return pst;
	}

	public static void close() throws SQLException {
		pst.close();
		conn.close();
	}
}

