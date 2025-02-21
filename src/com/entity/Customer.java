package com.entity;


/**
 * 
 * @implNote Model File to reflect the database table
 *
 */
public class Customer {
	private int customerId;
	private String Name;
	private String Email;
	private String password;
	private String Address;
	private String ContactNumber;
	
	/**
	 * Customer
	 */
	public Customer() {
		super();
	}
	/**
	 * Customer
	 * @param customerId
	 * @param password
	 */
	
	/*
	public Customer(int customerId, String password) { //Login
		super();
		this.customerId = customerId;
		this.password = password;
	}
	*/
	
	public Customer(String Email, String password) { //Login
		super();
		this.Email = Email;
		this.password = password;
	}
	
	/**
	 * Customer
	 * @param customerId
	 * @param name
	 * @param email
	 * @param password
	 * @param address
	 * @param contactNumber
	 */
	public Customer(int customerId, String name, String email, String password, String address, String contactNumber) {
		super();
		this.customerId = customerId;
		Name = name;
		Email = email;
		this.password = password;
		Address = address;
		ContactNumber = contactNumber;
	}
	/**
	 * Customer
	 * @param name
	 * @param email
	 * @param password
	 * @param address
	 * @param contactNumber
	 */
	public Customer(String name, String email, String password, String address, String contactNumber) {
		super();
		Name = name;
		Email = email;
		this.password = password;
		Address = address;
		ContactNumber = contactNumber;
	}
	/**
	 * get customerId
	 * @return customerId
	 */
	public int getCustomerId() {
		return customerId;
	}
	/**
	 * set CustomerId
	 * @param customerId
	 */
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	/**
	 * get name
	 * @return Name
	 */
	public String getName() {
		return Name;
	}
	/**
	 * Set name
	 * @param name
	 */
	public void setName(String name) {
		Name = name;
	}
	/**
	 * get Email
	 * @return Email
	 */
	public String getEmail() {
		return Email;
	}
	
	/**
	 * setEmail
	 * @param email
	 */
	public void setEmail(String email) {
		Email = email;
	}
	/**
	 * Get Password
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
	 * get Address
	 * @return Address
	 */
	public String getAddress() {
		return Address;
	}
	
	/**
	 * Set Address
	 * @param address
	 */
	public void setAddress(String address) {
		Address = address;
	}
	
	/**
	 * get ContactNumber
	 * @return ContactNumber
	 */
	public String getContactNumber() {
		return ContactNumber;
	}
	/**
	 * set Contact Number
	 * @param contactNumber
	 */
	public void setContactNumber(String contactNumber) {
		ContactNumber = contactNumber;
	}
	
	/**
	 * To String method for printing
	 */
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", Name=" + Name + ", Email=" + Email + ", password=" + password
				+ ", Address=" + Address + ", ContactNumber=" + ContactNumber + "]";
	}
	
}
