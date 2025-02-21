<%@ page import="com.entity.Customer" %>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: url('success-bg.jpg') no-repeat center center;
            background-size: cover;
            color: #333;
        }
        .wrapper {
            width: 450px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h1 {
            color: green;
            font-size: 28px;
            margin-bottom: 20px;
        }
        p {
            margin: 10px 0;
            font-size: 16px;
        }
        .highlight {
            font-weight: bold;
            color: #555;
        }
        .btn {
            display: inline-block;
            width: 100%;
            margin-top: 20px;
            padding: 10px;
            background: #07800f;
            color: #fff;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <h1>Customer Registration Successful!</h1>
        <p><strong>Customer ID:</strong> <span class="highlight"><%= request.getAttribute("customer") != null ? ((Customer) request.getAttribute("customer")).getCustomerId() : "N/A" %></span></p>
        <p><strong>Customer Name:</strong> <span class="highlight"><%= request.getAttribute("customer") != null ? ((Customer) request.getAttribute("customer")).getName() : "N/A" %></span></p>
        <p><strong>Email:</strong> <span class="highlight"><%= request.getAttribute("customer") != null ? ((Customer) request.getAttribute("customer")).getEmail() : "N/A" %></span></p>
        <a href="LoginPage.jsp" class="btn">Go to Login</a>
    </div>
</body>
</html>
