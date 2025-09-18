<%
    String requestIDString = request.getParameter("OrderId");
	
    // Convert string to integer (handle potential errors)
    int requestID = 0; // Default value in case of an exception
   try {
       requestID = Integer.parseInt(requestIDString);
        //request.setAttribute("requestID", requestID);

    } catch (NumberFormatException e) {
       
    } 
    double tprice = 0.0;
    double Pamt = 0.0;
    String Ppaystatus = "";
    String Porderstatus = "";
    
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT r.retailer_contact, r.address, r.shop_name, r.shop_number, r.business_lic_no, rlg.email, mor.product_name, mor.quantity, mor.order_status,  mor.order_date, mor.amount,mor.payment_status, mor.your_ref, wh.wholeseller_contact, wh.shop_name AS wholeseller_shop_name, wh.address AS wholeseller_address, wlg.email AS wholeseller_email  FROM retailer.retailer r JOIN retailer.my_orders mor ON r.retailer_id = mor.retailer_id JOIN retailer.login rlg on rlg.login_id = r.retailer_id JOIN wholeseller.wholeseller wh ON wh.wholeseller_id = mor.wholeseller_id JOIN wholeseller.login wlg ON wlg.login_id = wh.wholeseller_id  WHERE mor.my_order_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String Rcontact = rs.getString("retailer_contact");
    		 String Raddress = rs.getString("address");
    		 String Rshop = rs.getString("shop_name");
    		 String Rsno = rs.getString("shop_number");
    		 String Rblin = rs.getString("business_lic_no");
    		 String Rmail = rs.getString("email");
    		 String Pname = rs.getString("product_name");
    		 int Pqty = rs.getInt("quantity");
    		 Porderstatus = rs.getString("order_status");
    		 String Pdate = rs.getString("order_date");
    		 Pamt = rs.getDouble("amount");
    		 Ppaystatus = rs.getString("payment_status");
    		 int yourRef = rs.getInt("your_ref");
    		 String Wcontact = rs.getString("wholeseller_contact");
    		 String Wshop = rs.getString("wholeseller_shop_name");
    		 String Waddress = rs.getString("wholeseller_address");
    		 String Wmail = rs.getString("wholeseller_email");
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("Rcontact", Rcontact);
    		 request.setAttribute("Raddress", Raddress);
    		 request.setAttribute("Rshop", Rshop);
    		 request.setAttribute("Rsno", Rsno);
    		 request.setAttribute("Rblin", Rblin);
    		 request.setAttribute("Rmail", Rmail);
    		 request.setAttribute("Pname", Pname);
    		 request.setAttribute("Pqty", Pqty);
    		 request.setAttribute("Porderstatus", Porderstatus);
    		 request.setAttribute("Pdate", Pdate);
    		 request.setAttribute("Pamt", Pamt);
    		 request.setAttribute("Ppaystatus", Ppaystatus);
    		 request.setAttribute("yourRef", yourRef);
    		 request.setAttribute("Wcontact", Wcontact);
    		 request.setAttribute("Wshop", Wshop);
    		 request.setAttribute("Waddress", Waddress);
    		 request.setAttribute("Wmail", Wmail);

		}
		


} catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
  %>


<!DOCTYPE html>
<html>
<head>
    <title>Retailer Order Invoice</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: #f0f9f0; /* very light green background */
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 80, 0, 0.1); /* subtle green shadow */
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .invoice-header-left {
            width: 45%;
        }

        .invoice-header-right {
            width: 45%;
            text-align: right;
        }

        .invoice-header-left h2 {
            color: #2a7a2a; /* dark green */
        }

        .invoice-details {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .invoice-details-left,
        .invoice-details-right {
            width: 45%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #c7e6c7; /* light green border */
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #d4edda; /* very light green */
        }

        .total-row {
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2a7a2a; /* green */
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
      
        .amount-column {
            background-color: #e6f3e6; /* very light green */
        }

        .no-border {
            border: 0; /* Remove border for empty cells */
        }

        .btn:hover {
            background-color: #1e5c1e; /* darker green on hover */
        }

        .btn-reject {
            background-color: #a94442; /* muted red for reject button */
        }

        .btn-reject:hover {
            background-color: #7d3434;
        }

        .rejected {
            color: #888; /* Grayed-out text color */
            opacity: 0.5; /* Reduced opacity */
        }

        .rejected-message {
            color: #2a7a2a;  /* green */
            font-size: 20px; 
            font-weight: bold;
            text-align: center;
            margin-top: 20px; 
        }
        .pending-message{
        	 color: #FFA500; /* Amber */
            font-size: 20px; 
            font-weight: bold;
            text-align: center;
            margin-top: 20px; 
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="invoice-header">
            <div class="invoice-header-left">
                <h2>${Rshop}</h2>
                <p>${Raddress}</p>
                <p>${Rmail}</p>
                <p>${Rcontact}</p>
                <p>Shop No: ${Rsno}</p>
                <p>business lic no: ${Rblin}</p>
            </div>

            <div class="invoice-header-right">
                <h3 style="color: #2a7a2a;">ORDER INVOICE</h3>
                <p>Order No: <span id="invoiceNo">#ORD${requestID}</span></p>
                <p>Date: <span id="invoiceDate">${Pdate}</span></p>
                <p>Your Ref# :#REF-0${yourRef} </p>
                <p>Our Ref#: </p>
                <p>Credit Terms: NA</p>
            </div>
        </div>

        <div class="invoice-details">
            <div class="invoice-details-left">
                <h3>Buy From: </h3>
                <p>${Wshop }</p>
                <p>${Waddress }</p>
                
                <p>${Wmail}</p>
                <p>${Wcontact }</p>
            </div>

           <div class="invoice-details-right">
                <!--  <h3>Ship To:</h3>
                <p>Ship To Name</p>
                <p>Ship To Street Address</p>
                <p>City, State/Province, Zip/Post code</p>
                <p>Country</p>
                <p>Attention To: Contact Person</p> -->
            </div>
        </div>  

        <table>
            <thead>
                <tr>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>Unit</th>
                    <th>Unit Price</th> 
                    <th class="amount-column">Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${Pname }</td>
                    <td>${Pqty }</td>
                    <td>sets</td>
                    <td>${price }</td> 
                    <td class="amount-column">${Pamt }</td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border"><td>Sub Total </td>
                    
                    <td class="amount-column">${Pamt}</td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border"><td>GST</td>
                    </td> 
                    <td class="amount-column">360.00</td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border"><td>PST</td>
                    </td> 
                    <td class="amount-column">180.00</td>
                </tr>
               <% 
               tprice = Pamt + 360.00 + 180.00;
               %>
                <tr>
                    <td colspan="3" class="no-border"><td><b>Invoice Total<b></td>
                    </td> 
                    <td class="amount-column"><b><%= tprice %></b></td>

                </tr>
                <tr>
                    <td colspan="3" class="no-border"><td>Amount Paid</td>
                    </td> 
                    <td class="amount-column" style="color:red; font-weight:bold;">${Ppaystatus}</td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border" ><td><b>Balance Due</b></td>
                    </td> 
                    <% if ("Pending".equals(Ppaystatus)) { %>
         
                    <td class="amount-column" style="color:red; font-weight:bold;"><%= tprice %></td>
                    <%} else {%>
                    <td class="amount-column" style="color:red; font-weight:bold;">0.00</td>
                    <%} %>
                </tr>
            </tbody>
        </table>

        

        <p><b>Terms & Conditions:</b></p>
        <ul>
            <li>All goods remain the property of "Your Business Name" until full payment has been received.</li>
            <li>Please make check/cheque payments payable to "YOUR BUSINESS NAME".</li>
            <li>Payments may also be made by wire transfer to the following account:</li>
            <li>Account Name:</li>
            <li>Account No: </li>
        </ul>

       <% if ("Pending".equals(Porderstatus)) { %>
    
    <div id="PendingMessage" class="pending-message">Your Order is in Pending state</div>
<% } else if ("Accepted".equals(Porderstatus)){ %>
    <div class="rejected-message" style="color:green;">Order Already Accepted now make your payment</div>
<% } else{%>
<div class="rejected-message" style="color:red;">Your Order is Rejected</div>
<%} %>

    
<!--     
<script>
  const acceptBtn = document.getElementById('acceptBtn');
        const rejectBtn = document.getElementById('rejectBtn');
        const buttonContainer = document.getElementById('buttonContainer');

       acceptBtn.addEventListener('click', () => {
    buttonContainer.innerHTML = '<button id="downloadBtn" class="btn">Download PDF</button>';

    const downloadBtn = document.getElementById('downloadBtn');
    downloadBtn.addEventListener('click', () => {
        // Generate PDF content (this is a simplified example)
        const invoiceData = {
            // ... your invoice data (e.g., company details, customer info, products, totals)
        };

        // Use a library like jsPDF to generate the PDF
        const doc = new jsPDF(); 

        // Add content to the PDF (example)
        doc.text('Invoice', 14, 15); 
        // ... add more content to the PDF using doc.text(), doc.setFontSize(), doc.setFont(), etc.

        // Download the PDF
        doc.save('invoice.pdf'); 
    });
});

       
rejectBtn.addEventListener('click', () => {
    buttonContainer.innerHTML = ''; // Remove buttons
    rejectedMessage.style.display = 'block'; 
});
  </script> 
   -->
</body>
</html>
