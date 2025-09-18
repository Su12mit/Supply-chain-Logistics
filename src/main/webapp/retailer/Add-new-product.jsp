<%@ page import="java.sql.*" %>
<%@ page import="com.scm.db.PostgresConnection" %>
<%@ page import="java.util.*" %>
<%
int stockId = 0;
int loginId = 0;
//Instead of just a list of names
Map<Integer, String> categoryMap = new LinkedHashMap<>();
String stockParam = request.getParameter("stock_id");
String loginParam = request.getParameter("loginId");

if (stockParam != null && !stockParam.isEmpty()) {
    stockId = Integer.parseInt(stockParam);
}
if (loginParam != null && !loginParam.isEmpty()) {
    loginId = Integer.parseInt(loginParam);
}

%>
<%
    
    String productName = "", category = "", brand = "", weight = "", warranty = "", date="";
    int quantity = 0;
    double price = 0;

    
    boolean isReorder = stockId > 0;
    try (Connection conn = PostgresConnection.getConnection()) {
    if (isReorder) {
        
            String sql = "SELECT s.product_name, s.quantity, s.price, s.stock_date, s.brand_name, s.weight, s.warrenty, sc.category_name FROM retailer.stock s JOIN retailer.stock_cat sc ON s.stock_cat_id = sc.stock_cat_id WHERE s.stock_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                productName = rs.getString("product_name");
                category = rs.getString("category_name");
                brand = rs.getString("brand_name");
                quantity = rs.getInt("quantity");
                price = rs.getDouble("price");
                date = rs.getString("stock_date");
                weight = rs.getString("weight");
                warranty = rs.getString("warrenty");
                
                // Fetch and display other details as needed
          		 
       		 request.setAttribute("productName", productName);
       		 request.setAttribute("category", category);
       		 request.setAttribute("date", date);
       		 request.setAttribute("brand", brand);
       		 request.setAttribute("quantity", quantity);
       		 request.setAttribute("price", price);
       		 request.setAttribute("weight", weight);
       		 request.setAttribute("warranty", warranty);
            }
    }
            // This part should happen regardless of reorder/new product
          String categorysql = "SELECT stock_cat_id, category_name FROM retailer.stock_cat WHERE retailer_id = ?";
PreparedStatement stmt = conn.prepareStatement(categorysql);
stmt.setInt(1, loginId);
ResultSet strs = stmt.executeQuery();

while (strs.next()) {
	 int catId = strs.getInt("stock_cat_id");
	    String catName = strs.getString("category_name");
	    categoryMap.put(catId, catName);
}


            //request.setAttribute("categoryOptions", categoryOptions);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    
%>

<!-- HTML & FORM -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title><%= isReorder ? "Reorder Product" : "Add New Product" %></title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
  :root {
    --primary-color: #0d6efd;
    --bg-color: #f1f5f9;
    --input-bg: #f8f9fa;
    --text-color: #212529;
    --border-color: #ced4da;
    --focus-shadow: 0 0 0 3px rgba(13, 110, 253, 0.2);
    --border-radius: 8px;
  }

  * {
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
  }

  body {
    background: linear-gradient(to bottom right, #e7f1ff, #ffffff);
    padding: 50px 20px;
    color: var(--text-color);
  }

  .container {
    max-width: 860px;
    background-color: #ffffff;
    margin: auto;
    padding: 40px 50px;
    border-radius: var(--border-radius);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease-in-out;
  }

  h2 {
    text-align: center;
    color: var(--primary-color);
    font-size: 32px;
    margin-bottom: 35px;
  }

  form {
    width: 100%;
  }

  .form-row {
    display: flex;
    flex-wrap: wrap;
    gap: 24px;
    margin-bottom: 24px;
  }

  .form-group {
    flex: 1 1 100%;
    display: flex;
    flex-direction: column;
  }

  .form-group.half {
    flex: 1 1 calc(50% - 12px);
  }

  label {
    margin-bottom: 8px;
    font-weight: 600;
    font-size: 14px;
    color: #495057;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  input[type="text"],
  input[type="number"],
  input[type="email"],
  select {
    padding: 12px 16px;
    font-size: 15px;
    background-color: var(--input-bg);
    border: 1px solid var(--border-color);
    border-radius: var(--border-radius);
    transition: border 0.3s ease, box-shadow 0.3s ease;
  }

  input:focus,
  select:focus {
    border-color: var(--primary-color);
    box-shadow: var(--focus-shadow);
    background-color: #fff;
    outline: none;
  }

  button.btn {
    background-color: var(--primary-color);
    color: #ffffff;
    font-size: 16px;
    padding: 14px;
    border: none;
    border-radius: var(--border-radius);
    width: 100%;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    margin-top: 20px;
    font-weight: bold;
    letter-spacing: 0.5px;
  }

  button.btn:hover {
    background-color: #0b5ed7;
    transform: translateY(-2px);
  }

  hr {
    border: none;
    height: 1px;
    background-color: #dee2e6;
    margin: 30px 0;
  }

  h3 {
    font-size: 20px;
    margin-bottom: 12px;
    color: var(--primary-color);
    font-weight: 600;
  }

  /* Custom Category Visibility */
  #customCategoryContainer {
    animation: fadeIn 0.3s ease-in-out;
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
  }

  @media (max-width: 768px) {
    .form-group.half {
      flex: 1 1 100%;
    }

    .container {
      padding: 30px 25px;
    }

    h2 {
      font-size: 26px;
    }

    button.btn {
      font-size: 15px;
    }
  }
</style>

</head>
<body>
  <div class="container">
    <h2><i class="fa-solid fa-box"></i> <%= isReorder ? "Reorder Product" : "Add New Product" %></h2>
    <form id="productForm" action="/Supply-chain-and-Logistic/RTAddnewProductServlet" method="post">
      <input type="hidden" name="loginId" value="<%= loginId %>">
      <input type="hidden" name="stockId" value="<%= stockId %>">



      <div class="form-row">
        <div class="form-group half">
          <label for="productName"><i class="fa-solid fa-tag"></i> Product Name</label>
          <input type="text" id="productName" name="productName" value="<%= productName %>" <%= isReorder ? "readonly" : "" %> required />
        </div>

      <div class="form-group half">
  <label for="category"><i class="fa-solid fa-list"></i> Category</label>
  <select id="category" name="category" <%= isReorder ? "disabled" : "" %> required onchange="toggleCustomCategory(this)">
    <option value="">-- Select Category --</option>
 <% for (Map.Entry<Integer, String> entry : categoryMap.entrySet()) { 
     int catId = entry.getKey();
     String catName = entry.getValue();
%>
  <option value="<%= catId %>" <%= catName.equals(category) ? "selected" : "" %>><%= catName %></option>
<% } %>


<option value="Other" <%= (!category.equals("") && !categoryMap.containsValue(category)) ? "selected" : "" %>>None of the Above</option>
  </select>
</div>

<!-- Custom category input shown conditionally -->
<div class="form-group half" id="customCategoryContainer" style="display: none;">
  <label for="customCategory"><i class="fa-solid fa-pen"></i> Enter New Category</label>
  <input type="text" id="customCategory" name="customCategory" value="<%= (!category.equals("") && !categoryMap.containsValue(category)) ? category : "" %>" />

</div>


      <div class="form-row">
        <div class="form-group half">
          <label for="brand"><i class="fa-solid fa-industry"></i> Brand Name</label>
          <input type="text" id="brand" name="brand" value="<%= brand %>" <%= isReorder ? "readonly" : "" %> />
        </div>

        <div class="form-group half">
          <label for="stock"><i class="fa-solid fa-boxes-stacked"></i> Stock Quantity</label>
          <input type="number" id="stock" name="stock" value="<%= quantity %>" <%= isReorder ? "readonly" : "" %> min="0" required />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group half">
          <label for="sellingPrice"><i class="fa-solid fa-dollar-sign"></i> Price</label>
          <input type="number" id="sellingPrice" name="Price" value="<%= price %>" <%= isReorder ? "readonly" : "" %> step="0.01" required />
        </div>

        <div class="form-group half">
          <label for="weight"><i class="fa-solid fa-weight-hanging"></i> Weight</label>
          <input type="text" id="weight" name="weight" value="<%= weight %>" <%= isReorder ? "readonly" : "" %> />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="warranty"><i class="fa-solid fa-shield-halved"></i> Warranty</label>
          <input type="text" id="warranty" name="warranty" value="<%= warranty %>" <%= isReorder ? "readonly" : "" %> />
        </div>
      </div>
      
       <!-- Hidden Fields to Pass Additional Values -->
   

      <% if (isReorder) { %>
      
      <hr style="margin: 20px 0;">
      <h3 style="color:#007bff; margin-bottom:10px;">Reorder Information</h3>
 
      <div class="form-row">
        <div class="form-group half">
          <label for="reorderQuantity"><i class="fa-solid fa-plus"></i> Reorder Quantity</label>
          <input type="number" id="reorderQuantity" name="reorderQuantity" min="1" required />
        </div>

        <div class="form-group half">
          <label for="reorderPrice"><i class="fa-solid fa-dollar-sign"></i> Reorder Price</label>
          <input type="number" id="reorderPrice" name="reorderPrice" placeholder="Price per Unit" step="0.01" required />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group half">
          <label for="reorderWeight"><i class="fa-solid fa-weight-hanging"></i> Reorder Weight</label>
          <input type="text" id="reorderWeight" name="reorderWeight" placeholder="Weight per Unit" />
        </div>

        <div class="form-group half">
          <label for="newWarranty"><i class="fa-solid fa-shield-halved"></i> New Warranty</label>
          <input type="text" id="newWarranty" name="newWarranty" placeholder="Enter new warranty if changed" />
        </div>
      </div>
      
      <!-- Hidden Fields to Pass Additional Values -->
    <input type="hidden" name="stockID" value="${stockId}">
   
      <% } %>

      <button type="submit" class="btn">
        <i class="fa-solid fa-plus"></i> <%= isReorder ? "Update Reorder" : "Add Product" %>
      </button>
     
    </form>
  </div>
</body>
<script>
  function toggleCustomCategory(select) {
    const customInput = document.getElementById('customCategoryContainer');
    if (select.value === "Other") {
      customInput.style.display = 'block';
    } else {
      customInput.style.display = 'none';
      document.getElementById('customCategory').value = '';
    }
  }

  // Run on DOM ready
  window.addEventListener('DOMContentLoaded', function () {
    const categorySelect = document.getElementById('category');
    toggleCustomCategory(categorySelect);
  });
</script>


</html>
