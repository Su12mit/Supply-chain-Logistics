package com.scm.Transport;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import com.scm.db.PostgresConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/NewTransport")
public class NewTransport extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        
       HttpSession session = request.getSession();
    	int loginId = LoginId.getLoginId(session); // Get login_id from session*/
    	
    	if (loginId <= 0) {
    	    request.setAttribute("errorMessage", "Invalid session. Please log in again.");
    	    request.getRequestDispatcher("/All_login.jsp").forward(request, response);
    	    return;
    	}

    	int cnt = 0 ;
        String vehicleNo = request.getParameter("vehicleNo");
        String driverName = request.getParameter("driverName");
        String fleetType = request.getParameter("fleetType");
        String capacityStr = request.getParameter("capacity");
        String statusVal = request.getParameter("status");
        String route = "NA";
        int capacity = 0;  // Default value in case of any issue
        int fleetCatId = 0;
        
        try {
            capacity = Integer.parseInt(capacityStr);
        } catch (NumberFormatException e) {
            // Handle the exception if the input is not a valid number
            e.printStackTrace();  // Optionally log the error
            // You can also set a default value or show an error message to the user
        }
       
        try (Connection connection = PostgresConnection.getConnection()) {
        	
            if (connection != null && !connection.isClosed()) {
            	String fleetsql = "SELECT fleet_cat_id FROM transport.fleets_cat WHERE category_name = ? AND transport_id = ?";
            	PreparedStatement ps1 = connection.prepareStatement(fleetsql);
            	ps1.setString(1, fleetType);
            	ps1.setInt(2, loginId);
            	ResultSet rs1 = ps1.executeQuery();
            	if (rs1.next()) {
            		fleetCatId = rs1.getInt("fleet_cat_id");
            }
            
            	//Chech VEHICLE EXIST OR NOT
            	String checkSql = "SELECT COUNT(*) FROM transport.fleets WHERE vehicle_number = ?";
            	PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            	checkStmt.setString(1, vehicleNo);
            	ResultSet checkRs = checkStmt.executeQuery();

            	boolean exists = false;
            	if (checkRs.next() && checkRs.getInt(1) > 0) {
            	    exists = true;
            	}

            	if (exists) {
            	    // UPDATE existing vehicle
            	    String updateSql = "UPDATE transport.fleets SET driver_name = ?, vehicle_type = ?, capacity = ?, status = ?, route = ?, fleet_cat_id = ? WHERE vehicle_number = ?";
            	    PreparedStatement updateStmt = connection.prepareStatement(updateSql);
            	    updateStmt.setString(1, driverName);
            	    updateStmt.setString(2, fleetType);
            	    updateStmt.setInt(3, capacity);
            	    updateStmt.setString(4, statusVal);
            	    updateStmt.setString(5, route);
            	    updateStmt.setInt(6, fleetCatId);
            	    updateStmt.setString(7, vehicleNo);
            	    
            	    cnt = updateStmt.executeUpdate();

            	    if (cnt > 0) {
            	        sendSuccessAlert(response, "Vehicle details updated successfully!");
            	    }
            	} else {
            	   
            		// INSERT new vehicle

            	String fleetinsertsql = "INSERT INTO transport.fleets (transport_id, vehicle_type, vehicle_number, driver_name, capacity, status, route, fleet_cat_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            	PreparedStatement ps4 = connection.prepareStatement(fleetinsertsql);
            	ps4.setInt(1, loginId);
            	ps4.setString(2, fleetType);
            	ps4.setString(3, vehicleNo);
            	ps4.setString(4, driverName);
            	ps4.setInt(5, capacity);
            	ps4.setString(6, statusVal);
            	ps4.setString(7, route);
            	ps4.setInt(8, fleetCatId);
              
               cnt=  ps4.executeUpdate();
               
            	 if(cnt > 0) {
                 	sendSuccessAlert(response, "Vehicle details saved successfully!");
                 }
            	}
            	/* else {
                // If any insert failed
                request.setAttribute("errorMessage", "Failed to insert data into the database.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }*/
   
                
            	
          } else {
                request.setAttribute("errorMessage", "Database connection failed. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (SQLException | ServletException | IOException e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
       /* response.sendRedirect(request.getHeader("Referer"));*/
    }
    private void sendSuccessAlert(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type='text/javascript'>");
        out.println("alert('" + message.replace("'", "\\'") + "');");
        out.println("window.location = document.referrer;");
        out.println("</script>");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported.");
    }
    }



