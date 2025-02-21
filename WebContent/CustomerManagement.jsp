<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.helper.DBHelper" %>
<%@ page import="java.io.*" %>
<%@ page import="com.entity.Customer" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers</title>
    <style>
        /* General Reset */
        body {
            margin: 0;
            font-family: "Poppins", sans-serif; /* Updated to match the font family */
            background-color: #ffffff; /* White background for the whole page */
            color: #333; /* Dark text color */
        }

        nav {
            background-color: #03456B; /* Dark blue background */
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }

        nav .logo {
            font-size: 1.5em;
            font-weight: bold;
        }

        #homepageLogo {
            text-decoration: none;
            color: #ffffff;
        }

        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        nav ul li {
            margin-left: 20px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
        }

        nav ul li a:hover {
            text-decoration: underline;
        }

        .container {
            padding: 20px;
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .search-bar {
            display: flex;
            justify-content: center;
            margin: 20px auto;
        }

        .search-bar form {
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
            max-width: 600px;
        }

        .search-bar input[type="text"] {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
        }

        .search-bar button {
            padding: 12px 20px;
            background-color: #03456B; /* Dark blue background */
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }

        .search-bar button:hover {
            background-color: #012f4c; /* Darker blue on hover */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table thead {
            background-color: #03456B; /* Dark blue */
            color: #fff;
        }

        table th, table td {
            padding: 10px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table tbody tr:nth-child(even) {
            background-color: #f0f8ff; /* Light blue background for even rows */
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .delete-button {
            background-color: #e74c3c; /* Red for delete */
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .delete-button:hover {
            background-color: #c0392b; /* Darker red on hover */
        }
    </style>
</head>
<body>
<jsp:include page="./commons/AdminNavBar.jsp" />
    <div class="search-bar">
        <form action="" method="post">
            <input type="text" name="searchcustomerName" placeholder="Search by Customer Name">
            <button type="submit">Search</button>
        </form>
    </div>

<div class="search-result">
    <%
        String searchName = request.getParameter("searchcustomerName");
        if (searchName != null && !searchName.isEmpty()) {
            try {
                // Use LIKE with wildcards for partial matching
                String searchQuery = "SELECT * FROM Customer_Registration WHERE CustomerName LIKE ?";
                PreparedStatement searchStmt = DBHelper.getPreparedStatement(searchQuery);
                searchStmt.setString(1, "%" + searchName + "%");  // '%' is the wildcard for any number of characters

                ResultSet searchResult = searchStmt.executeQuery();

                if (searchResult != null && searchResult.next()) {
                    // Begin the table and show the header
    %>
                    <div class="container">
                        <h2>Search Results</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>CustomerID</th>
                                    <th>CustomerName</th>
                                    <th>Email</th>
                                    <th>Address</th>
                                    <th>ContactNumber</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
    <%
                    // After finding the first result, now iterate through the rest of the results
                    do {
                        int customerId = searchResult.getInt("CustomerID");
                        String customerName = searchResult.getString("CustomerName");
                        String email = searchResult.getString("Email");
                        String password = searchResult.getString("Password");
                        String address = searchResult.getString("Address");
                        String contactNumber = searchResult.getString("ContactNumber");
    %>
                        <tr>
                            <td><%= customerId %></td>
                            <td><%= customerName %></td>
                            <td><%= email %></td>
                            <td><%= address %></td>
                            <td><%= contactNumber %></td>
                             <td>
                                        <form method="post" action="admin" id="customerDelete">
                                            <input type="hidden" value="DeleteCustomer" name="action" />
                                            <input type="hidden" name="customerId" value="<%= customerId %>" />
                                            <button type="submit" class="delete-button">Delete</button>
                                        </form>
                                    </td>
                        </tr>
    <%
                    } while (searchResult.next()); // Continue to the next result
    %>
                            </tbody>
                        </table>
                    </div>
    <%
                } else {
    %>
                    <div class="container">
                        <h2>No customers found with the name: <%= searchName %></h2>
                    </div>
    <%
                }
                searchResult.close();
                searchStmt.close();
            } catch (Exception e) {
                out.println("<div class='container'><h2>Error: " + e.getMessage() + "</h2></div>");
                e.printStackTrace();
            } finally {
                DBHelper.close();
            }
        }
    %>
</div>

    <% if (searchName == null || searchName.isEmpty()) { %>
        <div class="container">
            <h2>All Customers</h2>
            <table>
                <thead>
                    <tr>
                        <th>CustomerID</th>
                        <th>CustomerName</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Address</th>
                        <th>ContactNumber</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String sql = "SELECT * FROM Customer_Registration";
                        try (PreparedStatement pstmt = DBHelper.getPreparedStatement(sql)) {
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                int customerId = rs.getInt("CustomerID");
                                String customerName = rs.getString("CustomerName");
                                String email = rs.getString("Email");
                                String password = rs.getString("Password");
                                String address = rs.getString("Address");
                                String contactNumber = rs.getString("ContactNumber");
                    %>
                                <tr>
                                    <td><%= customerId %></td>
                                    <td><%= customerName %></td>
                                    <td><%= email %></td>
                                    <td><%= password %></td>
                                    <td><%= address %></td>
                                    <td><%= contactNumber %></td>
                                    <td>
                                        <form method="post" action="admin" id="customerDelete">
                                            <input type="hidden" value="DeleteCustomer" name="action" />
                                            <input type="hidden" name="customerId" value="<%= customerId %>" />
                                            <button type="submit" class="delete-button">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                    <%
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    <% } %>
</body>
</html>
