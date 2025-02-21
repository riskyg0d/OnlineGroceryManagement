package com.entity;


/**
 * 
 * @implNote Model File to reflect the database table
 *
 */
public class Admin {
	private int adminId;
	private String password;
	
	public Admin() {
		super();
	}
	/**
	 * Admin Entity
	 * @param adminId
	 * @param password
	 */
	public Admin(int adminId, String password) { 
		super();
		this.adminId = adminId;
		this.password = password;
	}
	/**
	 * get adminId
	 * @return adminId
	 */
	public int getAdminId() {
		return adminId;
	}
	/**
	 * sets adminId
	 * @param adminId
	 */
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	
	/**
	 * get password
	 * @return password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * set Password
	 * @param password
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * to String Method
	 */
	@Override
	public String toString() {
		return "Customer [customerId=" + adminId + ", password=" + password + "]";
	}
	
}


