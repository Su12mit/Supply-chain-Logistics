package com.scm.Wholeseller;

import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

public class Demo extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = PostgresConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {
                //
                //
            	//
            	//
            	//
            	//    ADD YOUR CODE HERE OTHER THINGS REMINS SAME
            	//    
            	//     JUST CHANGE NAME OF CLASS AND IMPORT NEEDED PACKAGE
            	//
            	//
            	//
            	//
            	//
            } else {
                request.setAttribute("errorMessage", "Database connection failed. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database connection failed: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
