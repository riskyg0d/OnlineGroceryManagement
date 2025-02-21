package com.entity;

public class placedOrders {
	
	 int id ;
	  String  CustomerName;
	  String  ContactNumber;
	  String  ProductName ;
	    double ProductPrice ;
	    int Quantity ;
	    
	    
	    /**
	     * placeOrders
	     * @param id
	     * @param customerName
	     * @param contactNumber
	     * @param productName
	     * @param productPrice
	     * @param quantity
	     */
		public placedOrders(int id, String customerName, String contactNumber, String productName, double productPrice,
				int quantity) {
			super();
			this.id = id;
			CustomerName = customerName;
			ContactNumber = contactNumber;
			ProductName = productName;
			ProductPrice = productPrice;
			Quantity = quantity;
		}
		/**
		 * get Id
		 * @return id
		 */
		public int getId() {
			return id;
		}
		/**
		 * set Id
		 * @param id
		 */
		public void setId(int id) {
			this.id = id;
		}
		/**
		 * get Customer Name
		 * @return CustomerName
		 */
		public String getCustomerName() {
			return CustomerName;
		}
		/**
		 * set CustomerName
		 * @param customerName
		 */
		public void setCustomerName(String customerName) {
			CustomerName = customerName;
		}
		/**
		 * get ContactNumber
		 * @return ContactNumber
		 */
		public String getContactNumber() {
			return ContactNumber;
		}
		/**
		 * set ContactNumber
		 * @param contactNumber
		 */
		public void setContactNumber(String contactNumber) {
			ContactNumber = contactNumber;
		}
		/**
		 * get ProductName
		 * @return ProductName
		 */
		public String getProductName() {
			return ProductName;
		}
		/**
		 * set ProductName
		 * @param productName
		 */
		public void setProductName(String productName) {
			ProductName = productName;
		}
		/**
		 * get ProductPrice
		 * @return ProductPrice
		 */
		public double getProductPrice() {
			return ProductPrice;
		}
		/**
		 * set ProductPrice
		 * @param productPrice
		 */
		public void setProductPrice(double productPrice) {
			ProductPrice = productPrice;
		}
		/**
		 * get Quantity
		 * @return Quantity
		 */
		public int getQuantity() {
			return Quantity;
		}
		/**
		 * set Quantity
		 * @param quantity
		 */
		public void setQuantity(int quantity) {
			Quantity = quantity;
		}
	
	    
	    
}
