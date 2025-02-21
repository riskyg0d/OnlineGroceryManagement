<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to FreshMart</title>
    <style>
    /* General Reset */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
}

.container {
  width: 90%;
  max-width: 1200px;
  margin: 0 auto;
}

/* Header Section */
.hero {
  background: linear-gradient(to right, #03456B, #012f4c);
  color: white;
  text-align: center;
  padding: 50px 20px;
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.nav-links {
  list-style: none;
  display: flex;
  gap: 20px;
}

.nav-links a {
  color: white;
  text-decoration: none;
  font-weight: bold;
  transition: color 0.3s;
}

.nav-links a:hover {
  color: #7ca6c8;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 20px;
}

.hero-content p {
  font-size: 1.2rem;
  margin-bottom: 30px;
}

.btn {
  display: inline-block;
  padding: 10px 25px;
  background: white;
  color: #012f4c;
  text-decoration: none;
  font-weight: bold;
  border-radius: 5px;
  transition: background 0.3s, color 0.3s;
}

.btn:hover {
  background: #7ca6c8;
  color: #012f4c;
}

/* About Section */
.about-section {
  padding: 50px 20px;
  background: #f9f9f9;
  text-align: center;
}

.about-section h2 {
  font-size: 2.5rem;
  margin-bottom: 20px;
}

/* Products Section */
.products-section {
  padding: 50px 20px;
  background: white;
}

.products-section h2 {
  text-align: center;
  font-size: 2.5rem;
  margin-bottom: 30px;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.product-card {
  text-align: center;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 20px;
  transition: transform 0.3s, box-shadow 0.3s;
}

.product-card img {
  width: 100%;
  max-width: 150px;
  margin-bottom: 15px;
}

.product-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

/* Footer */
.footer {
        background: #012f4c;
        color: white;
        padding: 40px 20px;
    }

    .footer .container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .footer-content {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 30px;
    }

    .footer-section {
        flex: 1;
        min-width: 250px;
    }

    .footer-section h2 {
        font-size: 1.5rem;
        margin-bottom: 15px;
    }

    .footer-section p,
    .footer-section ul {
        font-size: 0.9rem;
        line-height: 1.6;
    }

    .footer-section ul {
        list-style: none;
        padding: 0;
    }

    .footer-section ul li {
        margin-bottom: 10px;
    }

    .footer-section ul li a {
        text-decoration: none;
        color: #7ca6c8;
        transition: color 0.3s;
    }

    .footer-section ul li a:hover {
        color: #fff;
    }

    .footer-bottom {
    text-align: center;
    padding-top: 20px;
    font-size: 0.8rem;
    border-top: 1px solid #7ca6c8;
    margin: 0 auto;
    width: calc(100% - 40px); /* Makes the line shorter with 20px gap on each side */
    max-width: 1200px; /* Ensures it doesn't stretch too wide on larger screens */
}





    /* Responsive Design */
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            gap: 30px;
        }
    }
  </style>
</head>
<body>
   
   <header class="hero">
    <div class="container">
      <nav class="navbar">
        <div class="logo" href="WelcomePage.jsp">FreshMart</div>
        <ul class="nav-links">
          <li><a href="LoginPage.jsp">Login</a></li>
          <li><a href="RegisterPage.jsp">Register</a></li>
          <li><a href="AdminLogin.jsp">Admin</a></li>
        </ul>
      </nav>
      <div class="hero-content">
        <h1>Welcome to FreshMart</h1>
        <p>Your one-stop shop for the freshest groceries.</p>
        <a href="HomePage.jsp" class="btn">Shop Now</a>
      </div>
    </div>
  </header>
   
    <section id="products" class="products-section">
    <div class="container">
      <h2>Our Products</h2>
      <div class="product-grid">
        <div class="product-card">
          <img src="./images/freshfruits.jpg" alt="Fruits">
          <h3>Fresh Fruits</h3>
        </div>
        <div class="product-card">
          <img src="./images/organicvegetables.jpg" alt="Vegetables">
          <h3>Organic Vegetables</h3>
        </div>
        <div class="product-card">
          <img src="./images/dairyproducts.jpg" alt="Dairy">
          <h3>Dairy Products</h3>
        </div>
        <div class="product-card">
          <img src="./images/healthysnacks.jpg" alt="Snacks">
          <h3>Healthy Snacks</h3>
        </div>
      </div>
    </div>
  </section>
  
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <!-- About Section -->
            <div class="footer-section about">
                <h2>About Us</h2>
                <p>
                    Welcome to FreshMart, your go-to destination for fresh groceries and quality products. 
                    We aim to deliver the best shopping experience right to your doorstep.
                </p>
            </div>
            <!-- Quick Links Section -->
            <div class="footer-section links">
                <h2>Quick Links</h2>
                <ul>
                    <li><a href="HomePage.jsp">Home</a></li>
                    <li><a href="MyProfile.jsp">My Profile</a></li>
                    <li><a href="Wishlist.jsp">Wishlist</a></li>
                    <li><a href="Cart.jsp">Cart</a></li>
                </ul>
            </div>
            <!-- Contact Section -->
            <div class="footer-section contact">
                <h2>Contact Us</h2>
                <p>Email: support@grocerystore.com</p>
                <p>Phone: +91 123 456 7890</p>
                <p>Address: 123 Market Street, Mumbai, India</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 Online Grocery Store. All rights reserved.</p>
        </div>
    </div>
</footer>
  
</body>
</html>