package com.scm.Wholeseller;

import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/Whsignup")
@MultipartConfig
public class Whsignup extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {

                // Retrieve form data
                String WName = request.getParameter("name");
                String Wdob = request.getParameter("dateOfBirth");
                int W_contact = Integer.parseInt(request.getParameter("contactNo"));
                String email = request.getParameter("email");
                String Waddress = request.getParameter("address");
                int W_zipcode = Integer.parseInt(request.getParameter("zipCode"));
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
                    W_dob = java.sql.Date.valueOf(Wdob); // Converts "YYYY-MM-DD" string to SQL Date
                } catch (IllegalArgumentException e) {
                    
                }
                
               
               

                // Insert into transport table
                String wholesellerInsertQuery = "INSERT INTO wholeseller.wholeseller (wholeseller_name, wholeseller_contact, address, shop_name, shop_number, business_lic_no, gst_id, bank_name, account_no, ifsc_code, dob, zip_code ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                int rowsInsertedwholeseller = 0;

                try (PreparedStatement wholesellerStmt = connection.prepareStatement(wholesellerInsertQuery, Statement.RETURN_GENERATED_KEYS)) {
                    wholesellerStmt.setString(1, WName);
                    wholesellerStmt.setInt(2, W_contact);
                    wholesellerStmt.setString(3, Waddress);
                    wholesellerStmt.setString(4, shopname);
                    wholesellerStmt.setString(5, shopno);
                    wholesellerStmt.setString(6, bus_lic_no);
                    wholesellerStmt.setString(7, gstin);
                    wholesellerStmt.setString(8, bankname);
                    wholesellerStmt.setString(9, accno);
                    wholesellerStmt.setString(10, ifsc);
                    wholesellerStmt.setDate(11, W_dob);
                    wholesellerStmt.setInt(12, W_zipcode);
                   
                    rowsInsertedwholeseller = wholesellerStmt.executeUpdate();
                    
                    
                 // Retrieve generated transport_id
                    try (ResultSet generatedKeys = wholesellerStmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int wholesellerId = generatedKeys.getInt(1); // Capture transport_id
                            
                            
                            // Now insert into login table using transportId
                            String loginInsertQuery = "INSERT INTO wholeseller.login ( email, password, wholeseller_id) VALUES (?, ?, ?)";
                            int rowsInsertedLogin = 0;

                            try (PreparedStatement loginStmt = connection.prepareStatement(loginInsertQuery)) {
                            	loginStmt.setString(1, email);
                                loginStmt.setString(2, password);
                                loginStmt.setInt(3, wholesellerId);
                                rowsInsertedLogin = loginStmt.executeUpdate();
                                
                                // If both inserts successful
                                if (rowsInsertedwholeseller > 0  && rowsInsertedLogin > 0) {
                                    response.setContentType("text/html");
                                    PrintWriter out = response.getWriter();
                                    out.println("<script type=\"text/javascript\">");
                                    out.println("alert('Signup successfully.');");
                                    out.println("window.location.href = 'wholeseller/index.html';");
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