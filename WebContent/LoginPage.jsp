<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
    pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap");
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            display: flex;
            justify-content: center;  /* Horizontally center */
            align-items: center;      /* Vertically center */
            min-height: 100vh;
            background: url('images/Login.jpg') no-repeat;
            background-size: cover;
            background-position: center;
        }
        .wrapper {
            width: 420px;
            background: rgba(0, 0, 50, 0.6); /* Subtle blue overlay */
            border: 2px solid rgba(255, 255, 255, .2);
            backdrop-filter: blur(10px);
            box-shadow: 0 0 10px rgba(0, 0, 0, .5);
            color: #fff;
            padding: 30px 40px;
            border-radius: 8px; /* Add border-radius for rounded corners */
        }
        .wrapper h1 {
            font-size: 36px;
            text-align: center;
            margin: 20px 0 30px;
            color: #ffffff;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.8);
        }
        .wrapper .input-box {
            position: relative;
            width: 100%;
            height: 50px;
            margin: 20px 0;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 20px;
            color: #ffffff;
        }
        .input-box input {
            width: 100%;
            height: 100%;
            background: transparent;
            border: 2px solid #3498db;
            outline: none;
            border-radius: 5px; /* Square-ish corners */
            font-size: 16px;
            color: #fff;
            padding: 15px 15px 15px 20px;
        }
        .input-box input::placeholder {
            color: #cfcfcf;
        }
        .wrapper .remember-forget {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            margin: -10px 0 15px;
            color: #fff;
        }
        .remember-forget label input {
            accent-color: #ffffff;
            margin-right: 5px;
        }  
        .wrapper .btn {
            width: 100%;
            height: 45px;
            background: #3498db; /* Blue theme color */
            border: none;
            outline: none;
            border-radius: 5px; /* Square corners */
            box-shadow: 0 2px 5px rgba(0, 0, 0, .2);
            cursor: pointer;
            font-size: 16px;
            color: #fff;
            font-weight: 600;
            transition: background 0.3s ease;
        }
        .wrapper .btn:hover {
            background: #217dbb; /* Darker blue on hover */
        }
        .wrapper .register-link {
            font-size: 14px;
            text-align: center;
            margin-top: 15px;
        }
        .register-link p a {
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .register-link p a:hover {
            color: #fdd835;
            text-decoration: underline;
        }
    </style>
    <title>Login Page</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="wrapper">
        <form action="customer" method="POST" id="loginForm">
            <input type="hidden" value="login" name="action"/>
            <h1>Login</h1>
            <div class="input-box">
                <input type="email" placeholder="Email" name="email" id="email" required />
            </div>
            <div class="input-box">
                <input type="password" placeholder="Password" name="password" id="password" required maxlength="30" />
                <i class="bx bxs-show password-toggle" onclick="togglePasswordVisibility()"></i>
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="register-link">
                <p>New User? <a href="RegisterPage.jsp">Register Yourself</a></p>
            </div>
            <div id="error-message" style="color: rgb(255, 191, 0); display: <%=(request.getAttribute("error") != null ? "block" : "none")%>; margin-top: 10px;">
                <p id="error-text"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
            </div>
        </form>
    </div>
    <script>
        // Toggle password visibility
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById("password");
            const toggleIcon = document.querySelector(".password-toggle");

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleIcon.classList.remove("bxs-show");
                toggleIcon.classList.add("bxs-hide");
            } else {
                passwordInput.type = "password";
                toggleIcon.classList.remove("bxs-hide");
                toggleIcon.classList.add("bxs-show");
            }
        }

        // Hash the password before form submission
        document.getElementById("loginForm").onsubmit = function(event) {
            const passwordField = document.getElementById("password");

            // Check if password is empty
            if (passwordField.value.trim() === "") {
                alert("Password cannot be empty.");
                event.preventDefault();
                return false;
            }
        };
    </script>
</body>
</html>