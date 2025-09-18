package com.scm.Wholeseller;
import java.sql.*;
import java.io.*;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/PayGatewayServlet")
@MultipartConfig
public class PayGatewayServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {
            	 
                 try {
                	 String mopayment = "Online";
                     String paymentstatus = "Paid";
                     int transportinvoiceId = 0;
                     int transportID = 0;
                     String taxID = request.getParameter("txnId");
                     String txnDateTimeStr = request.getParameter("txnDateTime");

                     if (txnDateTimeStr == null || txnDateTimeStr.isEmpty()) {
                         request.setAttribute("errorMessage", "Transaction datetime is missing.");
                         request.getRequestDispatcher("/error.jsp").forward(request, response);
                         return;
                     }

                     OffsetDateTime odt;
                     try {
                         odt = OffsetDateTime.parse(txnDateTimeStr, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
                     } catch (Exception e) {
                         request.setAttribute("errorMessage", "Invalid date format. Please use ISO 8601 format.");
                         request.getRequestDispatcher("/error.jsp").forward(request, response);
                         return;
                     }

                     Timestamp timestamp = Timestamp.from(odt.toInstant());

                        
                     int insertedrows = 0;
                     int newrow = 0;
                     int invoiceID = Integer.parseInt(request.getParameter("requestID"));
                     
                     String retrivesql = "SELECT transport_id, transport_invoiceid FROM wholeseller.invoice WHERE invoice_id = ?";
                     PreparedStatement retriveStmt = connection.prepareStatement(retrivesql);
                     retriveStmt.setInt(1, invoiceID);
                     ResultSet rs =retriveStmt.executeQuery();
                     while(rs.next()) {
                    	 transportID = rs.getInt("transport_id");
                    	 transportinvoiceId = rs.getInt("transport_invoiceid");
                     }
                     
                     if(transportID != 0 && transportinvoiceId != 0) {
                    	 
                     String sqlinvoice = "UPDATE wholeseller.invoice SET payment_status = ? WHERE invoice_id = ?";
                     PreparedStatement invoiceStmt = connection.prepareStatement(sqlinvoice);
                     invoiceStmt.setString(1, paymentstatus);
                     invoiceStmt.setInt(2, invoiceID);
                     insertedrows = invoiceStmt.executeUpdate();
                     
                     }
                     if (insertedrows > 0) {
                    	 
                    	 // change order request status in transport
                    	 String transportsql ="UPDATE transport.invoices SET status = ?, transaction_id = ?, tr_date_time = ?, mode_of_payment = ? WHERE invoice_id = ? AND transport_id =?";
                    	 PreparedStatement transportStmt = connection.prepareStatement(transportsql);
                    	 transportStmt.setString(1, paymentstatus);
                    	 transportStmt.setString(2, taxID);
                    	 transportStmt.setTimestamp(3, timestamp);
                    	 transportStmt.setString(4, mopayment);
                    	 transportStmt.setInt(5, transportinvoiceId);
                    	 transportStmt.setInt(6, transportID);
                    	 newrow = transportStmt.executeUpdate();
                     }
                     
                     if(newrow > 0) {
                    	 response.sendRedirect("payment-pin-entry.jsp");

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