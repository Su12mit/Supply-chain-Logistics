package com.scm.Retailer;
import java.sql.*;
import java.io.*;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RTPayStoreServlet")
@MultipartConfig
public class RTPayStoreServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {
            	 
                 try {
                	 String mopayment = "Online";
                     String paymentstatus = "Paid";
                     int transportinvoiceId = 0;
                     int PaySlipID = 0;
                     int insertedrows = 0;
                     int whrow = 0;
                     
                     int OrderID = Integer.parseInt(request.getParameter("requestID"));
                     String taxID = request.getParameter("txnId");
                     String txnDateTimeStr = request.getParameter("txnDateTime");

                     if (txnDateTimeStr == null || txnDateTimeStr.isEmpty()) {
                         request.setAttribute("errorMessage", "Transaction datetime is missing.");
                         request.getRequestDispatcher("/error.jsp").forward(request, response);
                         return;
                     }

  
                     String retrivesql = "SELECT whpayslip_ref  FROM retailer.invoice WHERE order_id = ?";
                     PreparedStatement retriveStmt = connection.prepareStatement(retrivesql);
                     retriveStmt.setInt(1, OrderID);
                     ResultSet rs =retriveStmt.executeQuery();
                     if(rs.next()) {
                    	 PaySlipID = rs.getInt("whpayslip_ref");
                   }
                     
                     if(PaySlipID > 0 ) {
                    	 
                     String invupdatesql = "UPDATE retailer.invoice SET payment_status = ?, transaction_id = ?, mode_of_payment = ?, tr_date_time = ? WHERE order_id = ?";
                     PreparedStatement invupdateStmt = connection.prepareStatement(invupdatesql);
                     invupdateStmt.setString(1, paymentstatus);
                     invupdateStmt.setString(2, taxID);
                     invupdateStmt.setString(3, mopayment);
                     invupdateStmt.setString(4, txnDateTimeStr);
                     invupdateStmt.setInt(5, OrderID);
                     insertedrows = invupdateStmt.executeUpdate();
                     
                     }
                     if (insertedrows > 0) {
                    	 
                    	 // change payment status to wholesaler
                    	 String whsql ="UPDATE wholeseller.retailer_payments SET payment_status = ?, transaction_id = ?, mode_of_payment = ?,  tr_date_time = ? WHERE pay_slip_id = ? ";
                    	 PreparedStatement whStmt = connection.prepareStatement(whsql);
                    	 whStmt.setString(1, paymentstatus);
                    	 whStmt.setString(2, taxID);
                    	 whStmt.setString(3, mopayment);
                    	 whStmt.setString(4, txnDateTimeStr);
                    	 whStmt.setInt(5, PaySlipID);
                    	
                    	 whrow = whStmt.executeUpdate();
                     }
                     
                     if (insertedrows > 0 && whrow > 0) {
                    	    // Instead of redirect, set attributes and forward:
                    	    request.setAttribute("paymentSuccess", true);
                    	    request.setAttribute("txnId", taxID);
                    	    request.setAttribute("txnDateTime", txnDateTimeStr);
                    	    request.getRequestDispatcher("/retailer/payment-gateway/payment-pin-entry.jsp").forward(request, response);
                    	    return;
                    	}  
                     
                    
                 } catch (NumberFormatException e) {
                     request.setAttribute("errorMessage", "Invalid numeric parameters.");
                     request.getRequestDispatcher("/error.jsp").forward(request, response);
                     return;
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