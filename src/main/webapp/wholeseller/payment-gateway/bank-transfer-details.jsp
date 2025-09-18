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
        
		String sql = "SELECT w.bank_name, w.account_no, w.ifsc_code  FROM wholeseller.wholeseller w JOIN wholeseller.	invoice iv ON iv.wholeseller_id = w.wholeseller_id WHERE iv.invoice_id = ? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, requestID);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
    		 String Bankname = rs.getString("bank_name");
    		 String accountNo = rs.getString("account_no");
    		 String IFSC = rs.getString("ifsc_code");
    		 
   		 // Fetch and display other details as needed
   		 
    		 request.setAttribute("requestID", requestID);
    		 request.setAttribute("Bankname", Bankname);
    		 request.setAttribute("accountNo", accountNo);
    		 request.setAttribute("IFSC", IFSC);
    		
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
  <title>Bank Transfer</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f4f7fa;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 600px;
      margin: 60px auto;
      background: #fff;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #333;
      font-weight: 600;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      font-size: 15px;
      font-weight: 500;
      color: #555;
      display: block;
      margin-bottom: 6px;
    }

    input {
      width: 100%;
      padding: 14px;
      font-size: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #f9f9f9;
      transition: border-color 0.3s ease;
    }

    input:focus {
      border-color: #4CAF50;
      outline: none;
      background: #fff;
    }

    button {
      width: 100%;
      padding: 14px;
      background-color: #4CAF50;
      color: white;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin-top: 10px;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>Bank Transfer Details</h2>
   <form id="bankTransferForm">
  <div class="form-group">
    <label for="bankName">Bank Name</label>
    <input type="text" id="bankName" value="${Bankname}" readonly />
  </div>

  <div class="form-group">
    <label for="ifscCode">IFSC Code</label>
    <input type="text" id="ifscCode" value="${IFSC}" readonly />
  </div>

  <div class="form-group">
    <label for="accountNumber">Account Number</label>
    <input type="text" id="accountNumber" placeholder="Enter account number" required  maxlength="14" pattern="\d{14}" title="Account number must be exactly 14 digits" />
  </div>

  <!-- Hidden field with the original account number from DB -->
  <input type="hidden" id="originalAccountNumber" value="${accountNo}" />

  <button type="button" onclick="submitBankTransfer()">Submit Payment</button>
</form>

  </div>

  <script>
  function submitBankTransfer() {
	  const bankName = document.getElementById('bankName').value.trim();
	  const ifscCode = document.getElementById('ifscCode').value.trim();
	  const enteredAccountNumber = document.getElementById('accountNumber').value.trim();
	  const originalAccountNumber = document.getElementById('originalAccountNumber').value.trim();

	  if (!bankName || !ifscCode || !enteredAccountNumber) {
	    alert("Please complete all fields.");
	    return;
	  }

	  if (enteredAccountNumber !== originalAccountNumber) {
	    alert("Entered account number does not match the expected account number.");
	    return;
	  }

	  alert("Bank details submitted successfully!");
	  window.location.href = "payment-pin-entry.jsp";
	}

  </script>

</body>
</html>
