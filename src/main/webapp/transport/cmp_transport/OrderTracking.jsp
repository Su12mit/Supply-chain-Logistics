<%@ page isELIgnored="false" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%@ page import= "com.scm.Transport.LoginId" %>

<% 
int loginId = LoginId.getLoginId(request.getSession()); // Pass session directly
session.setAttribute("loginId", loginId);
int deliveryId = Integer.parseInt(request.getParameter("delivery_id"));
int deliveryrequestId = 0;
String statusVal;
String productName;
int qty = 0;
double price = 0.0;
String Name;
String address;
String Edate;
String phone;
String transport_name;
%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
	
	//Get Data 
	String sql = "SELECT t.transport_name, dt.status, dr.product_name, dr.quantity, dr.price, dr.buyer_name, dr.buyer_contact, dr.delivery_address, dr.delivery_expected_date FROM transport.delivery_tracking dt JOIN transport.shipment s ON dt.shipment_id = s.shipment_id JOIN transport.delivery_request dr ON s.delivery_request_id = dr.delivery_request_id JOIN transport.transport t ON dt.transport_id = t.transport_id WHERE dt.delivery_id = ? AND dt.transport_id = ?";
	//Statement stmt = conn.createStatement();
	PreparedStatement ps = conn.prepareStatement(sql);
		   ps.setInt(1, deliveryId);
		   ps.setInt(2, loginId);
		   
		    
		    ResultSet rs = ps.executeQuery();
		        while (rs.next()) {
		            transport_name = rs.getString("transport_name");
		            
		            statusVal = rs.getString("status");
		            productName = rs.getString("product_name");
		            qty = rs.getInt("quantity");
		            price = rs.getDouble("price");
		            Name = rs.getString("buyer_name");
		            phone = rs.getString("buyer_contact");
		            address = rs.getString("delivery_address");
		            Edate = rs.getString("delivery_expected_date");
					
		            // Set attributes in request scope
		            request.setAttribute("transport_name", transport_name);
		            request.setAttribute("deliveryId", deliveryId);
		            request.setAttribute("productName", productName);
		            request.setAttribute("qty", qty);
		            request.setAttribute("price", price);
		            request.setAttribute("Name", Name);
		            request.setAttribute("address", address);
		            request.setAttribute("phone", phone);
		            request.setAttribute("Edate", Edate);
		            request.setAttribute("statusVal", statusVal); // Also useful for frontend
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
  <title>Order Tracking - SCM</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      background: linear-gradient(to right, #e3f2fd, #e8f5e9);
      font-family: 'Segoe UI', sans-serif;
    }

    .container {
      max-width: 960px;
    }

    .card.glass {
      background: rgba(255, 255, 255, 0.7);
      backdrop-filter: blur(10px);
      border: none;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    }

    .timeline {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 40px 0;
      position: relative;
      overflow-x: auto;
    }

    .timeline-step {
      flex: 1;
      min-width: 100px;
      text-align: center;
      position: relative;
      transition: transform 0.3s ease;
    }

    .timeline-step:hover {
      transform: translateY(-3px);
      
    }

    .timeline-step::after {
      content: '';
      position: absolute;
      top: 25px;
      right: -50%;
      width: 100%;
      height: 4px;
      background-color: #ccc;
      z-index: -1;
    }

    .timeline-step:last-child::after {
      display: none;
      
    }

    .timeline-step .icon {
      height: 50px;
      width: 50px;
      background: linear-gradient(145deg, #4caf50, #2196f3);
      border-radius: 50%;
      line-height: 50px;
      color: white;
      font-size: 20px;
      margin: auto;
      transition: 0.3s;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .timeline-step.active::after {
     background: linear-gradient(145deg, #fbc02d, #f57f17); /* dark yellow tones */
    }

   .timeline-step.active .icon {
  background: linear-gradient(145deg, #fbc02d, #f57f17); /* dark yellow tones */
  color: #fff;
}


    .product-image {
      width: 100px;
      height: auto;
      border-radius: 8px;
      transition: transform 0.3s ease;
    }

    .product-image:hover {
      transform: scale(1.07);
    }

   .company-logo {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(to right, #0d6efd, #4caf50);
  color: white;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  font-weight: bold;
  font-size: 22px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  animation: logoBounce 1s ease-in-out;
}

    @keyframes logoBounce {
      0% { transform: scale(0.8); }
      100% { transform: scale(1); }
    }

    .invoice-btn {
      display: none;
      opacity: 0;
      transition: opacity 0.4s ease;
    }

    .invoice-btn.show {
      display: inline-block;
      opacity: 1;
    }

    @media (max-width: 768px) {
      .timeline-step {
        font-size: 12px;
      }
    }
   
   @keyframes stepBounce {
  0% {
    transform: scale(0.8);
    opacity: 0.5;
  }
  50% {
    transform: scale(1.15);
    opacity: 1;
  }
  100% {
    transform: scale(1);
  }
}

.step-bounce {
  animation: stepBounce 0.5s ease;
}
.icon.fill-animate {
  animation: fillIcon 0.6s ease-in-out forwards;
}

@keyframes fillIcon {
  0% {
    background: linear-gradient(145deg, #fbc02d, #f57f17); /* dark yellow tones */
    transform: scale(0.8);
  }
  50% {
    background: linear-gradient(145deg, #fbc02d, #f57f17); /* dark yellow tones */
    transform: scale(1.1);
  }
  100% {
    background: linear-gradient(145deg, #fbc02d, #f57f17); /* dark yellow tones */
    transform: scale(1);
  }
}
.timeline-step.highlighted-step .icon {
  transform: scale(1.3);
  box-shadow: 0 0 10px rgba(76, 175, 80, 0.6); /* soft green glow */
  background: linear-gradient(145deg, #1de9b6, #1e88e5);
}

.timeline-step.highlighted-step small {
  font-weight: 600;
  color: #c75204;
}

  </style>
</head>
<body>
  <div class="container my-5">
    <!-- Logo and Header -->
    <div class="text-center mb-4">
      <div class="company-logo" id="companyLogo">
        <i class="fas fa-truck-moving"></i>
        <span id="logoText"></span>
      </div>
      <h2 class="fw-bold mt-2" id="companyName">${transport_name} Transport</h2>
      <p class="text-muted">Order ID: <strong>#ORD${deliveryId}</strong></p>
    </div>

    <!-- Product Info -->
    <div class="card glass mb-4">
      <div class="card-body d-flex align-items-center flex-wrap">
        <img src="https://via.placeholder.com/100" alt="Product" class="product-image me-4" />
        <div>
          <h5 class="mb-1">${productName}</h5>
          <p class="mb-0 text-muted">Qantity: ${qty}</p>
          <p class="mb-0 text-muted">Price: ${price}</p>
        </div>
      </div>
    </div>

<script>
  const currentStatus = '${statusVal}';
</script>

    <!-- Timeline -->
    <div class="timeline">
  <div class="timeline-step">
    <div class="icon"><i class="fas fa-receipt"></i></div>
    <small>Order Placed</small>
  </div>
  <div class="timeline-step">
    <div class="icon"><i class="fas fa-check-double"></i></div>
    <small>Order Confirmed</small>
  </div>
  <div class="timeline-step">
    <div class="icon"><i class="fas fa-box"></i></div>
    <small>Packed</small>
  </div>
  <div class="timeline-step">
    <div class="icon"><i class="fas fa-box-open"></i></div>
    <small>Ready</small>
  </div>
  <div class="timeline-step">
    <div class="icon"><i class="fas fa-shipping-fast"></i></div>
    <small>Shipped</small>
  </div>
  <div class="timeline-step">
    <div class="icon"><i class="fas fa-truck-moving"></i></div>
    <small>Out for Delivery</small>
  </div>
  <div class="timeline-step" id="deliveredStep">
    <div class="icon"><i class="fas fa-check-circle"></i></div>
    <small>Delivered</small>
  </div>
</div>


    <!-- Shipping Details -->
    <div class="card glass mb-4">
      <div class="card-body">
        <h5 class="text-primary mb-3">Shipping Details</h5>
        <p><strong>Recipient:</strong> ${Name}</p>
        <p><strong>Address:</strong> ${address}</p>
        <p><strong>Phone:</strong> ${phone}</p>
        <p><strong>Estimated Delivery:</strong> ${Edate}</p>
      </div>
    </div>

    <!-- Invoice Button -->
    <div class="text-center">
      <button class="btn btn-success invoice-btn" id="downloadInvoiceBtn">
        <i class="fas fa-file-download me-2"></i>Download Invoice
      </button>
    </div>
  </div>

  <script>
    // Show "Download Invoice" button if delivered
    document.addEventListener("DOMContentLoaded", () => {
      const deliveredStep = document.getElementById("deliveredStep");
      const invoiceBtn = document.getElementById("downloadInvoiceBtn");
      if (deliveredStep.classList.contains("active")) {
        invoiceBtn.classList.add("show");
      }

      // Auto-generate logo from company name
     // const companyName = document.getElementById("companyName").innerText.trim();
      //document.getElementById("logoText").innerText = companyName.toLowerCase();
    });
  </script>
 <script>
 
 const statuses = [
	  "Order Placed",
	  "Order Confirmed",
	  "Packed",
	  "Ready",
	  "Shipped",
	  "Out for Delivery",
	  "Delivered"
	];

	document.addEventListener("DOMContentLoaded", () => {
	  const steps = document.querySelectorAll(".timeline-step");
	  const invoiceBtn = document.getElementById("downloadInvoiceBtn");
	  const normalizedStatus = currentStatus.trim().toLowerCase();

	  const currentIndex = statuses.findIndex(
	    status => status.toLowerCase() === normalizedStatus
	  );

	  if (currentIndex !== -1) {
	    steps.forEach((step, index) => {
	      setTimeout(() => {
	        if (index <= currentIndex) {
	          step.classList.add("active", "highlighted-step");

	          const icon = step.querySelector(".icon");
	          icon.classList.add("step-bounce", "fill-animate");

	          // Show invoice if current step is "Delivered"
	          if (statuses[index] === "Delivered") {
	            invoiceBtn.classList.add("show");
	          }
	        }
	      }, index * 300); // Adjust timing if you want faster/slower animation
	    });
	  }
	});
</script>

</body>
</html>
