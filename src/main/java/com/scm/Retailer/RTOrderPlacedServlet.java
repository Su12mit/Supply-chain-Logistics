package com.scm.Retailer;

import com.scm.Transport.LoginId;
import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/RTOrderPlacedServlet")
@MultipartConfig
public class RTOrderPlacedServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection == null || connection.isClosed()) {
                request.setAttribute("errorMessage", "Database connection failed. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Begin transaction
            connection.setAutoCommit(false);

            int whID = 0, rid = 0, quantity = 0;
            int insertedCustomer = 0, insertedOrder = 0, insertedMyOrder = 0;
            int generatedCustomerId = -1, generatedOrderId = -1;
            double total = 0.0;
            String email = "", contact = "", address = "", productName = "", shop ="", status = "Pending", paymentStatus = "Pending";
            Timestamp now = new Timestamp(System.currentTimeMillis());
            

            try {
                whID = Integer.parseInt(request.getParameter("wholesellerID"));
                quantity = Integer.parseInt(request.getParameter("quantity"));
                total = Double.parseDouble(request.getParameter("total"));
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid numeric input.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int loginId = LoginId.getLoginId(request.getSession());
            String getRetailerSQL = "SELECT r.retailer_id, r.shop_name, lg.email, r.retailer_contact, r.address " +
                                    "FROM retailer.retailer r JOIN retailer.login lg ON r.retailer_id = lg.login_id " +
                                    "WHERE r.retailer_id = ?";
            try (PreparedStatement ps = connection.prepareStatement(getRetailerSQL)) {
                ps.setInt(1, loginId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        rid = rs.getInt("retailer_id");
                        shop = rs.getString("shop_name");
                        email = rs.getString("email");
                        contact = rs.getString("retailer_contact");
                        address = rs.getString("address");
                    } else {
                        request.setAttribute("errorMessage", "Retailer not found.");
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Insert customer
            String insertCustomerSQL = "INSERT INTO wholeseller.customer(wholeseller_id, customer_name, customer_email, customer_phone, customer_address, retailer_id) " +
                                       "VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(insertCustomerSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, whID);
                ps.setString(2, shop);
                ps.setString(3, email);
                ps.setString(4, contact);
                ps.setString(5, address);
                ps.setInt(6, rid);
                insertedCustomer = ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedCustomerId = rs.getInt(1);
                    }
                }
            }

            if (insertedCustomer == 0 || generatedCustomerId == -1) {
                throw new SQLException("Customer insertion failed.");
            }

            // Insert into order_request
            productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            String insertOrderSQL = "INSERT INTO wholeseller.order_request(wholeseller_id, customer_id, product_name, quantity, price, order_date, status, t_ammount, payment_status) " +
                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, whID);
                ps.setInt(2, generatedCustomerId);
                ps.setString(3, productName);
                ps.setInt(4, quantity);
                ps.setDouble(5, price);
                ps.setTimestamp(6, now);
                ps.setString(7, status);
                ps.setDouble(8, total);
                ps.setString(9, paymentStatus);
                insertedOrder = ps.executeUpdate();
                try (ResultSet rs1 = ps.getGeneratedKeys()) {
                    if (rs1.next()) {
                        generatedOrderId = rs1.getInt(1);
                    }
                }
            }

            if (insertedOrder == 0) {
                throw new SQLException("Order insertion failed.");
            }

            // Insert into my_orders
            String insertMyOrderSQL = "INSERT INTO retailer.my_orders(retailer_id, wholeseller_id, quantity, order_status, order_date, product_name, amount, payment_status, your_ref) " +
                                      "VALUES (?, ?, ?, ?, ?, ?, ? , ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(insertMyOrderSQL)) {
                ps.setInt(1, rid);
                ps.setInt(2, whID);
                ps.setInt(3, quantity);
                ps.setString(4, status);
                ps.setTimestamp(5, now);
                ps.setString(6, productName);
                ps.setDouble(7, total);
                ps.setString(8, paymentStatus);
                ps.setInt(9, generatedOrderId);
                insertedMyOrder = ps.executeUpdate();
            }

            if (insertedMyOrder == 0) {
                throw new SQLException("My order insertion failed.");
            }

            // Commit all
            connection.commit();
            HttpSession session = request.getSession();
            session.setAttribute("orderSuccess", "Order Placed Successfully.");
            response.sendRedirect("/Supply-chain-and-Logistic/retailer/buy-product.jsp");

        } catch (SQLException e) {
            // Rollback on error
            try (Connection conn = PostgresConnection.getConnection()) {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            request.setAttribute("errorMessage", "An error occurred during order placement: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Use POST.");
    }
}
