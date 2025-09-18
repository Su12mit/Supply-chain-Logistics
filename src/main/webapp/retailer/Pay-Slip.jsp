<%
    String requestIDString = request.getParameter("payId");

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
        
	String sql = "SELECT wh.shop_name, wh.address, wh.wholeseller_contact, wlg.email, c.customer_name, c.customer_address, rpo.order_request_id, rpo.payment_status, rpo.transaction_id, rpo.mode_of_payment,  rpo.payment_amount, rpo.tr_date_time, wor.product_name, wor.quantity, wor.price FROM retailer.invoice iv JOIN wholeseller.retailer_payments rpo ON iv.whpayslip_ref = rpo.pay_slip_id JOIN wholeseller.wholeseller wh ON wh.wholeseller_id = rpo.wholeseller_id JOIN wholeseller.order_request wor ON rpo.order_request_id = wor.order_request_id JOIN wholeseller.login wlg ON wlg.login_id = wh.wholeseller_id JOIN wholeseller.customer c ON c.customer_id = wor.customer_id WHERE iv.order_id = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, requestID);
	ResultSet rs = ps.executeQuery();

	while (rs.next()) {
		
		 String shop_name = rs.getString("shop_name");
		 String waddress = rs.getString("address");
		 String wcontact = rs.getString("wholeseller_contact");
		 String wemail = rs.getString("email");
		 String cname = rs.getString("customer_name");
		 String caddress = rs.getString("customer_address");
		 int orderID = rs.getInt("order_request_id");
		 String pstatus = rs.getString("payment_status");
		 String transactionID = rs.getString("transaction_id");
		 String moPayment = rs.getString("mode_of_payment");
		 
		 double amt = rs.getDouble("payment_amount");
		 
		 String transactionTime = rs.getString("tr_date_time");
		 String Pname = rs.getString("product_name");
		 int qty = rs.getInt("quantity");
		 double price = rs.getDouble("price");
		 
			
		// Set request attributes correctly
		    request.setAttribute("shop_name", shop_name);
		    request.setAttribute("waddress", waddress);
		    request.setAttribute("wcontact", wcontact);
		    request.setAttribute("wemail", wemail);

		    request.setAttribute("cname", cname);
		    request.setAttribute("caddress", caddress);
		    request.setAttribute("orderID", orderID);
		    request.setAttribute("pstatus", pstatus);

		    request.setAttribute("Pname", Pname);
		    request.setAttribute("qty", qty);
		    request.setAttribute("price", price);

		    request.setAttribute("amt", amt);
		    request.setAttribute("transactionID", transactionID);
		    request.setAttribute("transactionTime", transactionTime);
		    request.setAttribute("moPayment", moPayment);
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
        background-color: #f3fdf4;
        margin: 0;
        padding: 20px;
        color: #2f4f2f;
    }

    .container {
        max-width: 850px;
        background-color: #ffffff;
        margin: 40px auto;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 6px 16px rgba(0, 128, 0, 0.15);
    }

    header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid #a5d6a7;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }

    .logo img {
        width: 120px;
    }

    .company-address {
        text-align: right;
        font-size: 14px;
        color: #4b8b4b;
    }

    .payment-receipt {
        text-align: center;
        font-size: 24px;
        font-weight: 600;
        color: #2e7d32;
        margin-bottom: 25px;
    }

    .lefty span,
    .rity span {
        background-color: #a5d6a7;
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

    th,
    td {
        border: 1px solid #c8e6c9;
        padding: 12px;
        text-align: left;
    }

    th {
        background-color: #388e3c;
        color: white;
        font-weight: 600;
    }

    .payment-status {
        display: inline-block;
        padding: 10px 15px;
        border-radius: 5px;
        font-weight: bold;
    }

    .payment-status.unpaid {
        background-color: #ffeb3b;
        color: #333;
    }

    .payment-status.paid {
        background-color: #43a047;
        color: white;
    }

    .payment-status.overdue {
        background-color: #e53935;
        color: white;
    }

    .payment-details {
        margin-top: 25px;
    }

    .btn {
        background-color: #388e3c;
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
        background-color: #2e7d32;
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    
</head>
<body>

    <div class="container">
        <header>
            <div class="logo">
                <img src="your_logo.png" alt="Company Logo"> 
                <h3> <i class="fas fa-store text-primary me-2"></i>   ${shop_name}</h3>
            </div>
            <div class="company-address">
                <p>${waddress }</p>
                <p>+91 ${wcontact}</p>
                <p>${wemail}</p>
            </div>
        </header>

        <div class="payment-receipt">
            <div> <span></span></div><p class="pay">Payment Receipt <div><span></span></div></p> 
        </div>

        <div class="invoice-info">
            <div>
                <p><strong>Invoice To:</strong></p>
                <p><strong></strong> <span id="customerName">${cname}</span></p>
                <p><strong></strong> <span id="customerAddress">${caddress}</span></p>
                <p><strong>State/UT Code:</strong> <span id="customerStateCode"> </span></p>
                <p><strong>Order ID:</strong> <span id="paymentDate">#ORD${orderID}</span></p> 
                <p><strong>Payment Method:</strong> <span id="paymentMethod"></span></p> 
            </div>
            <div>
                <div class="payment-status ${pstatus.toLowerCase()}">
   							Payment ${pstatus}
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
                    <td>${Pname }</td>
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
            <p><strong>Payment Transaction Id:</strong> <span id="transactionId">${transactionID}</span></p>
            <p><strong>Mode of Payment:</strong> <span id="paymentMode">${moPayment}</span></p>
            <p><strong>Payment Amount:</strong> <span id="paymentAmount">${amt}</span></p>
            <p><strong>Date & Time:</strong> <span id="paymentDateTime">${transactionTime}</span></p>
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