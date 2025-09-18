<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
    font-size: 20px; 
}

.container { 
    max-width: 600px; 
    background-color: white; 
    margin: 40px auto; 
    padding: 30px; 
    border-radius: 10px; 
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); 
}

.form-row { 
    margin-bottom: 20px; 
}

.form-row label { 
    font-weight: 600; 
    display: block; 
    margin-bottom: 6px; 
}

.input-group { 
    display: flex; 
    align-items: center; 
}

.input-group button { 
    padding: 8px 12px; 
    cursor: pointer; 
    background-color: #0066cc; 
    color: white; 
    border: none; 
    border-radius: 5px; 
    transition: 0.3s ease;
}

.input-group button:hover { 
    background-color: #005bb5;
}

input, select { 
    width: 100%; 
    padding: 10px; 
    border: 1px solid #ccc; 
    border-radius: 5px; 
    box-sizing: border-box; 
    font-size: 14px;
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
}
    </style>

     <script>
        // Check if successMessage or errorMessage is set
        window.onload = function() {
            let successMessage = "${requestScope.successMessage}";
           

            if (successMessage) {
                alert(successMessage);  // Display success message in an alert box
            }
        };
    </script>
</head>
<body>

    <div class="navbar">
        <h2>Fleet Management</h2>
        <div>
           
        </div>
    </div>

    <div class="container">
        <h2>Manage Fleet</h2>
        <div id="messageBox"></div>
    <form action="/Supply-chain-and-Logistic/NewTransport" method="post">
 
            <div class="form-row">
                <label for="vehicleNo">🚗 Vehicle Number:</label>
                
                    
                    <input type="text" id="vehicleNo" name="vehicleNo" required />
          
            </div>
            <div class="form-row">
                <label for="driverName">👨‍✈️ Driver Name:</label>
                <input type="text" id="driverName" name="driverName" required />
            </div>
            <div class="form-row">
                <label for="fleetType">📋 Fleet Type:</label>
                <select id="fleetType" name="fleetType">
                    <option value="Truck">Truck</option>
                    <option value="Van">Van</option>
                    <option value="Tanker">Tanker</option>
                    <option value="Car">Car</option>
                </select>
            </div>
            <div class="form-row">
                <label for="capacity">⚖️ Capacity (kg):</label>
                <input type="number" id="capacity" name="capacity" required />
            </div>
            <div class="form-row">
                <label for="status">Status:</label>
                <select id="status" name="status">
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                    <option value="Under Maintenance">Under Maintenance</option>
                </select>
            </div>
            <div class="form-row" id="submitBtn">
                <button type="submit">Submit</button>
            </div>
            
      </form>  
    </div>
    
</body>
</html>