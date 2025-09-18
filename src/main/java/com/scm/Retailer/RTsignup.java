package com.scm.Retailer;
import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RTsignup")
@MultipartConfig
public class RTsignup extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {

                // Retrieve form data
                String RName = request.getParameter("name");
                String Rdob = request.getParameter("dateOfBirth");
                int R_contact = Integer.parseInt(request.getParameter("contactNo"));
                String email = request.getParameter("email");
                String Raddress = request.getParameter("address");
                
                String shopname = request.getParameter("shopName");
                String  shopno = request.getParameter("shopNo");
                String bus_lic_no = request.getParameter("businessLicenseNo");
                String gstin = request.getParameter("gstNo");
                
                String bankname = request.getParameter("bankName");
                String  accno = request.getParameter("accountNo");
                String ifsc = request.getParameter("ifscCode");
                
                String password = request.getParameter("confirmPassword");
                
                //Conversions
               
                java.sql.Date W_dob = null;

                try {
                    W_dob = java.sql.Date.valueOf(Rdob); // Converts "YYYY-MM-DD" string to SQL Date
                } catch (IllegalArgumentException e) {
                    
                }
                
               
               

                // Insert into transport table
                String retailerInsertQuery = "INSERT INTO retailer.retailer (retailer_name, retailer_contact, address, shop_name, shop_number, business_lic_no, gst_id, bank_name, account_no, ifsc_code ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                int rowsInsertedwholeseller = 0;

                try (PreparedStatement retailerStmt = connection.prepareStatement(retailerInsertQuery, Statement.RETURN_GENERATED_KEYS)) {
                	retailerStmt.setString(1, RName);
                	retailerStmt.setInt(2, R_contact);
                	retailerStmt.setString(3, Raddress);
                	retailerStmt.setString(4, shopname);
                	retailerStmt.setString(5, shopno);
                	retailerStmt.setString(6, bus_lic_no);
                	retailerStmt.setString(7, gstin);
                	retailerStmt.setString(8, bankname);
                	retailerStmt.setString(9, accno);
                	retailerStmt.setString(10, ifsc);
                   
                    rowsInsertedwholeseller = retailerStmt.executeUpdate();
                    
                    
                 // Retrieve generated transport_id
                    try (ResultSet generatedKeys = retailerStmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int retailerId = generatedKeys.getInt(1); // Capture transport_id
                            
                            
                            // Now insert into login table using transportId
                            String loginInsertQuery = "INSERT INTO retailer.login ( email, password, retailer_id) VALUES (?, ?, ?)";
                            int rowsInsertedLogin = 0;

                            try (PreparedStatement loginStmt = connection.prepareStatement(loginInsertQuery)) {
                            	loginStmt.setString(1, email);
                                loginStmt.setString(2, password);
                                loginStmt.setInt(3, retailerId);
                                rowsInsertedLogin = loginStmt.executeUpdate();
                                
                                // If both inserts successful
                                if (rowsInsertedwholeseller > 0  && rowsInsertedLogin > 0) {
                                    response.setContentType("text/html");
                                    PrintWriter out = response.getWriter();
                                    out.println("<script type=\"text/javascript\">");
                                    out.println("alert('Signup successfully.');");
                                    out.println("window.location.href = 'index.jsp';");
                                    out.println("</script>");
                                } else {
                                    // If any insert failed
                                    request.setAttribute("errorMessage", "Failed to insert data into the database.");
                                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                                }
                            }
                        }
                    }
                    
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