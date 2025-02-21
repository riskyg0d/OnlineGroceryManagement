<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
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
    background: url('images/Registration.jpg') no-repeat center center;
    background-size: cover;
}

        .wrapper {
            width: 420px;
            background: rgba(0, 0, 50, 0.6);
            border: 2px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(20px);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            color: #fff;
            padding: 20px 40px;
            min-height:100vh;
        }

        .wrapper h1 {
            font-size: 32px;
            text-align: center;
            margin-bottom: 20px;
        }

        .input-box {
            position: relative;
            width: 100%;
            margin: 10px;
        }

        .input-box input,
        .input-box textarea {
            width: 100%;
            background: transparent;
            border: none;
            outline: none;
            border: 2px solid #3498db;
            border-radius: 10px;
            font-size: 16px;
            color: #fff;
            padding: 10px 15px;
        }

        .input-box textarea {
            resize: none;
            height: 70px;
        }

        .input-box input::placeholder,
        .input-box textarea::placeholder {
            color: rgba(255, 255, 255, 1);
        }
        
        .cpass{
        	paddin-top:20px;
        }
        
        ul{	
        	margin: 10px 15px;
        	list-style-type:none;
        	font-size: 12px;
        }
        
        .error-message {
            color: #ffffff;
            font-size: 12px;
            margin-top: 5px;
            font-weight: bold;
        }

        .btn {
            width: 100%;
            height: 45px;
            background: #3498db;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            color: #fff;
            font-weight: 600;
            margin-top: 20px;
        }
        .btn:hover {
    		background: #217dbb; /* Darker blue on hover */
		}

        .register-link {
            font-size: 14.5px;
            text-align: center;
            margin-top: 20px;
        }

        .register-link p a {	
            text-decoration: none;
            font-weight: 600;
            color:rgba(255,255,255);
        }

        .register-link p a:hover {
            text-decoration: underline;
                color: #fff;
        }
         .password-toggle {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    font-size: 20px;
  }

  .input-box {
    position: relative;
    margin-bottom: 15px;
  }
    </style>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
   <div class="wrapper">
		<form action="customer" id="registrationForm" method="POST"
			onsubmit="return validateForm()">
			<input type="hidden" value="register" name="action" />
			<h1>Registration</h1>

			<div class="input-box">
				<input type="text" name="customerName" id="customerName"
					placeholder="Name" maxlength="50" oninput="validateName()">
				<div class="error-message" id="nameError"></div>
			</div>

			<div class="input-box">
				<input type="text" name="email" id="email" placeholder="Email"
					oninput="validateEmail()">
				<div class="error-message" id="emailError"></div>
			</div>

			<div class="input-box">
				<input type="password" name="password" id="password"
					placeholder="Password" maxlength="30" oninput="validatePassword()">
				<div class="error-message" id="passwordError"></div>
			</div>
			<div class="input-box">
				<input type="password" name="password" id="confpassword"
					placeholder="Confirm Password" maxlength="30"
					oninput="validateConfirmPassword()"> 
					<i class="bx bxs-show password-toggle" onclick="togglePasswordVisibility()"></i>
				<div class="error-message" id="confpasswordError"></div>
			</div>

			<div class="input-box">
				<textarea id="address" name="address" placeholder="Address"
					maxlength="100" oninput="validateAddress()"></textarea>
				<div class="error-message" id="addressError"></div>
			</div>

			<div class="input-box">
				<input type="text" name="contactNumber" id="contactNumber"
					placeholder="Phone Number" maxlength="10"
					oninput="validateContactNumber()">
				<div class="error-message" id="contactError"></div>
			</div>

			<button type="submit" class="btn" id="submitButton" disabled>Register</button>

			<div class="register-link">
				<p>
					Have an Account? <a href="LoginPage.jsp">Login</a>
				</p>
			</div>
		</form>
	</div>

	<script>
	document.getElementById("registrationForm").addEventListener("input", toggleSubmitButton);

	function toggleSubmitButton() {
	    const customerNameValid = validateName();
	    const emailValid = validateEmail();
	    const passwordValid = validatePassword();
	    const confPasswordValid = validateConfirmPassword();
	    const addressValid = validateAddress();
	    const contactNumberValid = validateContactNumber();

	    const isFormValid =
	        customerNameValid &&
	        emailValid &&
	        passwordValid &&
	        confPasswordValid &&
	        addressValid &&
	        contactNumberValid;

	    document.getElementById("submitButton").disabled = !isFormValid;
	}

	function validateName() {
	    const customerName = document.getElementById("customerName").value.trim();
	    const nameError = document.getElementById("nameError");
	    const nameRegex = /^[a-zA-Z\s]+$/;

	    if (!customerName) {
	        nameError.textContent = "Customer Name must not be blank.";
	        return false;
	    } else if (!nameRegex.test(customerName)) {
	        nameError.textContent = "Customer Name must have alphabets only.";
	        return false;
	    } else {
	        nameError.textContent = "";
	        return true;
	    }
	}

	function validateEmail() {
	    const email = document.getElementById("email").value.trim();
	    const emailError = document.getElementById("emailError");
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

	    if (!email) {
	        emailError.textContent = "Email must not be blank.";
	        return false;
	    } else if (!emailRegex.test(email)) {
	        emailError.textContent = "Email ID is not valid.";
	        return false;
	    } else {
	        emailError.textContent = "";
	        return true;
	    }
	}

	function validatePassword() {
	    const password = document.getElementById("password").value.trim();
	    const passwordError = document.getElementById("passwordError");
	    const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$/;

	    if (!password) {
	        passwordError.textContent = "Password must not be blank.";
	        return false;
	    } else if (!passwordRegex.test(password)) {
	        passwordError.textContent = "Password must have at least 1 uppercase letter, 1 digit, 1 special character, and be at least 5 characters long.";
	        return false;
	    } else {
	        passwordError.textContent = "";
	        return true;
	    }
	}

	function validateConfirmPassword() {
	    const password = document.getElementById("password").value.trim();
	    const confpassword = document.getElementById("confpassword").value.trim();
	    const confpasswordError = document.getElementById("confpasswordError");

	    if (password !== confpassword) {
	        confpasswordError.textContent = "Passwords do not match.";
	        return false;
	    } else {
	        confpasswordError.textContent = "";
	        return true;
	    }
	}

	function validateAddress() {
	    const address = document.getElementById("address").value.trim();
	    const addressError = document.getElementById("addressError");

	    if (!address) {
	        addressError.textContent = "Address must not be blank.";
	        return false;
	    } else {
	        addressError.textContent = "";
	        return true;
	    }
	}

	function validateContactNumber() {
	    const contactNumber = document.getElementById("contactNumber").value.trim();
	    const contactError = document.getElementById("contactError");
	    const contactRegex = /^[6-9]\d{9}$/;
	    const repeatedDigitsRegex = /(\d)\1{4}/;

	    if (!contactNumber) {
	        contactError.textContent = "Contact Number must not be blank.";
	        return false;
	    } else if (!contactRegex.test(contactNumber)) {
	        contactError.textContent = "Phone Number must start with a number greater than 6 and be 10 digits.";
	        return false;
	    } else if (repeatedDigitsRegex.test(contactNumber)) {
	        contactError.textContent = "Phone Number must not contain the same digit repeated 5 times consecutively.";
	        return false;
	    } else {
	        contactError.textContent = "";
	        return true;
	    }
	}
	
	function togglePasswordVisibility() {
        const passwordInput = document.getElementById("confpassword");
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

	</script>
</body>

        

</html>