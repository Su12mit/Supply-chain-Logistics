package com.scm.Wholeseller;
import java.sql.*;
import java.io.*;

import com.scm.db.PostgresConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddnewProductServlet")
@MultipartConfig
public class AddnewProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        try (Connection connection = PostgresConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {
            	 int stockID = 0;
            	 int Delid = 0;
                 int loginID = 0;
                 int generatedStockCatId = -1;
                 int affectedRows = 0;
                 int deletedtedRows1 = 0;
                 int deletedtedRows2 = 0;
                 String statusVal ="";
                 Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

                 try {
                     String loginIdString = request.getParameter("loginId");
                     String stockParam = request.getParameter("stockId");
                     String Delparam = request.getParameter("Delstockid");
                     
                     if (loginIdString != null && !loginIdString.isEmpty()) {
                         loginID = Integer.parseInt(loginIdString);
                     }

                     if (stockParam != null && !stockParam.isEmpty()) {
                         stockID = Integer.parseInt(stockParam);
                     }
                     if (Delparam != null && !Delparam.isEmpty()) {
                    	 Delid = Integer.parseInt(Delparam);
                     }

                 } catch (NumberFormatException e) {
                     request.setAttribute("errorMessage", "Invalid numeric parameters.");
                     request.getRequestDispatcher("/error.jsp").forward(request, response);
                     return;
                 }
                 
                 Part imagePart = request.getPart("productImage");
                 InputStream imageInputStream = null;
                 if (imagePart != null && imagePart.getSize() > 0) {
                     imageInputStream = imagePart.getInputStream();
                 }

                 
                 if (stockID > 0) {
                     // Reorder existing stock
                     int quantity = Integer.parseInt(request.getParameter("reorderQuantity"));
                     if(quantity >= 50) {
                    	 statusVal ="In Stock";
                     }
                     else if(quantity > 0) {
                    	 statusVal = "Low Stock";
                     }
                     else {
                    	 statusVal ="Out of Stock";
                     }
                     double price = Double.parseDouble(request.getParameter("reorderPrice"));
                     double weight = Double.parseDouble(request.getParameter("reorderWeight"));
                     int warranty = Integer.parseInt(request.getParameter("newWarranty"));

                     String updateSQL = "UPDATE wholeseller.stock SET quantity = ?, price = ?,  stock_date = ?, status = ?, weight = ?, warrenty = ?,  product_image = ? WHERE stock_id = ?";
                     PreparedStatement ps = connection.prepareStatement(updateSQL);
                     ps.setInt(1, quantity);
                     ps.setDouble(2, price);
                     ps.setTimestamp(3, currentTimestamp);
                     ps.setString(4, statusVal);
                     ps.setDouble(5, weight);
                     ps.setInt(6, warranty); 
                     // Set image as binary stream
                     if (imageInputStream != null) {
                         ps.setBinaryStream(7, imageInputStream, (int) imagePart.getSize());
                     } else {
                         ps.setNull(7, java.sql.Types.BINARY); // If no image uploaded
                     }
                     ps.setInt(8, stockID);
                 
                     affectedRows = ps.executeUpdate();

                 } else if (stockID == 0 && loginID > 0) {
                     // Insert new product
                     String customCategory = request.getParameter("customCategory");
                     String pname = request.getParameter("productName");
                     String bname = request.getParameter("brand");
                     int qty = Integer.parseInt(request.getParameter("stock"));
                     if(qty >=50) {
                    	 statusVal ="In Stock";
                     }
                     else if(qty > 0) {
                    	 statusVal = "Low Stock";
                     }
                     else {
                    	 statusVal ="Out of Stock";
                     }
                     double price = Double.parseDouble(request.getParameter("Price"));
                     double weight = Double.parseDouble(request.getParameter("weight"));
                     int warranty = Integer.parseInt(request.getParameter("warranty"));
                    

                     if (customCategory != null && !customCategory.trim().isEmpty()) {
                         // Insert new category
                         String insertCatSQL = "INSERT INTO wholeseller.stock_cat(wholeseller_id, category_name, description) VALUES(?,?,?)";
                         PreparedStatement catPs = connection.prepareStatement(insertCatSQL, Statement.RETURN_GENERATED_KEYS);
                         catPs.setInt(1, loginID);
                         catPs.setString(2, customCategory);
                         catPs.setString(3, "Price as Per Unit");
                         catPs.executeUpdate();

                         ResultSet rs = catPs.getGeneratedKeys();
                         if (rs.next()) {
                             generatedStockCatId = rs.getInt(1);
                         }
                     } else {
                         generatedStockCatId = Integer.parseInt(request.getParameter("category"));
                     }

                     // Insert product
                     String insertStockSQL = "INSERT INTO wholeseller.stock(wholeseller_id, product_name, quantity, price, stock_date, status, stock_cat_id, brand_name, weight, warrenty, product_image) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
                     PreparedStatement ps2 = connection.prepareStatement(insertStockSQL);
                     ps2.setInt(1, loginID);
                     ps2.setString(2, pname);
                     ps2.setInt(3, qty);
                     ps2.setDouble(4, price);
                     ps2.setTimestamp(5, currentTimestamp);
                     ps2.setString(6, statusVal);
                     ps2.setInt(7, generatedStockCatId);
                     ps2.setString(8, bname);
                     ps2.setDouble(9, weight);
                     ps2.setInt(10, warranty);

                  // Set image as binary stream
                  if (imageInputStream != null) {
                      ps2.setBinaryStream(11, imageInputStream, (int) imagePart.getSize());
                  } else {
                      ps2.setNull(11, java.sql.Types.BINARY); // If no image uploaded
                  }
                  
                     affectedRows = ps2.executeUpdate();
                 }
                 else if (stockID == 0 && loginID == 0 && Delid > 0) {
                	 String deldemand = "DELETE FROM wholeseller.demand WHERE stock_id = ?";
                	 String delstock ="DELETE FROM wholeseller.stock WHERE stock_id = ?";
                	 PreparedStatement ps4 = connection.prepareStatement(deldemand);
                	 ps4.setInt(1, Delid);
                	 PreparedStatement ps3 = connection.prepareStatement(delstock);
                     ps3.setInt(1, Delid);
                     deletedtedRows2 = ps4.executeUpdate();
                     deletedtedRows1 = ps3.executeUpdate();
                     
                 }
                 

                 if (affectedRows > 0) {
                     response.setContentType("text/html");
                     PrintWriter out = response.getWriter();
                     out.println("<script type=\"text/javascript\">");
                     out.println("alert('Product Details Stored Successfully.');");
                     out.println("history.go(-2);"); // or use redirect if preferred
                     out.println("</script>");
                 }
                 
                 if (deletedtedRows1 > 0 &&  deletedtedRows2 > 0) {
                     response.setContentType("text/html");
                     PrintWriter out = response.getWriter();
                     out.println("<script type=\"text/javascript\">");
                     out.println("alert('Product Deleted Successfully.');");
                     out.println("history.back(0);"); // or use redirect if preferred
                     out.println("</script>");
                 }
                 
            }else {
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