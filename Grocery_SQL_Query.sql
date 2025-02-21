CREATE TABLE Customer_Registration (
    CustomerID INT PRIMARY KEY NOT NULL,
    CustomerName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL
);

CREATE TABLE products (
    productId INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    productName VARCHAR(255) NOT NULL,
    productPrice DECIMAL(10, 2) NOT NULL,
    imgUrl VARCHAR(255),
    productDescription VARCHAR(500)
);
ALTER TABLE PRODUCTS ADD  Category varchar(15) NOT NULL DEFAULT 'Default';

ALTER TABLE PRODUCTS ADD COLUMN pQuantity INT NOT NULL DEFAULT 0;

create table WishlistTable(cid int not null,ProductID int not null, Foregn key (cid) Refrences Customer_Registration(CustomerID),Foriegn key (ProductID) Refrences Products(productId));

CREATE TABLE WishlistTable (
    cid INT NOT NULL,
    ProductID INT NOT NULL,
    FOREIGN KEY (cid) REFERENCES Customer_Registration(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(productId)
);



INSERT INTO products (productName, productPrice, imgUrl, productDescription) 
VALUES 
    ('Apple', 120.00, 'images/apple.jpg', 'Fresh and juicy apples sourced from organic farms.'),
   	('Banana', 50.00, 'images/banana.jpg', 'Organic bananas full of essential vitamins and fiber.'),
    ('Blueberries', 300.00, 'images/berries.jpg', 'High-quality blueberries rich in antioxidants and nutrients.'),
   	('Capsicum', 90.00, 'images/capsicum.jpg', 'Seedless green grapes, sweet and perfect for snacking.'),
    ('Pineapple', 200.00, 'images/pineapple.jpg', 'Juicy pineapple with a perfect balance of sweet and tart flavors.'),
    ('Pomagranate', 250.00, 'images/pomagranate.jpg', 'Fresh and luscious strawberries perfect for desserts.'),
    ('tomato', 180.00, 'images/tomato.jpg', 'Refreshing and hydrating watermelons, ideal for summer.');
    
    
truncate table products;
truncate table orders;

    CREATE TABLE Placedorders (
    id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    ProductPrice DOUBLE NOT NULL,
    Quantity INTEGER NOT NULL
);


    CREATE TABLE orders (
    id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15) NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    ProductPrice DOUBLE NOT NULL,
    Quantity INTEGER NOT NULL
);
    
  create table CartTable(
TransactionID int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
CustomerID int Not Null,
Email Varchar(20) Not Null,
ProductID int Not Null,
TotalAmount int Not Null,
no_of_items int Not Null
);


   --Create Admin table 
    CREATE TABLE admin(
    	adminId INT PRIMARY KEY,
    	adminPassword VARCHAR(255) NOT NULL
    );
    
    
    
    select * from CUSTOMER_REGISTRATION;
    
    
	INSERT INTO Customer_Registration (CustomerID, CustomerName, Email, Password, Address, ContactNumber)
	VALUES (12345, 'Anurag', 'anurag@gmail.com', 'password123', 'Mumbai', '9876543210');
    
	select * from products;

	select * from Placeorders
    
	SELECT * FROM admin;
    
    INSERT INTO admin(adminId,adminPassword)
    VALUES (123456, 'Admin@123');
    
    truncate table admin;
    
    drop table admin;
