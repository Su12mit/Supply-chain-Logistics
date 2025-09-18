<%
    String requestIDString = request.getParameter("orderID");
	int yorREFID = Integer.parseInt(request.getParameter("yourREF"));
	request.setAttribute("yorREFID", yorREFID);
    // Convert string to integer (handle potential errors)
    int requestID = 0; // Default value in case of an exception
   try {
       requestID = Integer.parseInt(requestIDString);
        //request.setAttribute("requestID", requestID);

    } catch (NumberFormatException e) {
       
    } 
    int transportId = 0;
   
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%
  List<String[]> transportOptions = new ArrayList<>();
%>

<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT wh.shop_name, wh.wholeseller_contact, wh.address, lg.email,  o.product_name, o.quantity,  o.t_ammount, c.customer_name, c.customer_address, c.customer_email, c.customer_phone FROM wholeseller.order_request o JOIN wholeseller.customer c ON o.customer_id = c.customer_id JOIN wholeseller.wholeseller wh ON wh.wholeseller_id = o.wholeseller_id JOIN wholeseller.login lg ON lg.login_id = wh.wholeseller_id WHERE o.order_request_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String shop_name = rs.getString("shop_name");
    		 String wh_contact = rs.getString("wholeseller_contact");
    		 String address = rs.getString("address");
    		 String caddress = rs.getString("customer_address");
    		 
    		 String email = rs.getString("email");
    		 String cname = rs.getString("customer_name");
    		 String cemail = rs.getString("customer_email");
    		 String cphone = rs.getString("customer_phone");
    		 String p_name = rs.getString("product_name");
    		 int qty = rs.getInt("quantity");
    		 double tamt = rs.getDouble("t_ammount");
    		
   			
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("shop_name", shop_name);
    		 request.setAttribute("wh_contact", wh_contact);
    		 request.setAttribute("address", address);
    		
    		
    		 request.setAttribute("caddress", caddress);
    		 
    		 request.setAttribute("email", email);
    		 request.setAttribute("cname", cname);
    		 request.setAttribute("cemail", cemail);
    		 request.setAttribute("cphone", cphone);
    		 request.setAttribute("p_name", p_name);
    		 request.setAttribute("qty", qty);
    		 request.setAttribute("tamt", tamt);

    			
		}
		String transportsql = "SELECT t.transport_id, t.transport_name || ': ' || STRING_AGG(c.category_name || ' - ' || f.fee_amount || f.fee_description, ', ') AS combined_result FROM transport.transport t JOIN transport.fleets_cat c ON t.transport_id = c.transport_id JOIN transport.fees f ON f.fees_id = c.fees_id GROUP BY t.transport_id, t.transport_name";
		Statement stmt = conn.createStatement();
		ResultSet strs = stmt.executeQuery(transportsql);

while (strs.next()) {
    transportOptions.add(new String[] {
        strs.getString("transport_id"),
        strs.getString("combined_result")
    });
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
  <title>Delivery Request Form</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
  <style>
    body {
      background: linear-gradient(to right, #f3f4f7, #e0ecf8);
      font-family: 'Segoe UI', sans-serif;
      padding: 2rem 0;
    }

    .card {
      border-radius: 16px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      overflow: hidden;
    }

    .card-header {
      background: linear-gradient(to right, #007bff, #0056b3);
      color: #fff;
      padding: 1.5rem;
      text-align: center;
    }

    .form-label {
      font-weight: 500;
    }

    .form-control, .form-select {
      border-radius: 8px;
    }
   
    input[readonly], textarea[readonly] {
  border: 1px solid red !important;
 
}
    

    .btn-primary {
      background-color: #007bff;
      border: none;
      padding: 0.75rem;
      font-weight: 600;
      border-radius: 8px;
      transition: background 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .fa {
      color: #007bff;
      margin-right: 6px;
    }

    @media (max-width: 576px) {
      .card-header h2 {
        font-size: 1.5rem;
      }
    }
  </style>
</head>
<body>
  <div class="container px-3">
    <div class="card mx-auto" style="max-width: 750px;">
      <div class="card-header">
        <h2><i class="fas fa-truck-moving"></i> Delivery Request</h2>
      </div>
      <div class="card-body p-4">
       <form action="/Supply-chain-and-Logistic/DeliveryRequestServlet" method="post">

          <div class="row g-3">
            <div class="col-md-6">
              <label for="wholesalerName" class="form-label"><i class="fas fa-user"></i> Wholesaler Name</label>
              <input type="text" class="form-control" id="wholesalerName"  name="wholesalerName" readonly Value=${shop_name} >
            </div>

            <div class="col-md-6">
              <label for="contact" class="form-label"><i class="fas fa-phone"></i> Contact Number</label>
              <input type="tel" class="form-control" id="contact" name="contact" readonly value=${wh_contact} >
            </div>

            <div class="col-md-6">
              <label for="pickupAddress" class="form-label"><i class="fas fa-map-marker-alt"></i> Pickup Address</label>
              <textarea class="form-control" id="pickupAddress" rows="2" name="pickupAddress" readonly   >${address}</textarea>
            </div>

            <div class="col-md-6">
              <label for="deliveryAddress" class="form-label"><i class="fas fa-location-arrow"></i> Delivery Address</label>
              <textarea class="form-control" id="deliveryAddress" rows="2" name="deliveryAddress" readonly >${caddress}</textarea>
            </div>

            <div class="col-md-6">
              <label for="deliveryDate" class="form-label"><i class="fas fa-calendar-alt"></i> Preferred Delivery Date</label>
              <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" required>
            </div>

            <div class="col-md-6">
              <label for="weight" class="form-label"><i class="fas fa-weight-hanging"></i> Weight (kg)</label>
              <input type="number" class="form-control" id="weight" name= "weight" placeholder="Total weight" min="1" required>
            </div>
	
            <div class="col-12">
              <label for="transportCompany" class="form-label"><i class="fas fa-truck"></i> Select Transport Company</label>
              <select class="form-select" id="transportCompany" name="transportCompanyId" required>
                <option value="">-- Choose a Company --</option>
                 <% for (String[] option : transportOptions) { %>
      <option value="<%= option[0] %>"><%= option[1] %></option>
  <% } %>
              </select>
            </div>

            <div class="col-12">
              <label for="notes" class="form-label"><i class="fas fa-sticky-note"></i> Additional Notes</label>
              <textarea class="form-control" id="notes" rows="3" placeholder="Any special instructions?"></textarea>
            </div>

 <!-- Hidden Fields to Pass Additional Values -->
    <input type="hidden" name="email" value="${email}">
    <input type="hidden" name="customerName" value="${cname}">
    <input type="hidden" name="customerEmail" value="${cemail}">
    <input type="hidden" name="customerPhone" value="${cphone}">
    <input type="hidden" name="productName" value="${p_name}">
    <input type="hidden" name="quantity" value="${qty}">
    <input type="hidden" name="totalAmount" value="${tamt}">
     <input type="hidden" name="requestID" value="${requestID}">
     <input type="hidden" name="RefID" value="${yorREFID}">

            <div class="col-12 d-grid">
              <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Submit Delivery Request</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
