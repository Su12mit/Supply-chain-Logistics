package com.scm.controller;

import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

public class DemoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Try to establish a database connection using the DB utility class
        try (Connection connection = PostgresConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {
                // Connection is successful, set success message and stay on the same page (index.jsp)
                request.setAttribute("message", "Database connection successful!");
                PrintWriter output = response.getWriter();
                output.println("<h1>Database connection successful!</h1>");
            } else {
                // If connection is closed or failed, set error message and forward to error.jsp
                request.setAttribute("errorMessage", "Database connection failed. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Database connection failed, set error message and forward to error.jsp with exception details
            request.setAttribute("errorMessage", "Database connection failed: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
