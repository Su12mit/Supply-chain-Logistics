
package com.scm.Transport;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import com.scm.db.PostgresConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/GetStatus")
public class GetStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String trackingNumber = request.getParameter("trackingNumber");

        if (trackingNumber == null || !trackingNumber.contains("-")) {
            request.setAttribute("error", "Invalid tracking number format.");
            request.getRequestDispatcher("/transport/cmp_transport/index.jsp").forward(request, response);
            return;
        }

        String deliveryId = trackingNumber.split("-")[1];
        
        int deliveryIdInt = Integer.parseInt(deliveryId);

        try (Connection connection = PostgresConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {
                HttpSession session = request.getSession();
                int loginId = LoginId.getLoginId(session); // Assuming you store loginId in session

                String query = "SELECT status FROM transport.delivery_tracking WHERE transport_id = ? AND delivery_id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, loginId);
                ps.setInt(2, deliveryIdInt);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String status = rs.getString("status");
                    request.setAttribute("status", status);
                } else {
                    request.setAttribute("error", "Tracking number not found.");
                }

                request.getRequestDispatcher("/transport/cmp_transport/index.jsp").forward(request, response);

            } else {
                request.setAttribute("error", "Database connection failed.");
                request.getRequestDispatcher("/transport/cmp_transport/index.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "SQL Error: " + e.getMessage());
            request.getRequestDispatcher("/transport/cmp_transport/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported.");
    }
}
