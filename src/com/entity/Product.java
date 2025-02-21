package com.entity;

public class Product {
    
    private String name;
    private double price;
    private String description;
    private String imgUrl;
    private int Quantity;
   

	private int id;
    
    
    /**
     * get Id
     * @return id
     */
    public int getId() {
		return id;
	}
    /**
     * Set Id
     * @param id
     */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * Product
	 */
	public Product() {
    	
    }
    /**
     * Product
     * @param name
     * @param price
     * @param description
     * @param imgUrl
     */
	 public Product(String name, double price, String description, String imgUrl) {
	        this.name = name;
	        this.price = price;
	        this.description = description;
	        this.imgUrl = imgUrl;
	    }
	
	 /**
	     * Product
	     * @param name
	     * @param price
	     * @param description
	     * @param imgUrl
	     * @param Quantity
	     */
    public Product(String name, double price, String description, String imgUrl,int Quantity) {
        this.name = name;
        this.price = price;
        this.description = description;
        this.imgUrl = imgUrl;
        this.Quantity=Quantity;
    }

    /**
     * getName
     * @return name
     */
    public String getName() {
        return name;
    }
    /**
     * set Name
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * get price
     * @return price
     */
    public double getPrice() {
        return price;
    }
    /**
     * Set Price
     * @param price
     */
    public void setPrice(double price) {
        this.price = price;
    }
    /**
     * get Description
     * @return description
     */
    public String getDescription() {
        return description;
    }
    
    /**
     * set Description
     * @param description
     */
    public void setDescription(String description) {
        this.description = description;
    }
    
    /**
     * get Img Url
     * @return imgUrl
     */
    public String getImgUrl() {
        return imgUrl;
    }
    
    /**
     * set Image URL
     * @param imgUrl
     */
    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
    public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
    
    /**
     * To String 
     */
    @Override
    public String toString() {
        return "Product [name=" + name + ", price=" + price + ", description=" + description + ", imgUrl=" + imgUrl + "]";
    }
}

