<%@ page import="java.io.OutputStream, java.sql.*, com.scm.db.PostgresConnection" %>
<%
    response.setContentType("image/jpg"); // or "image/png" if needed

    String idParam = request.getParameter("id");
    if (idParam != null) {
        try {
            int stockId = Integer.parseInt(idParam);

            try (Connection conn = PostgresConnection.getConnection()) {
                String sql = "SELECT product_image FROM wholeseller.stock WHERE stock_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, stockId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    byte[] imageBytes = rs.getBytes("product_image");
                    if (imageBytes != null && imageBytes.length > 0) {
                        OutputStream os = response.getOutputStream();
                        os.write(imageBytes);
                        os.flush();
                        os.close();
                    }
                }

                rs.close();
                ps.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
