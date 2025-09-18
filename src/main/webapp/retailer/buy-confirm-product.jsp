
<%
   
	int stockID = Integer.parseInt (request.getParameter("productID"));
	int wholesellerID = Integer.parseInt (request.getParameter("loginID"));
	
    // Convert string to integer (handle potential errors)
    
   String pname; 
   double price = 0.0;
   String cname;
   String sname;
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT s.product_name, s.price, st.category_name, wh.shop_name FROM wholeseller.stock s JOIN wholeseller.stock_cat st ON s.stock_cat_id = st.stock_cat_id JOIN wholeseller.wholeseller wh ON s.wholeseller_id = wh.wholeseller_id  WHERE s.stock_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, stockID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 
    		 pname = rs.getString("product_name");
    		 price = rs.getDouble("price"); 
    		 cname = rs.getString("category_name");
    		 sname = rs.getString("shop_name");
    		 
    		 
    		 
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("pname", pname);
    		 request.setAttribute("price", price);
    		 request.setAttribute("cname", cname);
    		 request.setAttribute("sname", sname);
    		
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
  <title>Buy Product</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-green: #2ecc71;
      --dark-green: #27ae60;
      --light-green: #e8f5e9;
      --border: #d0e9d0;
      --text-dark: #2c3e50;
      --text-light: #7f8c8d;
      --white: #fff;
    }

    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--light-green);
      color: var(--text-dark);
      margin: 0;
      padding: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }

    .purchase-container {
      background-color: var(--white);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 500px;
    }

    .purchase-container h2 {
      margin-bottom: 20px;
      color: var(--dark-green);
      text-align: center;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 6px;
      font-weight: 600;
    }

    .form-group input[readonly],
    .form-group input[type="number"],
    .form-group input[type="text"] {
      width: 100%;
      padding: 12px;
      border: 1px solid var(--border);
      border-radius: 8px;
      background-color: #f4fcf6;
      font-size: 1rem;
    }

    .form-group input[readonly] {
      background-color: #f0f9f2;
      color: var(--text-light);
    }

    .form-group input[type="number"]:focus {
      border-color: var(--primary-green);
      outline: none;
    }

    .total {
      font-size: 1.2rem;
      font-weight: 600;
      color: var(--dark-green);
    }

    .submit-btn {
      background-color: var(--primary-green);
      color: white;
      padding: 12px;
      width: 100%;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .submit-btn:hover {
      background-color: var(--dark-green);
    }
  </style>
</head>
<body>

  <div class="purchase-container">
    <h2>Confirm Purchase</h2>
    <form action="/Supply-chain-and-Logistic/RTOrderPlacedServlet" method="post" >
      <div class="form-group">
        <label>Product Name</label>
        <input type="text" name="productName" value="${pname }" readonly>


      </div>

      <div class="form-group">
        <label>Category</label>
        <input type="text" name="category" value="${cname}" readonly>
      </div>

      <div class="form-group">
        <label>Price (RS)</label>
        <input type="text" id="price" name="price" value="${price}" readonly>
      </div>

      <div class="form-group">
        <label>Wholesaling Shop</label>
        <input type="text" name="shop" value="${sname}" readonly>
      </div>

      <div class="form-group">
        <label>Quantity</label>
        <input type="number" id="quantity" name="quantity" min="1" required oninput="calculateTotal()">
      </div>

      <div class="form-group">
        <label>Total Amount (RS)</label>
        <input type="text" id="total" name="total" class="total" readonly>
      </div>
		<!-- hidden fields -->
		<input type="hidden" name="wholesellerID" value="<%= wholesellerID %>">
		
      <button type="submit" class="submit-btn">Place Order</button>
    </form>
  </div>

  <script>
    function calculateTotal() {
      const price = parseFloat(document.getElementById("price").value);
      const quantity = parseInt(document.getElementById("quantity").value);
      const totalField = document.getElementById("total");

      if (!isNaN(price) && !isNaN(quantity)) {
        totalField.value = (price * quantity).toFixed(2);
      } else {
        totalField.value = "";
      }
    }
  </script>
</body>
</html>
