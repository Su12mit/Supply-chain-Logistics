<%
    String requestIDString = request.getParameter("invoice_id");

    // Convert string to integer (handle potential errors)
    int requestID = 0; // Default value in case of an exception
    try {
        requestID = Integer.parseInt(requestIDString);
        //request.setAttribute("requestID", requestID);

    } catch (NumberFormatException e) {
       
    }
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
	String sql = "SELECT s.shipment_id, t.transport_name, t.address, tl.email, t.transport_contact, c.customer_name, c.customer_address,  dr.product_name, dr.quantity,  dr.price,  iv.tr_amount, iv.status, iv.transaction_id, iv.tr_date_time, iv.mode_of_payment FROM transport.shipment s JOIN transport.transport t ON s.transport_id = t.transport_id JOIN transport.login tl ON t.transport_id = tl.login_id JOIN transport.delivery_request dr ON s.delivery_request_id = dr.delivery_request_id JOIN transport.customer c ON dr.customer_id = c.customer_id JOIN transport.invoices iv  ON s.shipment_id = iv.shipment_id WHERE iv.invoice_id = ?";

	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, requestID);
	ResultSet rs = ps.executeQuery();

	while (rs.next()) {
		 int order_id = rs.getInt("shipment_id");
		 String company_name = rs.getString("transport_name");
		 String company_contact = rs.getString("transport_contact");
		 String company_email = rs.getString("email");
		 String company_address = rs.getString("address");
		 String c_name = rs.getString("customer_name");
		 String c_address = rs.getString("customer_address");
		 String p_name = rs.getString("product_name");
		 int qty = rs.getInt("quantity");
		 int price = rs.getInt("price");
		 
		 int amt = rs.getInt("tr_amount");
		 String status = rs.getString("status");
		 String tr_id = rs.getString("transaction_id");
		 String tr_date = rs.getString("tr_date_time");
		 String m_payment = rs.getString("mode_of_payment");
		 
			
		 // Fetch and display other details as needed
		 
		 request.setAttribute("requestID", requestID);
		 request.setAttribute("company_name", company_name);
		 request.setAttribute("c_name", c_name);
		 request.setAttribute("c_address", c_address);
		 request.setAttribute("company_contact", company_contact);
		 request.setAttribute("company_email", company_email);
		 request.setAttribute("order_id", order_id);
		 request.setAttribute("company_address", company_address);
		 request.setAttribute("p_name", p_name);
		 request.setAttribute("qty", qty);
		 request.setAttribute("price", price);
		 
		 request.setAttribute("amt", amt);
		 request.setAttribute("status", status);
		 request.setAttribute("tr_id", tr_id);
		 request.setAttribute("tr_date", tr_date);
		 request.setAttribute("m_payment", m_payment);
		
		}
		


} catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
  %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt</title>
    <style>
       body {
    font-family: 'Poppins', sans-serif;
    background-color: #f4f7fc;
    margin: 0;
    padding: 20px;
    color: #333;
}

.container {
    max-width: 850px;
    background-color: #ffffff;
    margin: 40px auto;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #d1d5db;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

.logo img {
    width: 120px;
}

.company-address {
    text-align: right;
    font-size: 14px;
    color: #666;
}

.payment-receipt {
    text-align: center;
    font-size: 24px;
    font-weight: 600;
    color: #004d99;
    margin-bottom: 25px;
}

.lefty span, .rity span {
    background-color: #ffc107;
    padding: 10px 100px;
    display: inline-block;
}

.invoice-info {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
}

th {
    background-color: #004d99;
    color: white;
    font-weight: 600;
}

.payment-status {
    display: inline-block;
    padding: 10px 15px;
    border-radius: 5px;
    font-weight: bold;
}

.payment-status.pending {
    background-color: #ffcc00;
    color: black;
}

.payment-status.paid {
    background-color: #28a745;
    color: white;
}

.payment-status.overdue {
    background-color: #dc3545;
    color: white;
}

.payment-details {
    margin-top: 25px;
}

.btn {
    background-color: #004d99;
    color: #ffffff;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 5%;
    display: block;
    width: fit-content;
    text-align: center;
    margin-left: auto;
    transition: background-color 0.3s ease;
}

.btn:hover {
    background-color: #003366;
}

.barcode {
    margin-top: 20px;
    text-align: center;
}

.barcode img {
    max-width: 180px;
    height: auto;
}
    </style>
</head>
<body>

    <div class="container">
        <header>
            <div class="logo">
                <img src="your_logo.png" alt="Company Logo"> 
                <h3>${company_name}</h3>
            </div>
            <div class="company-address">
                <p>${company_address }</p>
                <p>Contact: ${company_contact}</p>
                <p>Email: ${company_email}</p>
            </div>
        </header>

        <div class="payment-receipt">
            <div> <span></span></div><p class="pay">Payment Receipt <div><span></span></div></p> 
        </div>

        <div class="invoice-info">
            <div>
                <p><strong>Invoice To:</strong></p>
                <p><strong>Name:</strong> <span id="customerName">${c_name}</span></p>
                <p><strong>Address:</strong> <span id="customerAddress">${c_address}</span></p>
                <p><strong>State/UT Code:</strong> <span id="customerStateCode"> </span></p>
                <p><strong>Order ID:</strong> <span id="paymentDate">#ORD${order_id}</span></p> 
                <p><strong>Payment Method:</strong> <span id="paymentMethod">${m_payment}</span></p> 
            </div>
            <div>
                <div class="payment-status ${status.toLowerCase()}">
   							Payment ${status}
				</div>

            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${p_name }</td>
                    <td>${qty }</td>
                    <td>${price }</td>
                    <td>${amt}</td>
                </tr>
               
                <tr>
                    <td colspan="3"><strong>Total:</strong></td>
                    <td><strong>${amt}</strong></td> 
                </tr>
            </tbody>
        </table>

        <div class="payment-details">
            <h2>Payment Details</h2>
            <p><strong>Payment Transaction Id:</strong> <span id="transactionId">${tr_id}</span></p>
            <p><strong>Mode of Payment:</strong> <span id="paymentMode">${m_payment}</span></p>
            <p><strong>Payment Amount:</strong> <span id="paymentAmount">${amt}</span></p>
            <p><strong>Date & Time:</strong> <span id="paymentDateTime">${tr_date}</span></p>
        </div>

        <div class="barcode">
            <img src="img/barcode.png" alt="Barcode"> 
        </div>

        <button id="downloadBtn" class="btn">Download PDF</button> 

    </div>

    <script>
       // Download PDF functionality
        const downloadBtn = document.getElementById('downloadBtn');

        downloadBtn.addEventListener('click', () => {
            // Create a temporary HTML element to hold the invoice content
            const tempElement = document.createElement('div');
            tempElement.innerHTML = document.querySelector('.container').innerHTML; 

            // Create a new window with the invoice content
            const win = window.open('', '', 'width=800,height=600');
            win.document.write('<html><head><title>Invoice</title></head><body>');
            win.document.write(tempElement.outerHTML);
            win.document.write('</body></html>');

            // Trigger the print dialog
            win.print();
            win.close(); 
        });
    </script>

</body>
</html>