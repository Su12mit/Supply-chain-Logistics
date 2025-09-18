package com.scm.Transport;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import com.scm.db.PostgresConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdatesServlet")
public class UpdatesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection connection = PostgresConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {

                // Get values from request
                String deliveryIdStr = request.getParameter("deliveryID");
                String newstatus = request.getParameter("status");
                String completestatus = request.getParameter("complete");

                int deliveryID = (deliveryIdStr != null && !deliveryIdStr.isEmpty()) ? Integer.parseInt(deliveryIdStr) : 0;

                int insertdt = 0, insertdt1 = 0, insertdt2 = 0, insertdt3 = 0, insertdt4 = 0;
                int shipmentId = 0, fleetID = 0, orderID = 0;

                // Get shipmentId, fleetId, and orderID
                String getIDS = "SELECT dt.shipment_id, dt.fleet_id, s.delivery_request_id " +
                                "FROM transport.delivery_tracking dt " +
                                "JOIN transport.shipment s ON s.shipment_id = dt.shipment_id " +
                                "WHERE delivery_id = ?";
                PreparedStatement getps = connection.prepareStatement(getIDS);
                getps.setInt(1, deliveryID);
                ResultSet getrs = getps.executeQuery();
                if (getrs.next()) {
                    shipmentId = getrs.getInt("shipment_id");
                    fleetID = getrs.getInt("fleet_id");
                    orderID = getrs.getInt("delivery_request_id");
                }

                // 1. If status is being updated (normal case)
                if (newstatus != null && !newstatus.trim().isEmpty() && (completestatus == null || completestatus.trim().isEmpty())) {
                    String query = "UPDATE transport.delivery_tracking SET status = ? WHERE delivery_id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, newstatus);
                    ps.setInt(2, deliveryID);
                    insertdt = ps.executeUpdate();
                }
                // 2. If status is 'Order Completed' (final completion)
                else if (completestatus != null && !completestatus.trim().isEmpty() && deliveryID > 0) {
                    // Update delivery_tracking
                    String query1 = "UPDATE transport.delivery_tracking SET status = ? WHERE delivery_id = ?";
                    PreparedStatement ps1 = connection.prepareStatement(query1);
                    ps1.setString(1, completestatus);
                    ps1.setInt(2, deliveryID);
                    insertdt1 = ps1.executeUpdate();

                    // Update shipment
                    String query2 = "UPDATE transport.shipment SET status = ? WHERE shipment_id = ?";
                    PreparedStatement ps2 = connection.prepareStatement(query2);
                    ps2.setString(1, completestatus);
                    ps2.setInt(2, shipmentId);
                    insertdt2 = ps2.executeUpdate();

                    // Update fleet
                    String query3 = "UPDATE transport.fleets SET status = ?, route = ? WHERE fleet_id = ?";
                    PreparedStatement ps3 = connection.prepareStatement(query3);
                    ps3.setString(1, "Inactive");
                    ps3.setString(2, "NA");
                   
                    ps3.setInt(3, fleetID);
                    insertdt3 = ps3.executeUpdate();

                    // Update delivery_request
                    String query4 = "UPDATE transport.delivery_request SET status = ? WHERE delivery_request_id = ?";
                    PreparedStatement ps4 = connection.prepareStatement(query4);
                    ps4.setString(1, completestatus);
                    ps4.setInt(2, orderID);  // ✅ Corrected index
                    insertdt4 = ps4.executeUpdate();
                }

                // Output result
                if (insertdt > 0) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Status updated successfully.');");
                    out.println("window.location.href = '/Supply-chain-and-Logistic/transport/cmp_transport/index.jsp';");
                    out.println("</script>");
                } else if (insertdt1 > 0 && insertdt2 > 0 && insertdt3 > 0 && insertdt4 > 0) {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Delivery Order Completed and removed successfully.');");
                    out.println("window.location.href = '/Supply-chain-and-Logistic/transport/cmp_transport/index.jsp';");
                    out.println("</script>");
                } else {
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Something went wrong.');");
                    out.println("window.location.href = '/Supply-chain-and-Logistic/transport/cmp_transport/index.jsp';");
                    out.println("</script>");
                }

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
