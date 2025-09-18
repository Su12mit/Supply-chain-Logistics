<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%@ page import= "com.scm.Transport.LoginId" %>

<% 
int loginId = LoginId.getLoginId(request.getSession()); // Pass session directly
session.setAttribute("loginId", loginId);
int fleet_category_id;
double kmamt = 0.0;  // Initialize with default value
double rent = 0.0;   // Initialize with default value

%>
<%
    String requestIDString = request.getParameter("delivery_request_id");
	//Convert string to integer (handle potential errors)
	int requestID = 0; // Default value in case of an exception
	try {
    requestID = Integer.parseInt(requestIDString);
    request.setAttribute("requestID", requestID);

	} catch (NumberFormatException e) {
   
	}
	String weightString = request.getParameter("weight");
	int weight = 0; // Default value in case of an exception
	try {
		weight = Integer.parseInt(weightString);
    request.setAttribute("weight", weight);

	} catch (NumberFormatException e) {
   
	}
    String companyName = request.getParameter("company_name");
    request.setAttribute("companyName", companyName);
   
%>
<%
String vehicleType = "";
if (weight > 2000) {
    vehicleType = "Truck";
} else if (weight > 750) {
    vehicleType = "Van";
} else {
    vehicleType = "Car";
}

request.setAttribute("vehicleType", vehicleType);
%>
<%
  class VehicleInfo {
      String number;
      String driver;
      double feeAmount;  // Fee per km
      double vehicleRent;  // Vehicle rent

      VehicleInfo(String number, String driver, double feeAmount, double vehicleRent) {
          this.number = number;
          this.driver = driver;
          this.feeAmount = feeAmount;
          this.vehicleRent = vehicleRent;
      }
  }

  List<VehicleInfo> vehicleInfoList = new ArrayList<>();
  try (Connection conn = PostgresConnection.getConnection()) {
      String sql = "SELECT vehicle_number, driver_name, fleet_cat_id FROM transport.fleets WHERE vehicle_type = ? AND status = 'Inactive' AND transport_id = ?";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setString(1, vehicleType);
      ps.setInt(2, loginId);
      ResultSet rs = ps.executeQuery();

      while (rs.next()) {
          // Get vehicle category and calculate fee and rent
          int fleetCategoryId = rs.getInt("fleet_cat_id");

          // Query for fee and rent associated with this vehicle's category
          String feeSql = "SELECT fs.fee_amount, fs.vehicle_rent FROM transport.fleets_cat f JOIN transport.fees fs On f.fees_id = fs.fees_id WHERE f.fleet_cat_id = ? AND f.transport_id = ?";
          PreparedStatement feePs = conn.prepareStatement(feeSql);
          feePs.setInt(1, fleetCategoryId);
          feePs.setInt(2, loginId);
          ResultSet feeRs = feePs.executeQuery();

          double feeAmount = 0;
          double vehicleRent = 0;

          if (feeRs.next()) {
              feeAmount = feeRs.getDouble("fee_amount");
              vehicleRent = feeRs.getDouble("vehicle_rent");
          }

          vehicleInfoList.add(new VehicleInfo(rs.getString("vehicle_number"), rs.getString("driver_name"), feeAmount, vehicleRent));
      }

  } catch (Exception e) {
      request.setAttribute("errorMessage", e.getMessage());
      request.getRequestDispatcher("/error.jsp").forward(request, response);
  }
%>
<%
boolean fleetAvailable = !vehicleInfoList.isEmpty();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Fleet Selection</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: 'Inter', sans-serif;
      background-color: #eef2f6;
      color: #2d3e50;
      padding: 40px 20px;
    }

    .container {
      max-width: 700px;
      margin: auto;
      background-color: #fff;
      padding: 35px 30px;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
      transition: box-shadow 0.3s;
    }

    .container:hover {
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
    }

    h2 {
      text-align: center;
      color: #1b2a40;
      font-size: 24px;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
      position: relative;
    }

    label {
      font-weight: 600;
      display: block;
      margin-bottom: 6px;
      font-size: 14px;
      color: #1f2f3f;
    }

    .form-group i {
      position: absolute;
      top: 38px;
      left: 12px;
      color: #73849a;
    }

    input,
    select {
      width: 100%;
      padding: 10px 12px 10px 35px;
      font-size: 14px;
      border: 1px solid #cdd6e0;
      border-radius: 8px;
      background-color: #f9fbfc;
      transition: border 0.3s;
    }

    input:focus,
    select:focus {
      border-color: #0078d4;
      background-color: #fff;
      outline: none;
    }

    input[readonly] {
      background-color: #f0f2f5;
      cursor: not-allowed;
    }

    select option {
      padding: 5px;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #0078d4;
      color: white;
      font-size: 16px;
      font-weight: 600;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #005a9e;
    }

    @media (max-width: 600px) {
      .container {
        padding: 25px 20px;
      }
    }
  </style>
</head>
<body>
<% if (!fleetAvailable) { %>
  <style>
    .floating-message {
      margin: 100px auto;
      max-width: 600px;
      padding: 30px;
      background-color: #ffecec;
      color: #b71c1c;
      border: 1px solid #f5c6cb;
      border-radius: 10px;
      text-align: center;
      font-size: 18px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      transition: box-shadow 0.3s ease, transform 0.2s ease;
    }

    .floating-message:hover {
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
      transform: translateY(-2px);
    }

    .back-btn {
      margin-top: 20px;
      padding: 10px 20px;
      background-color: #d32f2f;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .back-btn:hover {
      background-color: #b71c1c;
    }
  </style>

  <div class="floating-message">
    <i class="fas fa-exclamation-triangle" style="font-size: 26px; margin-bottom: 10px;"></i><br>
    <strong>Sorry! Currently fleet is not available for transport.</strong><br><br>
    <button class="back-btn" onclick="history.back();">Ok</button>
  </div>
<% } else { %>
<form action="/Supply-chain-and-Logistic/TransportUpdatation" method="post" onsubmit="return validateForm();">

  
  <div class="container">
    <h2><i class="fas fa-truck-moving"></i> Fleet Selection - ${companyName}</h2>
    
    <div class="form-group">
      <label><i class="fas fa-receipt"></i> Order ID</label>
      <input type="text" id="orderId" value="${requestID}" name="orderId" readonly />
    </div>
    
    <div class="form-group">
      <label><i class="fas fa-weight-hanging"></i> Product Weight (kg)</label>
      <input type="number" id="productWeight" value="${weight}" name="weight" readonly />
    </div>

   

    <div class="form-group">
      <label><i class="fas fa-truck"></i> Vehicle Type</label>
      <input type="text" id="vehicleType"  value= "${vehicleType}" name="vehicleType" readonly />
    </div>

    <div class="form-group">
      <label><i class="fas fa-car-side"></i> Available Vehicles</label>
      <select id="availableVehicles" name="vehicleNumber" onchange="updateDriverName(); processOrder();">

  <option value="">Select a Vehicle</option>
  <% for (VehicleInfo v : vehicleInfoList) { %>
    <option value="<%= v.number %>"><%= v.number %></option>
  <% } %>
</select>



    </div>
<div class="form-group">
  <label><i class="fas fa-user"></i> Driver Name</label>
  <input type="text" id="driverName" name="driverName" readonly />
</div>

    <div class="form-group">
      <label><i class="fas fa-road"></i> Distance (km)</label>
     <input type="number" id="distance" name="distance" placeholder="Enter distance in kilometers" oninput="processOrder()" min="1" />

    </div>

    <div class="form-group">
      <label><i class="fas fa-dollar-sign"></i> Total Delivery Charges ($)</label>
      <input type="text" id="deliveryCharges"  name="deliveryCharges" readonly />
    </div>

    <button onclick="checkOrder()"><i class="fas fa-check-circle"></i> Process the Order</button>
  </div>
  </form>
<script>
  const vehicleDriverMap = {
<%
  for (VehicleInfo v : vehicleInfoList) {
%>
    "<%= v.number %>": "<%= v.driver %>",
<%
  }
%>
  };
</script>
<script>
  // Map vehicle number to its feeAmount and vehicleRent
  const vehicleDetailsMap = {
  <% for (VehicleInfo v : vehicleInfoList) { %>
    "<%= v.number %>": {
      feeAmount: <%= v.feeAmount %>,
      vehicleRent: <%= v.vehicleRent %>
    },
  <% } %>
  };
</script>


<script>
function updateDriverName() {
    const selectedVehicle = document.getElementById("availableVehicles").value;
    const driverNameField = document.getElementById("driverName");

    if (selectedVehicle in vehicleDriverMap) {
        driverNameField.value = vehicleDriverMap[selectedVehicle];
    } else {
        driverNameField.value = "Not Available";
    }
}
function processOrder() {
    const distance = parseFloat(document.getElementById('distance').value);
    const selectedVehicle = document.getElementById('availableVehicles').value;
    const vehicleTypeInput = document.getElementById('vehicleType');
    const deliveryCharges = document.getElementById('deliveryCharges');

   

   
    // Get vehicle details (fee per km and rent) from the map
    const vehicleDetails = vehicleDetailsMap[selectedVehicle];

    if (!vehicleDetails) {
      alert("Selected vehicle details not found.");
      return;
    }

    const feePerKm = vehicleDetails.feeAmount;
    const vehicleRent = vehicleDetails.vehicleRent;

    // Calculate total charges: (fee per km * distance) + vehicle rent
    const totalCharge = (feePerKm * distance) + vehicleRent;

    // Display total charges
    deliveryCharges.value = totalCharge.toFixed(2);  // Format to 2 decimal places
    
}
function checkOrder() {
    const distance = parseFloat(document.getElementById('distance').value);
    const selectedVehicle = document.getElementById('availableVehicles').value;

    if (!selectedVehicle || isNaN(distance) || distance <= 0) {
        alert("Please enter a valid distance and select a vehicle.");
        return;
    }

    alert("Order is ready to be processed!");
    // Submit the form or proceed with order logic
}

</script>
<% } %>
</body>
</html>
