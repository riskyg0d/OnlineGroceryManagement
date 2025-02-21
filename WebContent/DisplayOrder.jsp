<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="java.io.*" %>
<%@ page import="com.entity.Product" %>
<%@ page import="com.entity.Admin" %>
<%@ page import="com.entity.Customer" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders</title>
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

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    table thead {
        background-color: #012f4c; /* Primary color */
        color: #ffffff; /* Text color for table header */
    }

    table th,
    table td {
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
        background-color: #03456b; /* Primary button color */
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
</style>

</head>
<body>
<%
    if (session.getAttribute("admin") != null) {
        Admin admin = (Admin) session.getAttribute("admin");
        
%>
<jsp:include page="./commons/AdminNavBar.jsp" />
    <div class="container">
    <div class="search-bar">
            <form method="post" action="DisplayOrder.jsp">
                <input type="text" name="searchCustomerName" placeholder="Search by Customer Name">
                <button type="submit">Search</button>
            </form>
    <br>
    <%
            String searchCustomerName = request.getParameter("searchCustomerName");
            if (searchCustomerName != null && !searchCustomerName.trim().isEmpty()) {
                try {
                    String searchQuery = "SELECT * FROM Placedorders WHERE CustomerName LIKE ?";
                    PreparedStatement searchStmt = DBHelper.getPreparedStatement(searchQuery);
                    searchStmt.setString(1, "%" + searchCustomerName + "%");

                    ResultSet searchResult = searchStmt.executeQuery();

                    if (searchResult.next()) {
        %>
                        <h2>Search Results</h2>
                        <table>
                            <thead>
                                <tr>
                    <th>Sr No</th>
                    <th>Customer Name</th>
                    <th> Product Purchased</th>
                    <th>Contact Number</th>
                    <th>Quantity</th>
                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    do {
                                        int Id = searchResult.getInt("id");
                                        String CustomerName = searchResult.getString("CustomerName");
                                        String ContactNumber = searchResult.getString("ContactNumber");
                                        String ProductName = searchResult.getString("ProductName");
                                        double ProductPrice = searchResult.getDouble("ProductPrice");
                                        int quantity=searchResult.getInt("Quantity");
                                %>
                                    <tr>
                                        <td><%= Id %></td>
                                        <td><%= CustomerName %></td>
                                        <td><%= ProductName %></td>
                                        <td><%= ContactNumber %></td>
                                        <td><%= quantity %></td>
                                        <td><%= ProductPrice %></td>
                                    </tr>
                                <%
                                    } while (searchResult.next());
                                %>
                            </tbody>
                        </table>
        <%
                    } else {
        %>
                        <h2>No Customer Found</h2>
        <%
                    }
                    searchResult.close();
                    searchStmt.close();
                } catch (SQLException e) {
                    out.println("<h2>Error: " + e.getMessage() + "</h2>");
                }
            } else {
        %>

        <!-- Theek vala part -->
    <h2>All Orders</h2>
        <table>
            <thead>
                <tr>
                    <th>Sr No</th>
                    <th>Customer Name</th>
                    <th> Product Purchased</th>
                    <th>Contact Number</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String sql = "SELECT id, CustomerName, ProductName, ContactNumber, ProductPrice, Quantity FROM Placedorders";

                    try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
                        ResultSet rs = pstmt.executeQuery();
                        while (rs.next()) {
                %>
                
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("CustomerName") %></td>
                    <td><%= rs.getString("ProductName") %></td>
                    <td><%= rs.getString("ContactNumber") %></td>
                    <td><%= rs.getInt("ProductPrice") %></td>
                    <td><%= rs.getDouble("ProductPrice") %></td>
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
        <%
    } else {
        response.sendRedirect("AdminLogin.jsp");
    }
%>
        
    </div>
    </div>
</body>
</html>