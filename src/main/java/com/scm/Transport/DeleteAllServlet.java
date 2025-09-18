package com.scm.Transport;

import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteAllServlet")
public class DeleteAllServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html");
    	 PrintWriter out = response.getWriter();
    	 
    	 //Values Declarations 
    	 int id = 0;
    	 
    	 //Accepting Values
    	 String action = request.getParameter("action");
         String sql = ""; 
    	 
        try (Connection connection = PostgresConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {
            		
            	// Performing Operations
            	if ("OrderDelete".equals(action)) {
            		id = Integer.parseInt(request.getParameter("delivery_request_id"));
                    sql = "UPDATE transport.delivery_request SET status = 'Rejected' WHERE delivery_request_id =? ";
                    
                } else if ("Fleetdelete".equals(action)) {
                	id = Integer.parseInt(request.getParameter("fleet_id"));
                    sql = "UPDATE transport.fleets SET status = 'Inactive' WHERE fleet_id =?";
                }else {
                	response.setContentType("text/html");
                    response.getWriter().println("<script type='text/javascript'>");
                    response.getWriter().println("alert('Something wrong Happen ');");
                    response.getWriter().println("history.back();");
                    response.getWriter().println("</script>");
                }
                	/*else if ("paymentSend".equals(action)) {
                }
                    sql = " FROM shipment";
                }*/
            	
            	//Executing Query
            	 if (!sql.isEmpty()) {
                     PreparedStatement stmt = connection.prepareStatement(sql);
                    	 stmt.setInt(1, id);
                          stmt.executeUpdate();
                         response.setContentType("text/html");
                         response.getWriter().println("<script type='text/javascript'>");
                         response.getWriter().println("alert('Order Rejected ');");
                         response.getWriter().println("history.back();");
                         response.getWriter().println("</script>");
                     
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
