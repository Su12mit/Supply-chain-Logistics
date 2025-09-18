package com.scm.Transport;

import java.io.*;
import java.sql.*;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CheckEmailServlet")
@MultipartConfig
public class CheckEmailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	boolean exists = false;
        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {

                // Retrieve form data
                
                String contactEmail = request.getParameter("contactEmail");
                
                String query ="SELECT COUNT(*) FROM transport.login WHERE email = ?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1,contactEmail);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next() && resultSet.getInt(1) > 0) {
                            exists = true;
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
        response.setContentType("text/plain");
        response.getWriter().write(exists ? "exists" : "available");
     }
   
    // Optional: To prevent GET access
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Use POST.");
    }
}