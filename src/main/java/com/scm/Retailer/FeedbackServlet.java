package com.scm.Retailer;
import java.sql.*;
import java.io.*;

import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/FeedbackServlet")
@MultipartConfig
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {
            	
            	 int WHid = 0;
                
                 int custId = 0 ;
                
                 int updatedRows = 0;
               
                 Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                 String orderIdStr = request.getParameter("ProductName");
                 int orderId = Integer.parseInt(orderIdStr); // Always validate/try-catch in real app
                 String ratingSTR = request.getParameter("rating");
                 int rating = Integer.parseInt(ratingSTR);

                String subjectstr = request.getParameter("Subjectstr");
                String msgstr = request.getParameter("textareamsg");
                 
                 if (orderId > 0) {
                     // Get Id s
                    
                     String selectSQL = "SELECT c.customer_id, c.wholeseller_id FROM wholeseller.customer c JOIN retailer.my_orders mor ON c.retailer_id = mor.retailer_id WHERE mor.my_order_id = ?";
                     PreparedStatement ps = connection.prepareStatement(selectSQL);
                     ps.setInt(1, orderId);
                     ResultSet rs = ps.executeQuery();
                     while(rs.next()) {
                    	 custId = rs.getInt("customer_id");
                    	 WHid = rs.getInt("wholeseller_id");
                     }
                 }
                   
                 if (custId > 0 && WHid > 0) {
                     // Insert new feedback
                    
                         String insertSQL = "INSERT INTO wholeseller.feedback(wholeseller_id, customer_id, feedback_text, rating, feedback_date) VALUES(?,?,?,?,?)";
                         PreparedStatement insertPs = connection.prepareStatement(insertSQL);
                         insertPs.setInt(1, WHid);
                         insertPs.setInt(2, custId);
                         insertPs.setString(3, msgstr);
                         insertPs.setInt(4, rating);
                         insertPs.setTimestamp(5, currentTimestamp);
                         updatedRows = insertPs.executeUpdate();

                     }
                 

                 if (updatedRows > 0) {
                	 response.sendRedirect("/Supply-chain-and-Logistic/retailer/index.jsp");
                 }
                 
                
                 
            }else {
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