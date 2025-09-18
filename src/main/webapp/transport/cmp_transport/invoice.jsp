<%
    String requestIDString = request.getParameter("shipment_id");

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
        
		String sql = "SELECT t.transport_name, c.customer_name, c.customer_address, dr.buyer_name,  dr.delivery_address, dr.buyer_email, dr.product_name, dr.quantity,  dr.price, dr.request_date, iv.invoice_id, iv.amount, iv.transaction_id, iv.tr_date_time, iv.mode_of_payment FROM transport.shipment s JOIN transport.transport t ON s.transport_id = t.transport_id JOIN transport.delivery_request dr ON s.delivery_request_id = dr.delivery_request_id JOIN transport.customer c ON dr.customer_id = c.customer_id JOIN transport.invoices iv  ON s.shipment_id = iv.shipment_id WHERE s.shipment_id = ?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String company_name = rs.getString("transport_name");
    		 String c_name = rs.getString("customer_name");
    		 String c_address = rs.getString("customer_address");
    		 String d_name = rs.getString("buyer_name");
    		 String d_address = rs.getString("delivery_address");
    		 String d_email = rs.getString("buyer_email");
    		 String p_name = rs.getString("product_name");
    		 int qty = rs.getInt("quantity");
    		 int price = rs.getInt("price");
    		 String o_date = rs.getString("request_date");
    		 int invoice_id = rs.getInt("invoice_id");
    		 int amt = rs.getInt("amount");
    		 String tr_id = rs.getString("transaction_id");
    		 String tr_date = rs.getString("tr_date_time");
    		 String m_payment = rs.getString("mode_of_payment");
    		 
   			
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("company_name", company_name);
    		 request.setAttribute("c_name", c_name);
    		 request.setAttribute("c_address", c_address);
    		 request.setAttribute("d_name", d_name);
    		 request.setAttribute("d_address", d_address);
    		 request.setAttribute("d_email", d_email);
    		 request.setAttribute("p_name", p_name);
    		 
    		 request.setAttribute("qty", qty);
    		 request.setAttribute("price", price);
    		 request.setAttribute("o_date", o_date);
    		 request.setAttribute("invoice_id", invoice_id);
    		 request.setAttribute("amt", amt);
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
    <title>Invoice</title>
    <style>
        body {
    font-family: 'Poppins', sans-serif;
    background-color: #f4f7fc;
    margin: 0;
    padding: 20px;
    color: #333;
}

.container {
    max-width: 900px;
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

.date-time {
    text-align: right;
    font-size: 14px;
    color: #666;
}

.invoice-info {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 20px;
}

.invoice-details {
    width: 48%;
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

.amount-in-words {
    margin-top: 20px;
    font-style: italic;
    color: #666;
}

.payment-details {
    margin-top: 20px;
}

.btn {
    background-color: #004d99; /* Professional Blue */
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
    </style>
</head>
<body>

    <div class="container">
        <header>
            <div class="logo">
                <img src="your_logo.png" alt="Company Logo"> 
                <h2>${company_name}</h2>
            </div>
            <div class="date-time">
                <p><strong>Date: </strong><span id="currentDate"></span></p>
                <p><strong>Time:</strong> <span id="currentTime"></span></p>
            </div>
        </header>

        <div class="invoice-info">
            <div class="invoice-details">
                <p><strong>Sold By: </strong></p>
                <p>${c_name} <br> ${c_address}</p><br><br><br><br>
                <p><strong>PAN NO: </strong> </p>
                <p><strong>GST Registration No:</strong> </p><br><br>
                <p><strong>Order No: </strong><span id="orderNo">#ORD ${requestID}</span></p> 
                <p><strong>Order Date:</strong> <span id="orderDate">${o_date}</span></p> 
            </div>
            <div class="invoice-details">
                <p><strong>Billing Address:</strong></p>
                <p>${d_name}<br>${d_address}<br>${d_email}</p>
                <p><strong>State/UT Code: </strong></p><br><br>
                <p><strong>Shipping Address:</strong></p>
                <p>${d_address}</p>
                <p><strong>State/UT Code: </strong></p>
                <p><strong>Place of Supply:</strong>${c_address}</p>
                <p><strong>Place of Delivery: </strong>${d_address}</p>
                <p><strong>INVOICE NO:</strong> <span id="invoiceNo">#INV-2025-${invoice_id}</span></p> 
                <p><strong>Invoice Date:</strong><span id="invoiceDate"></span> </p> 
                
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Sl.No</th>
                    <th>Description</th>
                   
                    <th>Quantity</th>
                    <th>Net Amount</th>
                    <th>Tax Rate</th>
                    <th>Tax Type</th>
                    <th>Tax Amount</th>
                    <th>Total Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>${p_name}</td>
                    
                    <td>${qty}</td>
                    <td>${price}</td>
                    
                    <td>18%</td>
                    <td>GST</td>
                    <td>00.0</td>
                    <td>${amt}</td>
                </tr>
               
                <tr>
                    <td colspan="6"></td>
                    <td><strong>Total:</strong></td>
                    <td><strong><span id="totalAmount">${amt}</span>
                    </strong></td> 
                </tr>
            </tbody>
        </table>

       <div class="amount-in-words">
   			 <p>Amount in Words: <span id="amountInWords"></span></p>
		</div>

        <div>
            <p>For Vouge Street:</p>
            <p>Signature</p>
        </div>

        <div class="payment-details">
            <h2>Payment Details</h2>
            <table>
                <thead>
                    <tr>
                        <th>Payment Transaction Id</th>
                        <th>Date & Time</th>
                        <th>Invoice Value</th>
                        <th>Mode of Payment</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${tr_id}</td>
                        <td>${tr_date}</td>
                        <td>${amt}</td>
                        <td>${m_payment}</td>
                    </tr>
                </tbody>
            </table>
        </div>
 <button id="downloadBtn" class="btn">Download PDF</button> 

    </div>

    <script>
        const currentDate = new Date().toLocaleDateString();
        const currentTime = new Date().toLocaleTimeString();
		const invoiceDate = new Date().toLocaleTimeString();
        document.getElementById('currentDate').textContent = currentDate;
        document.getElementById('currentTime').textContent = currentTime;
        document.getElementById('invoiceDate').textContent = invoiceDate;

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
        
        
        function convertToWords(num) {
            const ones = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"];
            const teens = ["Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
            const tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
            const thousands = ["", "Thousand", "Million", "Billion"];

            if (num === 0) return "Zero";

            let word = "";
            let i = 0;

            while (num > 0) {
                let part = num % 1000;
                if (part !== 0) {
                    let str = "";
                    if (part % 100 < 20 && part % 100 > 10) {
                        str = teens[(part % 100) - 11] + " ";
                    } else {
                        str = tens[Math.floor((part % 100) / 10)] + " " + ones[part % 10] + " ";
                    }
                    if (Math.floor(part / 100) > 0) {
                        str = ones[Math.floor(part / 100)] + " Hundred " + str;
                    }
                    word = str + thousands[i] + " " + word;
                }
                num = Math.floor(num / 1000);
                i++;
            }

            return word.trim() + " Rupees Only";
        }

        // Convert total amount dynamically
        document.addEventListener("DOMContentLoaded", function () {
    let totalAmountElement = document.getElementById("totalAmount");
    let amountInWordsElement = document.getElementById("amountInWords");

    if (totalAmountElement && amountInWordsElement) {
        let totalAmount = parseInt(totalAmountElement.textContent.trim());
        amountInWordsElement.textContent = convertToWords(totalAmount);
    } else {
        console.error("Error: Could not find totalAmount or amountInWords element.");
    }
});
    </script>
</body>
</html>