package com.entity;

public class OrderList {
	
	String customerName;
	int customerContact;
	String productName;
	int productPrice;
	int quantity;
	/**
	 * OrderList
	 */
	public OrderList(){
		
	}
	/**
	 * OrderList
	 * @param customerName
	 * @param customerEmail
	 * @param productName
	 * @param productPrice
	 * @param quantity
	 */
	public OrderList(String customerName, int customerEmail, String productName, int productPrice, int quantity) {
		super();
		this.customerName = customerName;
		this.customerContact = customerEmail;
		this.productName = productName;
		this.productPrice = productPrice;
		this.quantity = quantity;
	}
	/**
	 * get CustomerName
	 * @return customerName
	 */
	public String getCustomerName() {
		return customerName;
	}
	/**
	 * set CustomerName
	 * @param customerName
	 */
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	/**
	 * get CustomerContact
	 * @return customerContact
	 */
	public int getCustomerContact() {
		return customerContact;
	}
	/**
	 * set CustomerContact
	 * @param customerContact
	 */
	public void setCustomerContact(int customerContact) {
		this.customerContact = customerContact;
	}
	/**
	 * get ProductName
	 * @return ProductName
	 */
	public String getProductName() {
		return productName;
	}
	/**
	 * set ProductName
	 * @param productName
	 */
	public void setProductName(String productName) {
		this.productName = productName;
	}
	/**
	 * get ProductPrice
	 * @return productPrice
	 */
	public int getProductPrice() {
		return productPrice;
	}
	/**
	 * set ProductPrice
	 * @param productPrice
	 */
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	/**
	 * get Quantity
	 * @return quantity
	 */
	public int getQuantity() {
		return quantity;
	}
	/**
	 * set Quantity
	 * @param quantity
	 */
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
	

}
