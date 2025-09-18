<%
  Integer requestID = (Integer) session.getAttribute("requestID");
  if (requestID == null) {
    // Handle session timeout or invalid access
    response.sendRedirect("session-expired.jsp");
    return;
  }
%>
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%
try (Connection conn = PostgresConnection.getConnection()) {
        
		String sql = "SELECT w.shop_name, w.bank_name, w.account_no, tr.transport_name, tr.bank, iv.amount FROM wholeseller.wholeseller w JOIN wholeseller.invoice iv ON iv.wholeseller_id = w.wholeseller_id JOIN transport.transport tr ON iv.transport_id = tr.transport_id WHERE iv.invoice_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			String Shopname = rs.getString("shop_name"); 
			String Bankname = rs.getString("bank_name");
    		 String accountNo = rs.getString("account_no");
    		 String tname = rs.getString("transport_name");
    		 String Bank = rs.getString("bank");
    		 String amount = rs.getString("amount");
    		 
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("Bankname", Bankname);
    		 request.setAttribute("accountNo", accountNo);
    		 request.setAttribute("Shopname", Shopname);
    		 request.setAttribute("tname", tname);
    		 request.setAttribute("Bank", Bank);
    		 request.setAttribute("amount", amount);
		}
		


} catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
  %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Secure Payment</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f0f2f5;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 450px;
      margin: 60px auto;
      background: #ffffff;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      animation: fadeIn 0.4s ease;
    }

    h2 {
      color: #333;
      font-weight: 600;
      margin-bottom: 15px;
      text-align: center;
    }

    .amount {
      font-size: 32px;
      font-weight: bold;
      color: #2ecc71;
      margin: 10px 0;
      text-align: center;
    }

    .bank {
      font-size: 16px;
      color: #666;
      text-align: center;
      margin-bottom: 30px;
    }

    .pin-inputs {
      display: flex;
      justify-content: center;
      gap: 12px;
      margin-bottom: 20px;
    }

    .pin-inputs input {
      width: 50px;
      height: 50px;
      font-size: 28px;
      text-align: center;
      border: 1px solid #ccc;
      border-radius: 8px;
      background-color: #f1f1f1;
      -webkit-text-security: disc;
    }

    .pin-inputs input:focus {
      border-color: #2ecc71;
      background: #fff;
      outline: none;
    }

    button {
      width: 100%;
      padding: 14px;
      background-color: #2ecc71;
      color: white;
      border: none;
      font-size: 16px;
      font-weight: bold;
      border-radius: 8px;
      cursor: pointer;
      margin-top: 10px;
      transition: background 0.3s ease;
    }

    button:hover {
      background-color: #27ae60;
    }

    .success-box {
      display: none;
      text-align: center;
      animation: fadeIn 0.5s ease-in-out;
    }

    .checkmark {
      font-size: 64px;
      color: #2ecc71;
      animation: pop 0.3s ease-out;
      margin-bottom: 10px;
    }

    .success-text {
      font-size: 22px;
      font-weight: 600;
      color: #333;
      margin-bottom: 8px;
    }

    .paid-amount {
      font-size: 26px;
      color: #2ecc71;
      font-weight: bold;
      margin-bottom: 12px;
    }

    .receipt {
      text-align: left;
      margin-top: 25px;
      font-size: 15px;
      color: #444;
      background: #f9f9f9;
      padding: 20px;
      border-radius: 12px;
    }

    .receipt strong {
      color: #222;
    }

    .receipt div {
      margin-bottom: 10px;
    }

    @keyframes pop {
      0% { transform: scale(0); opacity: 0; }
      100% { transform: scale(1); opacity: 1; }
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 480px) {
      .pin-inputs input {
        width: 40px;
        height: 45px;
      }
    }
  </style>
</head>
<body>

  <div class="container" id="paymentBox">
    <h2>Confirm Payment</h2>
    <div class="amount">Rs ${amount}</div>
    <div class="bank">${Bankname}</div>

    <div class="pin-inputs">
      <input type="password" maxlength="1" oninput="moveToNext(this, 0)" id="pin1" />
      <input type="password" maxlength="1" oninput="moveToNext(this, 1)" id="pin2" />
      <input type="password" maxlength="1" oninput="moveToNext(this, 2)" id="pin3" />
      <input type="password" maxlength="1" oninput="moveToNext(this, 3)" id="pin4" />
    </div>

    <button onclick="submitPIN()">Pay</button>
  </div>
<form method="post" action="/Supply-chain-and-Logistic/PayGatewayServlet" id="paymentForm">
  <input type="hidden" name="txnId" id="txnIdField">
  <input type="hidden" name="txnDateTime" id="txnDateTimeField">
  <input type="hidden" name="requestID" value="<%= request.getAttribute("requestID") %>">
  
  <div class="container success-box" id="successBox">
    <!-- Your success screen content -->
  </div>
</form>

  <div class="container success-box" id="successBox">
    <div class="checkmark">Completed</div>
    <div class="success-text">Payment Successful</div>
   <div class="paid-amount" id="paidAmount"></div>
    <div id="dateTime" style="color: #666; font-size: 15px; margin-bottom: 20px;"></div>
  
    <div class="receipt" id="transactionDetails">
      <!-- Auto-filled via JS -->
    </div>
  </div>
  
  

  <audio id="successSound" src="https://assets.mixkit.co/sfx/download/mixkit-positive-interface-beep-221.wav" preload="auto"></audio>
<script>
const Shopname = `<%= request.getAttribute("Shopname") %>`;
const Bankname = `<%= request.getAttribute("Bankname") %>`;
const accountNo = `<%= request.getAttribute("accountNo") %>`;
const tname = `<%= request.getAttribute("tname") %>`;
const Bank = `<%= request.getAttribute("Bank") %>`;
const amount = `<%= request.getAttribute("amount") %>`;
  
  function submitPIN() {
	  const pin = Array.from(document.querySelectorAll('.pin-inputs input'))
	    .map(input => input.value)
	    .join('');

	  if (pin.length !== 4 || isNaN(pin)) {
	    alert("Please enter a valid 4-digit PIN.");
	    return;
	  }

	  document.querySelector("button").disabled = true;
	  document.querySelector("button").innerText = "Processing...";

	  setTimeout(() => {
	    document.getElementById("paymentBox").style.display = "none";
	    document.getElementById("successBox").style.display = "block";

	    const txnId = "TXN" + Math.floor(Math.random() * 1000000000);
	    console.log("Generated Transaction ID:", txnId);

	    const now = new Date();
	    const dateTime = now.toLocaleString();

	    // Set values in hidden fields
	    document.getElementById("txnIdField").value = txnId;
	    document.getElementById("txnDateTimeField").value = dateTime;

	    // Update UI
	    document.getElementById("paidAmount").innerText = `Rs. ${amount}`;
	    document.getElementById("dateTime").innerText = dateTime;
	    
	    const html = '<div><strong>Transaction ID:</strong><br> ' + txnId + '</div>' +
	    '<div><strong>FROM:</strong><br>' +
	    Shopname + '<br>' +
	    Bankname + '<br>' +
	    'Account No: ' + accountNo + '</div>' +
	    '<div><strong>TO:</strong><br>' +
	    tname + '<br>' + Bank + '</div>';

	  document.getElementById("transactionDetails").innerHTML = html;

	    document.getElementById("successSound").play();
	    
	 // Submit form to servlet
	    document.getElementById("paymentForm").submit();
	  }, 1500);
	}

</script>


</body>
</html>
