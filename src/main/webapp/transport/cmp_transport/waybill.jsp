<!DOCTYPE html>
<html lang="en">
<%
    String requestIDString = request.getParameter("delivery_request_id");

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
        
		String sql = "SELECT dr.request_date, dr.buyer_name, dr.buyer_contact, dr.delivery_address, dr.buyer_email, dr.product_name, dr.quantity, dr.weight, dr.price, dr.delivery_expected_date, c.customer_name, c.customer_email, c.customer_phone, c.customer_address, t.transport_name FROM transport.delivery_request dr JOIN transport.customer c ON dr.customer_id = c.customer_id JOIN transport.transport t ON dr.transport_id = t.transport_id WHERE dr.delivery_request_id = ?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String company_name = rs.getString("transport_name");
    		 String issue_date = rs.getString("request_date");
    		 String s_name = rs.getString("customer_name");
    		 String s_address = rs.getString("customer_address");
    		 String s_phone = rs.getString("customer_phone");
    		 String s_email = rs.getString("customer_email");
    		 String d_name = rs.getString("buyer_name");
    		 String d_address = rs.getString("delivery_address");
    		 String d_contact = rs.getString("buyer_contact");
    		 String d_email = rs.getString("buyer_email");
    		 String e_date = rs.getString("delivery_expected_date");
    		 String p_name = rs.getString("product_name");
    		 int qty = rs.getInt("quantity");
    		 int weight = rs.getInt("weight");
    		 int price = rs.getInt("price");
    		 
    		 int tprice = price + 500 + 50; // Adding extra charges
   			
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("company_name", company_name);
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("issue_date", issue_date);
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("s_name", s_name);
    		 request.setAttribute("s_address", s_address);
    		 request.setAttribute("s_phone", s_phone);
    		 request.setAttribute("s_email", s_email);
    		 request.setAttribute("d_name", d_name);
    		 request.setAttribute("d_address", d_address);
    		 request.setAttribute("d_contact", d_contact);
    		 request.setAttribute("d_email", d_email);
    		 request.setAttribute("e_date", e_date);
    		 request.setAttribute("p_name", p_name);
    		 request.setAttribute("qty", qty);
    		 request.setAttribute("weight", weight);
    		 request.setAttribute("price", price);
    		 request.setAttribute("tprice", tprice);
    			
		}
		


} catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
  %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Waybill</title>
    <style>
       body {
    font-family: 'Poppins', sans-serif;
    margin: 20px;
    background: linear-gradient(to right, #f8f9fa, #e9ecef);
}

.waybill-container {
    padding: 20px;
    max-width: 90%;
    margin: auto;
    background-color: #ffffff;
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2);
    border-radius: 10px;
}

.header {
    background: linear-gradient(to right, #007bff, #0056b3);
    padding: 20px;
    border-radius: 10px 10px 0 0;
    color: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
}

.header img {
    max-width: 80px;
}

.content {
    text-align: right;
    font-size: 1rem;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table th {
    background-color: #007bff;
    color: white;
    padding: 12px;
}

table td {
    padding: 10px;
    border: 1px solid #ccc;
}

/* Buttons */
button {
    padding: 12px 24px;
    border-radius: 5px;
    transition: 0.3s;
    font-size: 1rem;
}

.accept {
    background-color: #28a745;
    color: white;
}

.accept:hover {
    background-color: #218838;
}

.reject {
    background-color: #dc3545;
    color: white;
}

.reject:hover {
    background-color: #c82333;
}

/* Responsive Design */
@media screen and (max-width: 768px) {
    .waybill-container {
        max-width: 100%;
        padding: 10px;
    }

    .header {
        flex-direction: column;
        text-align: center;
    }

    .content {
        text-align: center;
        margin-top: 10px;
    }

    table th, table td {
        font-size: 0.9rem;
        padding: 8px;
    }

    button {
        width: 100%;
        font-size: 1rem;
    }
}
/* Accepted and Rejected Text */
.status-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 5rem;
    font-weight: bold;
    opacity: 0.2; /* Low opacity */
    display: none;
}

.accepted {
    color: green;
}

.rejected {
    color: red;
}
    </style>
</head>
<body>
    <div class="waybill-container">
        <div class="header">
            <img src="logo.png" alt="Company Logo">
          	
          <h2>   ${company_name}</h2>
          <div class="content">
            
            <p>Order ID: <strong>#ORD ${requestID}</strong></p>
            <p>Date of Issue: <strong> ${issue_date}</strong></p>
            </div>
        </div>
        
        <div class="section">
            <h3>Shipped by</h3>
            <p>Name:  ${s_name}</p>
            <p>Address:  ${s_address}</p>
            <p>Contact:  ${s_phone}</p>
            <p>Email:  ${s_email}</p>
        </div>
        
        <div class="section">
            <h3>Delivery to</h3>
            <p>Name:  ${d_name}</p>
            <p>Address: ${d_address}</p>
            <p>Contact:  ${d_contact}</p>
            <p>Email:  ${d_email}</p>
        </div>
        
        <div class="section">
            <h3>Transportation Details</h3>
            <p>Carrier: Fast Logistics</p>
            <p>Vehicle : TRUCK</p>
            <p>Mode of Transport: Road</p>
            <p>Dispatch Date: ${issue_date} | Estimated Delivery:  ${e_date}</p>
        </div>
        
        <div class="section">
            <h3>Shipment Details</h3>
            <table>
                <tr>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>Weight</th>
                    <th>Value</th>
                    <th>Handling</th>
                </tr>
                <tr>
                    <td> ${p_name}</td>
                    <td> ${qty}</td>
                    <td> ${weight}</td>
                    <td> ${price}</td>
                    <td>Fragile</td>
                </tr>
            </table>
        </div>
        
        <div class="section">
            <h3>Payment Details</h3>
            <p>Freight Charges: 500</p>
            <p>Payment Terms: </p>
            <p>Taxes & Additional Charges: $50</p>
            <p>  Total Price  :<strong> ${tprice}</strong></p>
        </div>
        
        
        <div class="section">
            <h3>Notes and Terms</h3>
           <p>Delivery time constraints apply. Terms and conditions of transport available upon request.</p> <ol>
        <li>This Sea Waybill is issued for a contract of Carriage which is not covered by a Bill of Lading or similar document or title. </li>
        <li>A signed Sea Waybill is returned to the shipper and a copy of it is applied as an input source document to a computerized system for data transmission of particulars as described on page 2 hereof to the country of destination. Upon receipt of
          the data so transmitted, Carrier or its agent in the country of destination will forward such data to the consignee and notify party. </li>
        <li> Carrier shall not be liable for any loss or damage or delay to or in connection with the Goods or any consequential or indirect damage to Merchant arising unintentionally from erroneous input into the computer system or from wrongful data transmission.
          </li>
        <li> This contract of Carriage shall be subject to German law which would have been compulso- rily applicable if a Bill of Lading rather than a Sea Waybill had been issued. </li>
        <li> The terms and conditions of Carrier’s applicable tariff are incorporated herein, including but not limited to the terms and conditions relating to demurrage and detention. The provisions relevant to the applicable tariff can be acquired from Carrier
          or its agents upon request. Car- rier’s standard tariff can be accessed online at www.hapag-lloyd.com. In the case of any inconsistency between this Sea Waybill and the applicable tariff, this Sea Waybill shall prevail. </li>
        <li> Carrier shall not be liable for any loss or damage or delay to or in connection with the Goods or any consequential or indirect damage to Merchant arising unintentionally from erroneous input into the computer system or from wrongful data transmission.
          </li>
        <li> This contract of Carriage shall be subject to German law which would have been compulso- rily applicable if a Bill of Lading rather than a Sea Waybill had been issued. </li>
        <li> The terms and conditions of Carrier’s applicable tariff are incorporated herein, including but not limited to the terms and conditions relating to demurrage and detention. The provisions relevant to the applicable tariff can be acquired from Carrier
          or its agents upon request. Car- rier’s standard tariff can be accessed online at www.hapag-lloyd.com. In the case of any inconsistency between this Sea Waybill and the applicable tariff, this Sea Waybill shall prevail. </li>
      </ol>
        </div>
        
        <div class="buttons">
           <a href="OrderPlacing.jsp?delivery_request_id=${requestID}&company_name=${company_name}&weight=${weight}">
    <button class="accept" onclick="acceptWaybill()">Proceed</button>
</a>

            <button class="reject">Reject</button>
          <div id="statusText" class="status-text"></div>
    </div>
        </div>
    </div>
   <script>
  <%-- function acceptWaybill() {
	    document.querySelector('.buttons').style.display = 'none';
	    let statusText = document.getElementById('statusText');
	    statusText.innerText = 'ACCEPTED';
	    statusText.className = 'status-text accepted';
	    statusText.style.display = 'block';
	}
--%>
	document.querySelector('.reject').addEventListener('click', function() {
	    document.querySelector('.buttons').style.display = 'none';
	    let statusText = document.getElementById('statusText');
	    statusText.innerText = 'REJECTED';
	    statusText.className = 'status-text rejected';
	    statusText.style.display = 'block';
	});

    </script>
</body>

</html>
