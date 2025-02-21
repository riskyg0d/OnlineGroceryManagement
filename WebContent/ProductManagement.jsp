<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="java.io.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <style>
    /* General Reset */
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f9f9f9; /* Neutral background color */
        color: #333;
    }

    .container {
        padding: 20px;
        max-width: 1200px;
        margin: 20px auto;
        background-color: #ffffff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    .search-bar {
        margin-bottom: 20px;
    }

    .search-bar form {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
    }

    .search-bar input[type="text"] {
        flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 1em;
    }

    .search-bar button {
        padding: 10px 20px;
        background-color: #03456b; /* Primary color */
        color: #ffffff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1em;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .search-bar button:hover {
        background-color: #7ca6c8; /* Button hover color */
    }

    .button-container {
        display: flex;
        flex-direction: row;
        gap: 120px;
        align-items: center;
        justify-content: center;
        margin-top: 2rem;
    }

    .button-link {
        text-decoration: none;
        background-color: #03456b; /* Primary button color */
        color: white;
        padding: 15px 25px;
        border-radius: 5px;
        font-size: 16px;
        font-weight: bold;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .button-link:hover {
        background-color: #7ca6c8; /* Button hover color */
        transform: translateY(-3px);
    }

    .button-link:active {
        transform: translateY(1px);
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    table thead {
        background-color: #012f4c; /* Primary color */
        color: #fff;
    }

    table th, table td {
        padding: 10px 15px;
        text-align: left;
        border: 1px solid #ddd;
    }

    table tbody tr:nth-child(even) {
        background-color: #f4f4f9; /* Light alternate row color */
    }

    table tbody tr:hover {
        background-color: #e0e8f0; /* Subtle hover color */
    }

    .delete-button {
        background-color: #e74c3c; /* Danger button color */
        color: #fff;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
    }

    .delete-button:hover {
        background-color: #c0392b; /* Button hover color */
    }
</style>

</head>
<body>
<jsp:include page="./commons/AdminNavBar.jsp" />

    <div class="container">
        <div class="search-bar">
            <form method="post" action="ProductManagement.jsp">
                <input type="text" name="searchProductName" placeholder="Search by Product Name">
                <button type="submit">Search</button>
            </form>
        </div>

        <%
            String searchProductName = request.getParameter("searchProductName");
            if (searchProductName != null && !searchProductName.trim().isEmpty()) {
            	searchProductName=searchProductName.toLowerCase();
                try {
                    String searchQuery = "SELECT * FROM products WHERE lower(productName) LIKE ?";
                    PreparedStatement searchStmt = DBHelper.getPreparedStatement(searchQuery);
                    searchStmt.setString(1, "%" + searchProductName + "%");

                    ResultSet searchResult = searchStmt.executeQuery();

                    if (searchResult.next()) {
        %>
                        <h2>Search Results</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>ProductID</th>
                                    <th>ProductName</th>
                                    <th>Price</th>
                                    <th>URL</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    do {
                                        int productId = searchResult.getInt("productId");
                                        String productName = searchResult.getString("productName");
                                        double productPrice = searchResult.getDouble("productPrice");
                                        String imgUrl = searchResult.getString("imgUrl");
                                        String productDescription = searchResult.getString("productDescription");
                                %>
                                    <tr>
                                        <td><%= productId %></td>
                                        <td><%= productName %></td>
                                        <td><%= productPrice %></td>
                                        <td><%= imgUrl %></td>
                                        <td><%= productDescription %></td>
                                        
                                        <td>
                                            <form method="post" action="admin">
                                                <input type="hidden" name="action" value="DeleteProduct">
                                                <input type="hidden" name="productId" value="<%= productId %>">
                                                <button type="submit" class="delete-button">Delete</button>
                                            </form>
                                        </td>
                                        
                                        <td>
                                            <form method="post" action="UpdateProduct.jsp">
                                                
                                                <input type="hidden" name="productId" value="<%= productId %>">
                                                <button type="submit" class="delete-button">Update Product</button>
                                            </form>
                                        </td>
                                       
                                    </tr>
                                <%
                                    } while (searchResult.next());
                                %>
                            </tbody>
                        </table>
        <%
                    } else {
        %>
                        <h2>No products found for "<%= searchProductName %>"</h2>
        <%
                    }
                    searchResult.close();
                    searchStmt.close();
                } catch (SQLException e) {
                    out.println("<h2>Error: " + e.getMessage() + "</h2>");
                }
            } else {
        %>
                <h2>All Products</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ProductID</th>
                            <th>ProductName</th>
                            <th>Price</th>
                            <th>URL</th>
                            <th>Description</th>
                            <th>Actions</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String sql = "SELECT * FROM products";
                            try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    int productId = rs.getInt("productId");
                                    String productName = rs.getString("productName");
                                    double productPrice = rs.getDouble("productPrice");
                                    String imgUrl = rs.getString("imgUrl");
                                    String productDescription = rs.getString("productDescription");
                        %>
                                <tr>
                                    <td><%= productId %></td>
                                    <td><%= productName %></td>
                                    <td><%= productPrice %></td>
                                    <td><%= imgUrl %></td>
                                    <td><%= productDescription %></td>
                                    <td>
                                        <form method="post" action="admin">
                                            <input type="hidden" name="action" value="DeleteProduct">
                                            <input type="hidden" name="productId" value="<%= productId %>">
                                            <button type="submit" class="delete-button">Delete</button>
                                        </form>
                                    </td>
                                    <td>
                                            <form method="post" action="UpdateProduct.jsp">
                                                
                                                <input type="hidden" name="productId" value="<%= productId %>">
                                                <button type="submit" class="delete-button">Update Product</button>
                                            </form>
                                        </td>
                                </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
        <%
            }
        %>

        <div class="button-container">
            <a href="AddProduct.jsp" class="button-link">Add Product</a>
        </div>
    </div>
</body>
</html>
