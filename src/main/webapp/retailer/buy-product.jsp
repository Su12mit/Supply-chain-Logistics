<%
    String requestIDString = request.getParameter("loginId");
	String sourceType = request.getParameter("type");
    // Convert string to integer (handle potential errors)
    int requestID = 0; // Default value in case of an exception
   try {
       requestID = Integer.parseInt(requestIDString);
        //request.setAttribute("requestID", requestID);

    } catch (NumberFormatException e) {
       
    } 
    
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT shop_name  FROM retailer.retailer WHERE retailer_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String shop_name = rs.getString("shop_name");
    		 
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("shop_name", shop_name);
    		
		}
		


} catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
  %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Wholesaler Shopping Page</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
  <style>
    :root {
      --primary: #2e8bff;
      --secondary: #111;
      --accent: #ff6b6b;
      --light-bg: #f7f8fc;
      --card-bg: #fff;
      --text-dark: #333;
      --text-light: #777;
      --shadow: rgba(0, 0, 0, 0.1);
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: var(--light-bg);
      color: var(--text-dark);
    }

    header {
      background: linear-gradient(to right, var(--primary), #174ea6);
      color: white;
      padding: 25px 20px;
      box-shadow: 0 2px 6px var(--shadow);
    }

    .header-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 15px;
    }

    .brand-name {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 1.6rem;
      font-weight: bold;
    }

    .welcome-msg {
      font-size: 1rem;
      color: #e2e2e2;
    }

    .nav-right {
      display: flex;
      gap: 1rem;
      flex-wrap: wrap;
    }

    .search-bar {
      position: relative;
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .search-bar input {
      padding: 12px 15px;
      border-radius: 30px;
      border: none;
      width: 200px;
      box-shadow: 0 2px 4px var(--shadow);
    }

    .search-bar button {
      background-color: #fff;
      color: var(--primary);
      padding: 10px 15px;
      border: none;
      border-radius: 30px;
      cursor: pointer;
      font-weight: bold;
      display: flex;
      align-items: center;
      gap: 5px;
      box-shadow: 0 2px 4px var(--shadow);
      transition: background-color 0.3s ease;
    }

    .search-bar button:hover {
      background-color: #e8e8e8;
    }

    .categories select {
      padding: 12px 15px;
      border-radius: 30px;
      border: none;
      background-color: white;
      cursor: pointer;
      box-shadow: 0 2px 4px var(--shadow);
    }

    main {
      padding: 40px 20px;
      max-width: 1300px;
      margin: auto;
    }

    .product-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 25px;
    }

    .product-card {
      background-color: var(--card-bg);
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 12px var(--shadow);
      transition: transform 0.3s;
    }

    .product-card:hover {
      transform: translateY(-5px);
    }

    .product-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .product-info {
      padding: 15px;
    }

    .product-info h3 {
      font-size: 1.1rem;
      margin-bottom: 5px;
    }

    .product-info p {
      font-size: 0.95rem;
      margin: 3px 0;
      color: var(--text-light);
    }

    .manufacturer {
      font-size: 0.85rem;
      color: var(--text-light);
      padding: 0 15px;
    }

    .add-to-cart {
      background-color: var(--primary);
      color: white;
      border: none;
      width: 100%;
      padding: 12px;
      border-radius: 0 0 10px 10px;
      cursor: pointer;
      font-size: 0.95rem;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    .add-to-cart:hover {
      background-color: #0055cc;
    }

    .cart-icon {
      position: fixed;
      bottom: 25px;
      right: 25px;
      background-color: var(--accent);
      color: #fff;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 1.4rem;
      box-shadow: 0 4px 12px var(--shadow);
      transition: transform 0.3s ease;
      z-index: 10;
    }

    .cart-icon:hover {
      transform: scale(1.1);
    }

    .cart-icon a {
      color: #fff;
    }

    @media (max-width: 768px) {
      .header-container {
        flex-direction: column;
        align-items: flex-start;
        gap: 20px;
      }

      .search-bar input {
        width: 150px;
      }

      .product-container {
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      }
    }
    
    /* Modal Styling */
.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  padding-top: 60px;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.6);
}

.modal-content {
  background-color: #fff;
  margin: auto;
  padding: 20px;
  border-radius: 10px;
  width: 90%;
  max-width: 600px;
  text-align: center;
  position: relative;
}

.modal-content img {
  max-width: 100%;
  height: auto;
  border-radius: 8px;
}

.modal-content h2 {
  margin-top: 20px;
  font-size: 1.5rem;
  color: #333;
}

.close {
  color: #aaa;
  position: absolute;
  top: 10px;
  right: 20px;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
}
    
    
  </style>
</head>
<body>
<%
    String successMessage = (String) session.getAttribute("orderSuccess");
    if (successMessage != null) {
%>
    <script type="text/javascript">
        alert("<%= successMessage.replace("\"", "\\\"") %>");
    </script>
<%
        session.removeAttribute("orderSuccess");
    }
%>


  <header>
    <div class="header-container">
      <div class="brand-name">
        <i class="fas fa-shopping-basket"></i> Smart Wholesale Market
      </div>
      <div class="welcome-msg">Welcome, ${shop_name}</div>
      <div class="nav-right">
       <div class="search-bar">
  <form style="display: flex; align-items: center; background: white; border-radius: 30px; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <input type="text" placeholder="Search products..." style="border: none; padding: 12px 15px; outline: none; width: 180px;">
    <button type="submit" style="background: var(--primary); color: white; border: none; padding: 12px 18px; display: flex; align-items: center; gap: 5px; cursor: pointer; transition: background-color 0.3s ease;
      "
      onmouseover="this.style.backgroundColor='#0055cc'" 
      onmouseout="this.style.backgroundColor='var(--primary)'">
      <i class="fas fa-search"></i> Search
    </button>
  </form>
</div>

        <div class="categories">
          <select>
            <option value="">All Categories</option>
            <option value="electronics">Electronics</option>
            <option value="apparel">Apparel</option>
            <option value="groceries">Groceries</option>
            <option value="home">Home & Decor</option>
          </select>
        </div>
      </div>
    </div>
  </header>
<main>
    <div class="product-container">
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT s.wholeseller_id, s.stock_id, s.product_name, s.product_image, s.price, sc.category_name, wh.shop_name  FROM wholeseller.stock s JOIN wholeseller.stock_cat sc ON s.stock_cat_id = sc.stock_cat_id JOIN wholeseller.wholeseller wh ON s.wholeseller_id = wh.wholeseller_id";
		PreparedStatement ps = conn.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		 while (rs.next()) {
			    int wholesellerID = rs.getInt("wholeseller_id");
			 	int stockID = rs.getInt("stock_id");
		        String productName = rs.getString("product_name");
		        byte[] imageBytes = rs.getBytes("product_image");
		        double price = rs.getDouble("price");
		        String category = rs.getString("category_name");
		        String manufacturer = rs.getString("shop_name");

		        // Placeholder image URL (you can replace this with dynamic image path or BLOB endpoint)
		        String imageUrl = "productImage.jsp?id=" + stockID;

	
%>
  

      <!-- 8 product cards -->
      <div class="product-card" onclick="openModal('<%= imageUrl %>', '<%= productName %>')">
  <img src="<%= imageUrl %>" alt="Product">
  <div class="product-info">
    <h3><%= productName %></h3>
    <p>Category: <%= category %></p>
    <p>Price: RS.<%= price %></p>
  </div>
  <div class="manufacturer">wholesaler: <%= manufacturer %></div>
  <a href="buy-confirm-product.jsp?productID=<%= stockID %>&loginID=<%=wholesellerID %>">
    <button class="add-to-cart">Buy</button>
  </a>
</div>

<%
    } // end while
} catch (Exception e) {
    request.setAttribute("errorMessage", e.getMessage());
    request.getRequestDispatcher("/error.jsp").forward(request, response);
}
%>
  </div>
      

    </div>
  </main>

  <div class="cart-icon">
    <a href="#"><i class="fa-solid fa-cart-shopping"></i></a>
  </div>

<!-- Product Modal -->
<div id="productModal" class="modal" style="display:none;">
  <div class="modal-content">
    <span class="close">&times;</span>
    <img id="modalImage" src="" alt="Full Product Image">
    <h2 id="modalProductName"></h2>
  </div>
</div>

</body>
<script>

// Get modal elements
const modal = document.getElementById('productModal');
const modalImage = document.getElementById('modalImage');
const modalProductName = document.getElementById('modalProductName');
const closeBtn = document.querySelector('.close');

// Close modal on click of close button
closeBtn.onclick = function () {
  modal.style.display = 'none';
};

// Close modal on click outside
window.onclick = function (event) {
  if (event.target == modal) {
    modal.style.display = 'none';
  }
};

// Function to open modal
function openModal(imageSrc, productName) {
  modalImage.src = imageSrc;
  modalProductName.textContent = productName;
  modal.style.display = 'block';
}
</script>


</html>
