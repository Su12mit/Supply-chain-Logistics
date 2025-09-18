<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%
    String requestIDString = request.getParameter("fleet_id");

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
        
		String sql = "SELECT vehicle_type, vehicle_number, driver_name, capacity, status, route FROM transport.fleets WHERE fleet_id = ?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String vehicle_type = rs.getString("vehicle_type");
    		 String vehicle_number = rs.getString("vehicle_number");
    		 String driver_name = rs.getString("driver_name");
    		 String capacity = rs.getString("capacity");
    		 String status = rs.getString("status");
    		 String route = rs.getString("route");
    		
    		 
    		
   			
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("vehicle_type", vehicle_type);
    		 request.setAttribute("vehicle_number", vehicle_number);
    		 request.setAttribute("driver_name", driver_name);
    		 request.setAttribute("capacity", capacity);
    		 request.setAttribute("status", status);
    		 request.setAttribute("route", route);
    		 
		}
		


} catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
  %>

<head>
    <meta charset="UTF-8">
    <title>Fleet Management</title>
    <style>
       body { 
    font-family: 'Poppins', sans-serif; 
    background-color: #f8f9fa; 
    margin: 0; 
    padding: 0; 
    color: #333; 
}

.navbar { 
    background-color: #004d99; 
    color: white; 
    padding: 15px 30px; 
    display: flex; 
    justify-content: space-between; 
    align-items: center; 
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.navbar h2 { 
    margin: 0; 
    font-size: 22px; 
    font-weight: 600; 
}

.container { 
    max-width: 600px; 
    background-color: white; 
    margin: 40px auto; 
    padding: 30px; 
    border-radius: 10px; 
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); 
}

h2 {
    text-align: center;
    font-size: 24px;
    margin-bottom: 20px;
    color: #004d99;
}

.form-row { 
    margin-bottom: 20px; 
}

.form-row label { 
    font-weight: 600; 
    display: block; 
    margin-bottom: 8px; 
}

.input-group { 
    display: flex; 
    align-items: center; 
}

input, select { 
    width: 100%; 
    padding: 10px; 
    border: 1px solid #ccc; 
    border-radius: 5px; 
    box-sizing: border-box; 
    font-size: 14px;
    background-color: #e0e0e0;
    cursor: not-allowed;
}

.form-row button { 
    background-color: #004d99; 
    color: white; 
    border: none; 
    cursor: pointer; 
    padding: 12px 20px; 
    font-size: 16px; 
    border-radius: 5px;
    transition: 0.3s ease;
    display: block;
    width: 100%;
    text-align: center;
}

.form-row button:hover { 
    background-color: #003366; 
}

#messageBox { 
    display: none; 
    font-weight: bold; 
    padding: 12px; 
    margin-bottom: 20px; 
    border-radius: 5px; 
    background-color: #fef6d6; 
    color: #8a6d3b; 
    border: 1px solid #f1c40f;
    text-align: center;
}    </style>

    <script>
        function showMessage(msg, type) {
            let messageBox = document.getElementById("messageBox");
            messageBox.innerHTML = msg;
            messageBox.style.display = "block";
            messageBox.style.color = (type === "success") ? "green" : "red";
        }

        // Function for Back Button: Redirects to the previous page
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h2>Fleet Management</h2>
    </div>

    <div class="container">
        <h2>Manage Fleet</h2>
        <div id="messageBox"></div>
        <form action="#" method="post">
            <div class="form-row">
                <label for="vehicleNo">🚗 Vehicle Number:</label>
                <div class="input-group">
                    <button type="button" id="showBtn" style="display: none;" onclick="fetchFleetDetails()">Show</button>
                    <input type="text" id="vehicleNo" name="vehicleNo" readonly placeholder = ${vehicle_number} />
                </div>
            </div>
            <div class="form-row">
                <label for="driverName">👨‍✈️ Driver Name:</label>
                <input type="text" id="driverName" name="driverName" readonly Value = ${driver_name}/>
            </div>
            <div class="form-row">
                <label for="fleetType">🚛 Fleet Type:</label>
                <input type="text" id="fleetType" name="fleetType" readonly Value = ${vehicle_type} />
            </div>
            <div class="form-row">
                <label for="capacity">⚖️ Capacity (kg):</label>
                <input type="number" id="capacity" name="capacity" readonly  Value = ${capacity} />
            </div>
            <div class="form-row">
                <label for="status">🟢 Status:</label>
                <input type="text" id="status" name="status" readonly  Value = ${status} />
            </div>
            <div class="form-row">
                <label for="route">🗺️ Route:</label>
                <input type="text" id="route" name="route" readonly Value = ${route} />
            </div>
            <div class="form-row">
                <button type="button" onclick="goBack()">🔙 Back</button>
            </div>
        </form>
    </div>
</body>
</html>