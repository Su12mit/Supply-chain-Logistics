package com.scm.Wholeseller;
import java.sql.*;
import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeliveryRequestServlet")
@MultipartConfig
public class DeliveryRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {

                // Retrieve form data
            	String wholesalerName = request.getParameter("wholesalerName");
            	String contact = request.getParameter("contact");
            	String pickupAddress = request.getParameter("pickupAddress");
            	String deliveryAddress = request.getParameter("deliveryAddress");
            	String deliveryDate = request.getParameter("deliveryDate");
            	Timestamp expectedTimestamp = Timestamp.valueOf(deliveryDate + " 00:00:00");
            	double weight = Double.parseDouble(request.getParameter("weight"));
            	int transportCompanyId = Integer.parseInt(request.getParameter("transportCompanyId"));
            	
            	String email = request.getParameter("email");
            	String customerName = request.getParameter("customerName");
            	String customerEmail = request.getParameter("customerEmail");
            	String customerPhone = request.getParameter("customerPhone");
            	String productName = request.getParameter("productName");
            	int quantity = Integer.parseInt(request.getParameter("quantity"));
            	double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            	int requestID = Integer.parseInt(request.getParameter("requestID"));
            	int yourRefID = Integer.parseInt(request.getParameter("RefID"));
            	
            	//by default variables 
            	String status = "Pending";
            	String sourceType ="wholeseller";
            	String Dsource ="retailer";
            	int custRow = 0;
            	int ordRow = 0;
            	int statusrow = 0;
            	int mystatusrow = 0;
            	Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            	
            	// Insert INTO customer Table
            		String customersql = "INSERT INTO transport.customer(transport_id, customer_name, customer_email, customer_phone, customer_address, created_at, order_id, source_type) VALUES(?,?,?,?,?,?,?,?)";
            		PreparedStatement customerStmt = connection.prepareStatement(customersql, Statement.RETURN_GENERATED_KEYS);
            		customerStmt.setInt(1, transportCompanyId);
            		customerStmt.setString(2, wholesalerName);
            		customerStmt.setString(3, email);
            		customerStmt.setString(4, contact);
            		customerStmt.setString(5, pickupAddress);
            		customerStmt.setTimestamp(6, currentTimestamp);
            		customerStmt.setInt(7, requestID);
            		customerStmt.setString(8, sourceType);
            		 custRow = customerStmt.executeUpdate();
            		
            		 //Get Generated Key
            		 ResultSet generatedKeys = customerStmt.getGeneratedKeys();
                         if (generatedKeys.next()) {
                             int customerId = generatedKeys.getInt(1); // Capture transport_id
                             // Insert into delivery request  table
                             
                             String ordersql ="INSERT INTO transport.delivery_request(transport_id, customer_id, buyer_name, buyer_contact, buyer_email, delivery_address, product_name, quantity, weight, price, delivery_expected_date, status, request_date, your_ref, source) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                             PreparedStatement orderStmt = connection.prepareStatement(ordersql);
                             orderStmt.setInt(1, transportCompanyId);
                             orderStmt.setInt(2, customerId);
                             orderStmt.setString(3, customerName);
                             orderStmt.setString(4, customerPhone);
                             orderStmt.setString(5, customerEmail);
                             orderStmt.setString(6, deliveryAddress);
                             orderStmt.setString(7, productName);
                             orderStmt.setInt(8, quantity);
                             orderStmt.setDouble(9, weight);
                             orderStmt.setDouble(10, totalAmount);
                             orderStmt.setTimestamp(11, expectedTimestamp);
                             orderStmt.setString(12, status);
                             orderStmt.setTimestamp(13, currentTimestamp);
                             orderStmt.setInt(14, yourRefID);
                             orderStmt.setString(15, Dsource);
                             ordRow = orderStmt.executeUpdate();
                         }   
                         if (custRow > 0  && ordRow > 0) {
                        	 //Change Retailer Order Status 
                        	 
                        	 //////////////////////////////
                        	 
                        	 // change order request status
                        	 String statussql ="UPDATE wholeseller.order_request SET status = 'Accepted' WHERE order_request_id = ?";
                        	 PreparedStatement statusStmt = connection.prepareStatement(statussql);
                        	 statusStmt.setInt(1, requestID);
                        	 statusrow = statusStmt.executeUpdate();
                         }
                         if(statusrow > 0) {
                        	 //change retailer order status
                        	 String mystatussql ="UPDATE retailer.my_orders SET order_status = 'Accepted' WHERE your_ref = ?";
                        	 PreparedStatement mystatusStmt = connection.prepareStatement(mystatussql);
                        	 mystatusStmt.setInt(1, requestID);
                        	 mystatusrow = mystatusStmt.executeUpdate();
                         }
                         
                         if(mystatusrow > 0) {
                        	 
                             response.setContentType("text/html");
                             PrintWriter out = response.getWriter();
                             out.println("<script type=\"text/javascript\">");
                             out.println("alert('Order Delivery Request Sent Successfully');");
                             out.println("window.location.replace('/Supply-chain-and-Logistic/wholeseller/index.jsp');");

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

    // Optional: To prevent GET access
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Use POST.");
    }
}