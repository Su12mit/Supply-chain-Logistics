package com.scm.Wholeseller;

import java.sql.*;
import java.io.*;

import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/PaymentSlipServlet")
@MultipartConfig
public class PaymentSlipServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection == null || connection.isClosed()) {
                request.setAttribute("errorMessage", "Database connection failed. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int paySlipID = 0, orderIDFromInvoice = 0, insertedRows = 0, gettingRows = 0;
            int wholesellerID = 0, orderID = 0, retailerID = 0;
            String paymentStatus = "", wholesellerName = "";
            double totalAmount = 0.0;
            Timestamp dueDateTime = null;

            try {
                String paySlipIDStr = request.getParameter("PaymentSlipID");
                if (paySlipIDStr != null && !paySlipIDStr.isEmpty()) {
                    paySlipID = Integer.parseInt(paySlipIDStr);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid numeric parameters.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            if (paySlipID > 0) {
                String checkSQL = "SELECT order_id FROM retailer.invoice WHERE whpayslip_ref = ?";
                PreparedStatement checkPs = connection.prepareStatement(checkSQL);
                checkPs.setInt(1, paySlipID);
                ResultSet checkRs = checkPs.executeQuery();
                if (checkRs.next()) {
                    orderIDFromInvoice = checkRs.getInt("order_id");
                }

                if (orderIDFromInvoice > 0) {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Payment Slip already sent.');");
                    out.println("history.go(0);");
                    out.println("</script>");
                    return;
                } else {
                    String selectSQL = "SELECT rtp.wholeseller_id, rtp.payment_status, rtp.payment_amount, rtp.due_date, wh.shop_name, retid.retailer_id, retid.my_order_id FROM wholeseller.retailer_payments rtp JOIN wholeseller.wholeseller wh ON rtp.wholeseller_id = wh.wholeseller_id JOIN retailer.my_orders retid ON retid.your_ref = rtp.order_request_id WHERE rtp.pay_slip_id = ?";
                    PreparedStatement selectPs = connection.prepareStatement(selectSQL);
                    selectPs.setInt(1, paySlipID);
                    ResultSet selectRs = selectPs.executeQuery();
                    if (selectRs.next()) {
                        wholesellerID = selectRs.getInt("wholeseller_id");
                        
                        paymentStatus = selectRs.getString("payment_status");
                        totalAmount = selectRs.getDouble("payment_amount");
                        dueDateTime = selectRs.getTimestamp("due_date");
                        wholesellerName = selectRs.getString("shop_name");
                        retailerID = selectRs.getInt("retailer_id");
                        orderID = selectRs.getInt("my_order_id");
                        gettingRows = 1;
                    }
                }
            }

            if (gettingRows > 0) {
                String insertSQL = "INSERT INTO retailer.invoice (retailer_id, order_id, amount, payment_status, wholesaler_name, due_date, whpayslip_ref, wholeseller_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertPs = connection.prepareStatement(insertSQL);
                insertPs.setInt(1, retailerID);
                insertPs.setInt(2, orderID);
                insertPs.setDouble(3, totalAmount);
                insertPs.setString(4, paymentStatus);
                insertPs.setString(5, wholesellerName);
                insertPs.setTimestamp(6, dueDateTime);
                insertPs.setInt(7, paySlipID);
                insertPs.setInt(8, wholesellerID);
                insertedRows = insertPs.executeUpdate();
            }

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            if (insertedRows > 0) {
                out.println("alert('Payment Slip sent successfully to retailer.');");
            } else {
                out.println("alert('Sorry. Something went wrong.');");
            }
            out.println("history.back();");
            out.println("</script>");

        } catch (SQLException | ServletException | IOException e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Use POST.");
    }
}
