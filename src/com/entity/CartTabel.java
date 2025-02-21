package com.entity;

public class CartTabel {

	int TransactionID ;
	int CustomerID ;
	String Email ;
	int ProductID ;
	int TotalAmount ;
	int no_of_items;
	
	
	/**
	 * CartTabel
	 * @param transactionID
	 * @param customerID
	 * @param email
	 * @param productID
	 * @param totalAmount
	 * @param no_of_items
	 */
	public CartTabel(int transactionID, int customerID, String email, int productID, int totalAmount, int no_of_items) {
		super();
		TransactionID = transactionID;
		CustomerID = customerID;
		Email = email;
		ProductID = productID;
		TotalAmount = totalAmount;
		this.no_of_items = no_of_items;
	}
	/**
	 * get Transaction ID
	 * @return TransactionID
	 */
	public int getTransactionID() {
		return TransactionID;
	}
	/**
	 * set Transaction ID
	 * @param transactionID
	 */
	public void setTransactionID(int transactionID) {
		TransactionID = transactionID;
	}
	/**
	 * get CustomerID
	 * @return CustomerID
	 */
	public int getCustomerID() {
		return CustomerID;
	}
	/**
	 * set CustomerID
	 * @param customerID
	 */
	public void setCustomerID(int customerID) {
		CustomerID = customerID;
	}
	/**
	 * Get Email
	 * @return Email
	 */
	public String getEmail() {
		return Email;
	}
	/**
	 * Set Email
	 * @param email
	 */
	public void setEmail(String email) {
		Email = email;
	}
	/**
	 * get ProductID
	 * @return productId
	 */
	public int getProductID() {
		return ProductID;
	}
	/**
	 * set ProductID
	 * @param productID
	 */
	public void setProductID(int productID) {
		ProductID = productID;
	}
	
	/**
	 * get total amount
	 * @return totalamount
	 */
	public int getTotalAmount() {
		return TotalAmount;
	}
	/**
	 * set total amount
	 * @param totalAmount
	 */
	public void setTotalAmount(int totalAmount) {
		TotalAmount = totalAmount;
	}
	/**
	 * get No of Items
	 * @return no of items
	 */
	public int getNo_of_items() {
		return no_of_items;
	}
	/**
	 * set No of Items
	 * @param no_of_items
	 */
	public void setNo_of_items(int no_of_items) {
		this.no_of_items = no_of_items;
	}
}
