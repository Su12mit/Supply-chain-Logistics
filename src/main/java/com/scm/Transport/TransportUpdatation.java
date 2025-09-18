package com.scm.Transport;
import java.util.*;
import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/TransportUpdatation")
public class TransportUpdatation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html");
    	 PrintWriter out = response.getWriter();
    	String orderIdStr = request.getParameter("orderId");
    	int fleetId = 0;
    	int orderId = 0;
    	int invoice = 0;
    	int deliveryID = 0;
    	int otherschemarow = 0;
    	try {
    	    if (orderIdStr != null) {
    	        orderId = Integer.parseInt(orderIdStr);
    	    } else {
    	        throw new IllegalArgumentException("Invalid order ID format.");
    	    }
    	} catch (Exception e) {
    	    response.setContentType("text/html");
    	       	    out.println("<script type='text/javascript'>");
    	    out.println("alert('Invalid Order ID. Operation aborted. Order ID: " + orderId + "');");
    	    out.println("window.history.back();");
    	    out.println("</script>");

    	    return;
    	}
    	int delivery = 0;
    	int fleet = 0;
    
        String vehicleNumber = request.getParameter("vehicleNumber");
        String driverName = request.getParameter("driverName");
        String vehicleType = request.getParameter("vehicleType");
        double deliveryCharges = 0;
        try {
            deliveryCharges = Double.parseDouble(request.getParameter("deliveryCharges"));
        } catch (NumberFormatException e) {
            out.println("<script>alert('Invalid delivery charge value.'); window.history.back();</script>");
            return;
        }

        int shipmentID = 0;
        String address = "";
        int yourRef = 0;
        String schema = "";
       
        HttpSession session = request.getSession();
    	int loginId = LoginId.getLoginId(session); // Get login_id from session
    	
        try (Connection connection = PostgresConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {
            	
            	String routesql = "SELECT c.customer_address, dt.delivery_address, dt.your_ref, dt.source FROM transport.delivery_request dt JOIN transport.customer c ON c.customer_id=dt.customer_id WHERE delivery_request_id = ?";
            	 PreparedStatement route_ps = connection.prepareStatement(routesql);
            	 route_ps.setInt(1, orderId);
            	ResultSet routers = route_ps.executeQuery();
            	if(routers.next()) {
            		 address = routers.getString("customer_address") + " to " + routers.getString("delivery_address");
            		 yourRef =  routers.getInt("your_ref");
            		 schema = routers.getString("source");
            	}
                 
            	if (address != null && !address.isEmpty())  {
            	 // UPDATE FLEETS STATUS
                String updateFleetSql = "UPDATE transport.fleets SET status = 'Active', delivery_request_id = ?, route = ? WHERE vehicle_number = ? AND transport_id = ?";
                PreparedStatement fleetstatus_ps = connection.prepareStatement(updateFleetSql);
                fleetstatus_ps.setInt(1, orderId);
                fleetstatus_ps.setString(2, address);
                fleetstatus_ps.setString(3, vehicleNumber);
                fleetstatus_ps.setInt(4, loginId);
                
                fleet =  fleetstatus_ps.executeUpdate();
               }
            	
                if(fleet > 0) {
            	//UPDATE DEL REQ STATUS COLUMN
                String del_req_query =" UPDATE transport.delivery_request SET status = 'Accepted' WHERE delivery_request_id = ? AND transport_id = ?";
                 PreparedStatement del_req_ps = connection.prepareStatement(del_req_query);
                 del_req_ps.setInt(1, orderId);
                 del_req_ps.setInt(2, loginId);
               
                 delivery = del_req_ps.executeUpdate();
               
                }
               
               
                 
                 
                 if(delivery > 0) {
                	 
                	// 2. Retrieve fleet_id for the updated vehicle
                	    String getFleetIdSql = "SELECT fleet_id FROM transport.fleets WHERE vehicle_number = ? AND transport_id = ?";
                	    PreparedStatement fleetIdStmt = connection.prepareStatement(getFleetIdSql);
                	    fleetIdStmt.setString(1, vehicleNumber);
                	    fleetIdStmt.setInt(2, loginId);
                	    
                	    ResultSet fleetIdRs = fleetIdStmt.executeQuery();
                	    if (fleetIdRs.next()) {
                	        fleetId = fleetIdRs.getInt("fleet_id");
                	       
                	    }
                 }
                
                if(fleetId > 0) {
                	
                // SELECT FOR UPDATE INVOICES
                	String shipmentsql = "SELECT shipment_id FROM transport.shipment WHERE delivery_request_id = ? AND transport_id = ? ORDER BY shipment_id DESC LIMIT 1";
                PreparedStatement shipment_ps = connection.prepareStatement(shipmentsql);
                shipment_ps.setInt(1, orderId);
                shipment_ps.setInt(2, loginId);
                ResultSet shipmentrs = shipment_ps.executeQuery();
                if(shipmentrs.next()) {
                	shipmentID = shipmentrs.getInt("shipment_id");
                }
                
                 }
                 
                 
                //UPDATE INTO INVOICES
                if (shipmentID > 0) {
                	String invoicessql = "UPDATE transport.invoices SET tr_amount = ? WHERE shipment_id = ? AND transport_id = ?";
                	 PreparedStatement invoices_ps = connection.prepareStatement(invoicessql);
                	 invoices_ps.setDouble(1, deliveryCharges);
                	 invoices_ps.setInt(2, shipmentID);
                	 invoices_ps.setInt(3, loginId);
                	 invoice = invoices_ps.executeUpdate();
                	 }
               
               if(invoice > 0) {
            	  
            	String getdeliverysql = "SELECT delivery_id FROM transport.delivery_tracking WHERE shipment_id = ?"; 
            	PreparedStatement del_ps = connection.prepareStatement(getdeliverysql);
            	del_ps.setInt(1, shipmentID);  
            	ResultSet rs4 = del_ps.executeQuery();
            	if(rs4.next()) {
            		deliveryID = rs4.getInt("delivery_id");
            		
            	}
               }
               if(deliveryID > 0) {
            	
            		 // Validate schema before using
                    List<String> allowedSchemas = Arrays.asList("retailer", "wholeseller", "supplier");
                    if (schema == null || !allowedSchemas.contains(schema)) {
                        throw new ServletException("Invalid or missing schema name.");
                    }
                    
            		String schemasql = "UPDATE "+schema+".my_orders SET shipment_id = ?, order_status = 'In Transit' WHERE my_order_id = ?";
            		PreparedStatement schema_ps = connection.prepareStatement(schemasql);
            		schema_ps.setDouble(1, deliveryID);
            		schema_ps.setInt(2, yourRef);
              	 
              	otherschemarow = schema_ps.executeUpdate();
               
               }
               
               if(otherschemarow > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Order Confirmed Successfully');");
                out.println("window.location.replace('/Supply-chain-and-Logistic/transport/cmp_transport/index.jsp');");
                out.println("</script>");
               
               }
 
            } else {
                request.setAttribute("errorMessage", "Database connection failed. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (SQLException | ServletException | IOException e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported.");
    }
}
