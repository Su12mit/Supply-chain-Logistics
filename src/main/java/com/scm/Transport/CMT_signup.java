package com.scm.Transport;

import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CMT_signup")
@MultipartConfig
public class CMT_signup extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {

                // Retrieve form data
                String companyName = request.getParameter("companyName");
                String contactEmail = request.getParameter("contactEmail");
                String website = request.getParameter("website");
                String address = request.getParameter("address");
                String password = request.getParameter("password");
                InputStream companyLogo = null;

                // File upload (logo)
                Part filePart = request.getPart("companylogo");
                if (filePart != null) {
                    companyLogo = filePart.getInputStream();
                }

                // Insert into transport table
                String transportInsertQuery = "INSERT INTO transport.transport (transport_name, transport_website, logo, address, created_at) VALUES (?, ?, ?, ?, ?)";
                int rowsInsertedTransport = 0;

                try (PreparedStatement transportStmt = connection.prepareStatement(transportInsertQuery, Statement.RETURN_GENERATED_KEYS)) {
                    transportStmt.setString(1, companyName);
                   
                    transportStmt.setString(2, website);
                    if (companyLogo != null) {
                        byte[] logoBytes = companyLogo.readAllBytes(); // Convert InputStream to byte array
                        transportStmt.setBytes(3, logoBytes); // Use setBytes for bytea column
                    } else {
                        transportStmt.setNull(3, java.sql.Types.BINARY); // Set null for binary type
                    }

                    transportStmt.setString(4, address);
                    transportStmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
                  
                    rowsInsertedTransport = transportStmt.executeUpdate();
                    
                    
                 // Retrieve generated transport_id
                    try (ResultSet generatedKeys = transportStmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int transportId = generatedKeys.getInt(1); // Capture transport_id
                            
                            
                            // Now insert into login table using transportId
                            String loginInsertQuery = "INSERT INTO transport.login (login_id, email, password) VALUES (?, ?, ?)";
                            int rowsInsertedLogin = 0;

                            try (PreparedStatement loginStmt = connection.prepareStatement(loginInsertQuery)) {
                            	loginStmt.setInt(1, transportId);
                                loginStmt.setString(2, contactEmail);
                                loginStmt.setString(3, password);
                                rowsInsertedLogin = loginStmt.executeUpdate();
                                
                                // If both inserts successful
                                if (rowsInsertedTransport > 0  && rowsInsertedLogin > 0) {
                                    response.setContentType("text/html");
                                    PrintWriter out = response.getWriter();
                                    out.println("<script type=\"text/javascript\">");
                                    out.println("alert('Data inserted successfully into both tables.');");
                                    out.println("window.location.href = 'transport/cmp_transport/index.jsp';");
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