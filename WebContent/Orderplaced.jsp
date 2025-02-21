<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="com.entity.Customer" %>
<%@ page import="java.util.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }

        body {
            background-color: #ffffff;
            color: #333;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
		
		.container{
			display:flex;
			align-items:center;
			justify-content:center;
		}
		
        nav {
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .order-container {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgb(215 139 139 / 10%);
            width: 513px;
            text-align: center;
            margin: 50px;
        }

        .order-container h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .order-container p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .order-id {
            font-weight: bold;
            color: black;
            font-size: 22px;
        }

        .button {
            background-color: #03456B;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .button:hover {
            background-color: #012f4c;
        }
    </style>
</head>
<body>
<jsp:include page="./commons/publicNavBar.jsp"/>
<section class="container">
	<div class="order-container">
	    <h1>Order Placed Successfully!</h1>
	    <p>Thank you for your order. Your order has been successfully placed.</p>
	    <p>Your Order ID: <span class="order-id" id="orderID"></span></p>
	    <br>
	    <a href="#" class="button" id="downloadInvoice">Download Invoice</a>
	    <br><br>
	    <a href="HomePage.jsp" class="button">Go to Home</a>
	</div>
</section>

<% 
    String cname = "";
    String cnumber = "";
    int cid=0;
    
    if (session.getAttribute("customer") != null) {
        Customer customer1 = (Customer) session.getAttribute("customer");
        cname = customer1.getName();
        cnumber = customer1.getContactNumber();
        cid=customer1.getCustomerId();
    }
    String q="INSERT INTO Placedorders (CustomerName, ContactNumber, ProductName, ProductPrice, Quantity) SELECT cr.CustomerName, cr.ContactNumber, p.productName, p.productPrice, c.no_of_items AS Quantity FROM CartTable c JOIN products p ON c.ProductID = p.productId JOIN Customer_Registration cr ON c.CustomerID = cr.CustomerID WHERE c.no_of_items != 0 AND cr.CustomerName = ? AND cr.ContactNumber=?";
    String query0 = "INSERT INTO Orders (CustomerName, ContactNumber, ProductName, ProductPrice, Quantity) SELECT cr.CustomerName, cr.ContactNumber, p.productName, p.productPrice, c.no_of_items AS Quantity FROM CartTable c JOIN products p ON c.ProductID = p.productId JOIN Customer_Registration cr ON c.CustomerID = cr.CustomerID WHERE c.no_of_items != 0 AND cr.CustomerName = ? AND cr.ContactNumber=?";
    try (PreparedStatement pstmt = DBHelper.getPreparedStatement(query0);PreparedStatement pstmt1 = DBHelper.getPreparedStatement(q)) {
    	pstmt.setString(1,cname);
    	pstmt.setString(2,cnumber);
    	pstmt1.setString(1,cname);
    	pstmt1.setString(2,cnumber);
    	pstmt1.executeUpdate();
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
%>

<jsp:include page="./commons/Footer.jsp"/>

<script>
    // Pass the customer name and number to JavaScript
    var cname = "<%= cname %>";
    var cnumber = "<%= cnumber %>"; 
    var sanitizedCname = cname.replace(/\s+/g, "");

    
    var date = new Date();
	var current_date = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+ date.getDate();
	var current_time = date.getHours()+":"+date.getMinutes()+":"+ date.getSeconds();
	var date_time = current_date+" "+current_time;
	
    // Generate a random Order ID
    function generateOrderID() {
        var orderID = 'ORD' + Math.floor(Math.random() * 1000000);
        document.getElementById("orderID").textContent = orderID;
        return orderID; // Return generated ID for use in other functions
    }

    // Trigger the order ID generation on page load
    window.onload = function () {
        generateOrderID();
    };

    // Generate PDF Invoice
    document.getElementById("downloadInvoice").onclick = function () {
        var jsPDF = window.jspdf.jsPDF;
        var pdf = new jsPDF();

        // Mock order details for the invoice
        var products = [
            <% 
                String query = "SELECT * FROM ORDERS WHERE CustomerName = ? AND ContactNumber = ?";
                try (PreparedStatement pstmt = DBHelper.getPreparedStatement(query)) {
                    pstmt.setString(1, cname);
                    pstmt.setString(2, cnumber);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        out.print("{name: '" + rs.getString("ProductName") + "', price: " + rs.getInt("ProductPrice") + ", quantity: " + rs.getInt("Quantity") + "},");
                    }
                    String abc="DELETE FROM orders WHERE CustomerName = ? AND ContactNumber = ?";
                  
                    String cartQuery="DELETE FROM CartTable WHERE CustomerID = ?";
                    try(PreparedStatement pabc = DBHelper.getPreparedStatement(abc);
                    		PreparedStatement pcartQuery = DBHelper.getPreparedStatement(cartQuery)){
                    	
                    	pabc.setString(1,cname);
                    	pabc.setString(2,cnumber);
                    	
                    	
                    	
                    	pcartQuery.setInt(1,cid);
                    	
                    	
                    	
                    	pcartQuery.executeUpdate();
                    	pabc.executeUpdate();
                    	
                    }catch(SQLException e){
                    	e.printStackTrace();
                    }
                    
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        ];

        var orderID = document.getElementById("orderID").textContent;
		
        // Calculate total price
        var totalPrice = 0;
        for (var i = 0; i < products.length; i++) {
            totalPrice += products[i].price * products[i].quantity;
        }

     // PDF Title and Header
        pdf.setFont("helvetica", "bold"); // Bold font for title
        pdf.setFontSize(18);
        pdf.text("Online Grocery Ordering", 20, 20);

        pdf.setFont("helvetica", "bold"); // Bold font for labels
        pdf.setFontSize(12);
        pdf.text("Invoice No.:", 20, 30);
        pdf.setFont("helvetica", "normal");
        pdf.text(orderID, 50, 30);

        pdf.setFont("helvetica", "bold");
        pdf.text("Name:", 20, 40);
        pdf.setFont("helvetica", "normal");
        pdf.text(cname, 50, 40);

        pdf.setFont("helvetica", "bold");
        pdf.text("Contact:", 20, 50);
        pdf.setFont("helvetica", "normal");
        pdf.text(cnumber, 50, 50);
        
        pdf.setFont("helvetica", "bold");
        pdf.text("Date & Time:", 20, 60);
        pdf.setFont("helvetica", "normal");
        pdf.text(date_time, 50, 60);

        // Table Header inside Table with Borders
        var startY = 70;
        pdf.setFillColor(3, 69, 107);
        pdf.rect(18,startY-8,180,10,'F');
        pdf.setFont("helvetica", "bold");
        pdf.setTextColor("black");// Bold headers
       // pdf.rect(18, startY - 8, 180, 10); // Border for header row
       // pdf.line(98, startY - 8, 98, startY + 2); // Vertical line 1
       // pdf.line(138, startY - 8, 138, startY + 2); // Vertical line 2
       // pdf.line(178, startY - 8, 178, startY + 2); // Vertical line 3

        pdf.text("Product", 20, startY);
        pdf.text("Price", 100, startY);
        pdf.text("Quantity", 140, startY);
        pdf.text("Total", 180, startY);
	
        // Table Rows with Borders
        var currentY = startY + 10;
        for (var j = 0; j < products.length; j++) {
            pdf.rect(18, currentY - 8, 180, 10); // Border around each row
            pdf.line(98, currentY - 8, 98, currentY + 2); // Vertical line 1
            pdf.line(138, currentY - 8, 138, currentY + 2); // Vertical line 2
            pdf.line(178, currentY - 8, 178, currentY + 2); // Vertical line 3

            pdf.setFont("helvetica", "normal"); // Normal font for rows
            pdf.text(products[j].name, 20, currentY);
            pdf.text("" + products[j].price, 100, currentY);
            pdf.text(products[j].quantity.toString(), 140, currentY);
            pdf.text("Rs " + (products[j].price * products[j].quantity).toString(), 180, currentY);
            currentY += 10;
        }

        // Grand Total in Bold
        pdf.setFont("helvetica", "bold");
        pdf.setFontSize(14);
        pdf.text("Grand Total: Rs " + totalPrice, 20, currentY + 10);
        
     // Thank You Message
        pdf.setFontSize(12);
        pdf.setFont("helvetica", "italic"); // Italic for Thank You
        pdf.text("Thank you for shopping with us!", 20, currentY + 25);

        // Trademark Message
        var pageHeight = pdf.internal.pageSize.height;
        pdf.setFontSize(10);
        pdf.setFont("helvetica", "normal"); // Normal for Trademark
        
        pdf.text("\u00A9 2024 Online Grocery Ordering. All Rights Reserved.", 20, pageHeight-10);

        // Save PDF
        pdf.save(sanitizedCname+"_Invoice_" + orderID + ".pdf");
    };
</script>
</body>
</html>
