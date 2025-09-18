<%
    String requestIDString = request.getParameter("orderID");

    // Convert string to integer (handle potential errors)
    int requestID = 0; // Default value in case of an exception
   try {
       requestID = Integer.parseInt(requestIDString);
        //request.setAttribute("requestID", requestID);

    } catch (NumberFormatException e) {
       
    } 
    int orderID = 0;
    int yourref = 0;
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT wh.shop_name, wh.wholeseller_contact, wh.address, wh.shop_number, lg.email,  o.order_request_id, o.order_date, o.product_name, o.quantity, o.price, o.t_ammount, o.status, c.customer_name, c.customer_address, c.customer_email, c.customer_phone, r.my_order_id FROM wholeseller.order_request o JOIN wholeseller.customer c ON o.customer_id = c.customer_id JOIN wholeseller.wholeseller wh ON wh.wholeseller_id = o.wholeseller_id JOIN wholeseller.login lg ON lg.login_id = wh.wholeseller_id JOIN retailer.my_orders r ON o.order_request_id = r.your_ref WHERE o.order_request_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String shop_name = rs.getString("shop_name");
    		 String wh_contact = rs.getString("wholeseller_contact");
    		 String address = rs.getString("address");
    		 String   snum = rs.getString("shop_number");
    		 String email = rs.getString("email");
    		 String date = rs.getString("order_date");  		 
    		 String cname = rs.getString("customer_name");
    		 String caddress = rs.getString("customer_address");
    		 String cemail = rs.getString("customer_email");
    		 String cphone = rs.getString("customer_phone");
    		 String p_name = rs.getString("product_name");
    		 String status = rs.getString("status");
    		 int qty = rs.getInt("quantity");
    		  orderID = rs.getInt("order_request_id");
    		  yourref = rs.getInt("my_order_id");
    		 double price = rs.getDouble("price");
    		 double tamt = rs.getDouble("t_ammount");
    		 double tprice = tamt + 360.00 + 180.00; // Adding extra charges
   			
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("shop_name", shop_name);
    		 request.setAttribute("wh_contact", wh_contact);
    		 request.setAttribute("address", address);
    		 request.setAttribute("snum", snum);
    		 request.setAttribute("email", email);
    		 request.setAttribute("date", date);
    		 request.setAttribute("cname", cname);
    		 request.setAttribute("caddress", caddress);
    		 request.setAttribute("cemail", cemail);
    		 request.setAttribute("cphone", cphone); 
    		 request.setAttribute("p_name", p_name);
    		 request.setAttribute("qty", qty);
    		 request.setAttribute("price", price);
    		 request.setAttribute("tamt", tamt);
    		 request.setAttribute("tprice", tprice);
    		 request.setAttribute("status", status);
    		 request.setAttribute("yourref", yourref);
    			
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
            background-color: #f0f0f0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
            color: #428bca; 
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
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .total-row {
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #428bca;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
      
      .amount-column {
            background-color: #e6f0ff; /* Light blue background */
        }

 .no-border {
            border: 0; /* Remove border for empty cells */
        }
        .btn:hover {
            background-color: #3071a9;
        }

        .btn-reject {
            background-color: #d9534f;
        }

        .btn-reject:hover {
            background-color: #c1302d;
        }
      .rejected {
            color: #888; /* Grayed-out text color */
            opacity: 0.5; /* Reduced opacity */
        }
      .rejected-message {
            color: red; 
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
                <h2>${shop_name}</h2>
                <p>${address}</p>
                <p>Email: ${email}</p>
                <p>Tel: ${wh_contact}</p>
                <p>Shop No: ${snum}</p>
                <p>Tax Registration Number: your tax reg. no</p>
            </div>

            <div class="invoice-header-right">
                <h3 style="color: #d9534f;">ORDER INVOICE</h3>
                <p>Order No: <span id="invoiceNo">#ORD${requestID}</span></p>
                <p>Date: <span id="invoiceDate">${date}</span></p>
                <p>Your Ref#: #REF-0${yourref} </p>
                <p>Our Ref#: </p>
                <p>Credit Terms: NA</p>
            </div>
        </div>

        <div class="invoice-details">
            <div class="invoice-details-left">
                <h3>Sold To: </h3>
                <p>Customer Name : ${cname }</p>
                <p>Street Address : ${caddress }</p>
                
                <p>Email : ${cemail}</p>
                <p>Attention To: ${cphone }</p>
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
                    <td>${p_name }</td>
                    <td>${qty }</td>
                    <td>sets</td>
                    <td>${price }</td> 
                    <td class="amount-column">${tamt }</td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border"><td>Sub Total </td>
                    
                    <td class="amount-column">${tamt}</td>
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
                <tr>
                    <td colspan="3" class="no-border"><td><b>Invoice Total<b></td>
                    </td> 
                    <td class="amount-column"><b>${tprice}</b></td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border"><td>Amount Paid</td>
                    </td> 
                    <td class="amount-column" style="color:green; font-weight:bold;">${tprice}</td>
                </tr>
                <tr>
                    <td colspan="3" class="no-border" ><td><b>Balance Due</b></td>
                    </td> 
                    <td class="amount-column" style="color:red; font-weight:bold;">00.00</td>
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

       <% if (!"Accepted".equalsIgnoreCase((String)request.getAttribute("status"))) { %>
    <div id="buttonContainer">
      <a href="SelectTransport.jsp?orderID=<%= orderID %>&yourREF=<%=yourref%>">
        <button id="acceptBtn" class="btn">Process</button>
      </a>
      <button id="rejectBtn" class="btn btn-reject">Reject</button>
    </div>
    <div id="rejectedMessage" class="rejected-message" style="display: none;">Rejected</div>
<% } else { %>
    <div class="rejected-message" style="color:green;">Order Already Accepted</div>
<% } %>

    
    
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
</body>
</html>