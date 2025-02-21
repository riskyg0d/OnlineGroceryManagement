<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.entity.Customer" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FreshMart</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <style>
    @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap");
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }
    html, body{
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    body {
        background-color: #ffffff;
        color: #333;
    }
    header {
        text-align: center;
        margin: 20px 0;
        font-size: 28px;
        font-weight: 500;
        color: #012f4c; /* Dark blue */
    }

    .search-bar-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px;
    }
    .search-bar-container input[type="text"],
    .search-bar-container input[type="number"] {
        width: 300px;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin-right: 10px;
    }

    .search-bar-container button {
        background-color: #03456B; /* Dark blue */
        color: #fff;
        border: none;
        padding: 10px 15px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
    }
    .search-bar-container button:hover {
        background-color: #012f4c; /* Darker blue for hover */
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        padding: 20px;
    }
    .product-card {
        position: relative;
        margin: 10px;
        background-color: #f0f8ff; /* Light blue background */
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
        text-align: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }
    .product-card img {
        width: 100%;
        max-height: 200px;
        object-fit: cover;
        margin-bottom: 15px;
        border-radius: 5px;
    }
    .product-card h3 {
        font-size: 20px;
        margin: 10px 0;
        color: #012f4c; /* Dark blue */
    }

    .wishlist-btn {
        border: none;
        background: none;
        cursor: pointer;
        font-size: 24px;
        color: #7ca6c8; /* Light blue */
        margin-left: 10px;
    }

    .wishlist-btn.liked {
        color: red; /* Red color when clicked */
    }

    .wishlist-btn:hover {
        opacity: 0.8;
    }

    .quantity-controls {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 15px 0;
        width: 160px; /* Reduced width of the entire section */
        margin-left: auto;
        margin-right: auto;
    }

    /* Styling for the + and - buttons */
    .quantity-controls button {
        background-color: #03456B; /* Dark blue */
        color: #fff;
        border: none;
        padding: 6px 12px;  /* Smaller padding for buttons */
        font-size: 18px;
        cursor: pointer;
        border-radius: 50%;
        width: 35px;  /* Smaller width */
        height: 35px; /* Smaller height */
        display: flex;
        justify-content: center;
        align-items: center;
        transition: background-color 0.3s ease;
    }

    /* Hover effect for the buttons */
    .quantity-controls button:hover {
        background-color: #012f4c; /* Darker blue */
    }

    /* Styling for the quantity input */
    .quantity-controls input[type="text"] {
        width: 40px;  /* Reduced width for the input */
        text-align: center;
        font-size: 18px;
        padding: 5px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin: 0 8px;  /* Reduced margin between the input and buttons */
        background-color: #f8f9fa;
        font-weight: bold;
    }

    /* Adjust input for better visibility */
    .quantity-controls input[type="text"]:readonly {
        background-color: #e9ecef; /* Light grey for readonly state */
        color: #333;
    }
    .confirm-button {
        background-color: #03456B; /* Dark blue */
        color: #fff;
        border: none;
        padding: 10px 15px;
        font-size: 16px;
        cursor: pointer;
        text-align: center;
        border-radius: 4px;
    }
    .confirm-button:hover {
        background-color: #012f4c; /* Darker blue */
    }
</style>


</head>

<body>
<%
    if (session.getAttribute("customer") != null) {
        Customer customer = (Customer) session.getAttribute("customer");
        
%>
    <jsp:include page="./commons/publicNavBar.jsp" />
    <header>Welcome, <%= customer.getName() %> to FreshMart</header>
    <div class="search-bar-container">
        <!-- Search Form -->
        <form action="HomePage.jsp" method="get" style="display: flex;">
            <input type="text" name="searchProductName" placeholder="Search for products...">
            <input type="number" name="minPrice" placeholder="Min Price" min="0">
            <input type="number" name="maxPrice" placeholder="Max Price" min="0">
            <button type="submit">Search</button>
        </form>
    </div>
    
      <%
        String searchProductName = request.getParameter("searchProductName");
   		String minPriceStr = request.getParameter("minPrice");
   		String maxPriceStr = request.getParameter("maxPrice");
   		
   		double minPrice = (minPriceStr!=null && !minPriceStr.trim().isEmpty())? Double.parseDouble(minPriceStr):0;
   		double maxPrice = (maxPriceStr!=null && !maxPriceStr.trim().isEmpty())? Double.parseDouble(maxPriceStr):Double.MAX_VALUE;
   		
        String sql = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.imgUrl, " +
                     "COALESCE(c.no_of_items, 0) AS cartQuantity " +
                     "FROM PRODUCTS p " +
                     "LEFT JOIN CartTable c ON p.productId = c.ProductID AND c.Email = ? WHERE p.PQUANTITY>0";

        String customerEmail = customer.getEmail();

        // Case-insensitive search handling
        if (searchProductName != null && !searchProductName.trim().isEmpty()) {
            sql += " WHERE LOWER(p.productName) LIKE ?";
        }
        
        if(minPrice>0){
        	sql +=(searchProductName != null && !searchProductName.trim().isEmpty())?"AND p.productPrice >= ?":"Where p.productPrice>=?";
        }
        
        if(maxPrice<Double.MAX_VALUE){
        	sql +=(minPrice >0 ||(searchProductName != null && !searchProductName.trim().isEmpty()))?"AND p.productPrice <= ?":"Where p.productPrice<=?";
        }
        
       

        try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
            pstmt.setString(1, customerEmail);
            
            int paramIndex =2;

            if (searchProductName != null && !searchProductName.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + searchProductName.toLowerCase() + "%"); // Case-insensitive search
            }
            
            if(minPrice>0){
            	pstmt.setDouble(paramIndex++,minPrice);
            }
            
            if(maxPrice<Double.MAX_VALUE){
            	pstmt.setDouble(paramIndex++,maxPrice);
            }
            ResultSet rs = pstmt.executeQuery();

            // If products found
            if (rs.next()) {
    %>

    <section class="product-grid">
		    <%
		            // Display each product
		            do {
		                int productId = rs.getInt("productId");
		                String productName = rs.getString("productName");
		                String productDescription = rs.getString("productDescription");
		                double productPrice = rs.getDouble("productPrice");
		                String imgUrl = rs.getString("imgUrl");
		                int cartQuantity = rs.getInt("cartQuantity");
		        %>
		        
		<div class="product-card">
		    <!-- Product Image -->
		    <img src="<%= imgUrl != null ? imgUrl : "images/default-product.jpg" %>" alt="<%= productName %>">
		
		    <!-- Product Name -->
		    <h3><%= productName %></h3>
		
		    <!-- Product Description -->
		    <p><%= productDescription %></p>
		
		    <!-- Product Price -->
		    <p>Rs. <%= productPrice %> / kg</p>
		
		    <!-- Quantity Controls -->
		    <div class="quantity-controls">
		        <!-- Decrement Button -->
		        <form action="RemoveFromCart" method="post" style="display: inline;">
		            <input type="hidden" name="id" value="<%= productId %>">
		            <button type="submit">-</button>
		        </form>
		
		        <input type="text" name="quantity" value="<%= cartQuantity > 0 ? cartQuantity : 0 %>" readonly>
		
		        <!-- Increment Button -->
		        <form action="AddToCart" method="post" style="display: inline;">
		            <input type="hidden" name="id" value="<%= productId %>">
		            <button type="submit">+</button>
		        </form>    
		                <!-- Add to Wishlist -->
		        <form action='AddToWishlist' method="post">
                <!-- Add to Wishlist -->
                <input type="hidden" name="id" value="<%= productId %>">
                <button type="submit" class="wishlist-btn" onclick="toggleWishlist(this, <%= productId %>)" title="Add to Wishlist">
                    <i class="fas fa-heart"></i>
                </button>
                </form>
		        
				</div>
		     </div>
		
		<% } while (rs.next()); %>
       
        <%
        }
        } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
        }
        %>
    </section>
    <jsp:include page="./commons/Footer.jsp"/>
<%
    } else {
        response.sendRedirect("LoginPage.jsp");
    }
%>

    <script>
    function incrementQuantity(button) {
        const input = button.previousElementSibling;
        input.value = parseInt(input.value) + 1;
    }

    function decrementQuantity(button) {
        const input = button.nextElementSibling;
        if (parseInt(input.value) > 1) {
            input.value = parseInt(input.value) - 1;
        }
    }
</script>
</body>

</html>