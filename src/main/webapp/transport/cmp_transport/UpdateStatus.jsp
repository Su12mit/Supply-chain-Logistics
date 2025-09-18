
<%
    String requestIDString = request.getParameter("delivery_id");

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
        
		String sql = "SELECT tr.transport_name, f.vehicle_number, dt.status  FROM transport.delivery_tracking dt JOIN transport.fleets f ON f.fleet_id = dt.fleet_id  JOIN transport.transport tr ON tr.transport_id = dt.transport_id WHERE dt.delivery_id = ?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			 String tName = rs.getString("transport_name");
     		 String Vno = rs.getString("vehicle_number");
    		 String Lstatus = rs.getString("status");
    		 
   			
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("Vno", Vno);
    		 request.setAttribute("tName", tName);
    		 request.setAttribute("Lstatus", Lstatus);
    		
    		 
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
  <title>Update Delivery Status</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet"/>
  <!-- Lottie Player Script is no longer needed if animation is removed, but keeping for now if other Lottie elements might be added -->
  <script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs" type="module"></script>
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      /* Subtle background pattern */
      background-image: url('data:image/svg+xml,%3Csvg width="6" height="6" viewBox="0 0 6 6" xmlns="http://www.w3.org/2000/svg"%3E%3Cg fill="%23fcd34d" fill-opacity="0.1" fill-rule="evenodd"%3E%3Cpath d="M5 0h1L0 6V5zM6 5v1H0V0zm1 0h1L1 7V6zM7 6v1H1V1z"/%3E%3C/g%3E%3C/svg%3E');
      background-repeat: repeat;
    }

    /* .road styles are no longer needed if animation is removed */
    /* .road {
      height: 8px;
      background: repeating-linear-gradient(
        to right,
        #333 0 40px,
        #ccc 40px 60px
      );
      animation: moveRoad 2s linear infinite;
    }

    @keyframes moveRoad {
      from { background-position: 0 0; }
      to { background-position: 100px 0; }
    } */

    /* Custom styles for input/select focus and button shadows */
    input:focus, select:focus {
        outline: none;
        border-color: #fbbf24; /* amber-400 */
        box-shadow: 0 0 0 3px rgba(251, 191, 36, 0.4); /* amber-400 with opacity */
    }

    .btn-primary {
        background-image: linear-gradient(to right, #f59e0b, #d97706); /* amber-500 to amber-700 */
        box-shadow: 0 4px 10px rgba(245, 158, 11, 0.4); /* amber-500 shadow */
    }
    .btn-primary:hover {
        background-image: linear-gradient(to right, #d97706, #b45309); /* darker amber */
        box-shadow: 0 8px 20px rgba(245, 158, 11, 0.6); /* Larger shadow on hover */
    }

    .btn-secondary {
        background-color: #fcd34d; /* amber-300 */
        color: #78350f; /* amber-900 */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .btn-secondary:hover {
        background-color: #fbbf24; /* amber-400 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
  </style>
</head>
<body class="bg-amber-50 min-h-screen flex items-center justify-center p-4">

  <div class="w-full max-w-3xl bg-white shadow-2xl rounded-3xl p-8">

    <!-- Heading -->
    <h1 class="text-center text-3xl font-bold text-amber-700 mb-1">${tName}</h1>
    <p class="text-center text-gray-600 text-sm mb-6">Track and update your delivery status with ease.</p>

    <!-- Form Starts -->
    <form action="/Supply-chain-and-Logistic/UpdatesServlet" method="post" class="flex flex-col gap-6">

      <!-- Grid Layout for Fields -->
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
        <!-- Delivery ID -->
        <div>
          <label class="block text-gray-700 font-medium mb-1 flex items-center gap-2">
            <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" class="w-5 h-5" alt="ID">
            Delivery ID
          </label>
          <input type="text" value="#DEL-${requestID}" disabled 
                 class="w-full px-4 py-2 bg-gray-100 border border-gray-300 rounded-lg shadow-sm cursor-not-allowed"/>
        </div>

        <!-- Vehicle Number -->
        <div>
          <label class="block text-gray-700 font-medium mb-1 flex items-center gap-2">
            <i class="fas fa-truck-moving text-xl"></i>
            Vehicle Number
          </label>
          <input type="text" value="${Vno}" disabled
                 class="w-full px-4 py-2 bg-gray-100 border border-gray-300 rounded-lg shadow-sm cursor-not-allowed"/>
        </div>

        <!-- Last Status -->
        <div>
          <label class="block text-gray-700 font-medium mb-1 flex items-center gap-2">
            <img src="https://cdn-icons-png.flaticon.com/512/1828/1828778.png" class="w-5 h-5" alt="Status">
            Last Status
          </label>
          <input type="text" value="${Lstatus}" disabled
                 class="w-full px-4 py-2 bg-gray-100 border border-gray-300 rounded-lg shadow-sm cursor-not-allowed"/>
        </div>

        <!-- Update Status -->
        <div>
          <label class="block text-gray-700 font-medium mb-1 flex items-center gap-2">
            <img src="https://cdn-icons-png.flaticon.com/512/1828/1828911.png" class="w-5 h-5" alt="Update">
            Update Status
          </label>
          <select name="status" class="w-full px-4 py-2 bg-white border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-amber-300">
            <option>Packed</option>
            <option>Ready</option>
            <option>Shipped</option>
            <option>Out for Delivery</option>
            <option>Delivered</option>
          </select>
        </div>
      </div> <!-- End of Grid -->

      <!-- Hidden input for deliveryID -->
      <input type="hidden" name="deliveryID" value="${requestID}">

      <!-- Buttons Aligned Right -->
      <div class="flex justify-end gap-4 mt-4">
        <button type="button"
                onclick="history.back()"
                class="btn-secondary font-medium py-2 px-5 rounded-xl transition-all duration-300 hover:scale-105">
          <img src="https://cdn-icons-png.flaticon.com/512/318/318477.png" class="w-4 h-4 inline-block mr-2 -mt-1" alt="Back">
          Back
        </button>
        <button type="submit"
                class="btn-primary text-white font-semibold py-2 px-6 rounded-xl transition-all duration-300 hover:scale-105">
          <img src="https://cdn-icons-png.flaticon.com/512/942/942748.png" class="w-5 h-5 inline-block mr-2 -mt-1" alt="Update">
          Update
        </button>
      </div>

    </form>
    <!-- End of Form -->

  </div>

</body>
</html>
