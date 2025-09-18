<%
String requestIDString = request.getParameter("invoiceid");

// Convert string to integer (handle potential errors)
int requestID = 0; // Default value in case of an exception
try {
   requestID = Integer.parseInt(requestIDString);
    //request.setAttribute("requestID", requestID);

} catch (NumberFormatException e) {
   
}

session.setAttribute("requestID", requestID);
session.setMaxInactiveInterval(5 * 60); // 5 minutes timeout
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Select Payment Method</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: #f4f7fa;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 480px;
      margin: 80px auto;
      background: white;
      padding: 40px 30px;
      border-radius: 16px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
    }

    h2 {
      text-align: center;
      color: #333;
      font-weight: 600;
      margin-bottom: 25px;
    }

    .form-group {
      margin-bottom: 25px;
    }

    label {
      font-size: 15px;
      font-weight: 500;
      color: #444;
      margin-bottom: 10px;
      display: block;
    }

    select {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      border-radius: 10px;
      border: 1px solid #ccc;
      background-color: #f9f9f9;
      color: #333;
      transition: border-color 0.3s;
    }

    select:focus {
      border-color: #4CAF50;
      outline: none;
      background-color: #fff;
    }

    button {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      font-weight: bold;
      color: white;
      background-color: #4CAF50;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    button:hover {
      background-color: #45a049;
      transform: translateY(-1px);
    }

    option {
      padding: 10px;
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>Choose Your Payment Method</h2>
    <form id="paymentMethodForm">
      <div class="form-group">
        <label for="paymentMethod">Select Method</label>
        <select id="paymentMethod" required>
          <option value="" disabled selected>Please select</option>
          <option value="bank"> Bank Transfer (ACH)</option>
          <option value="card"> Credit/Debit Card</option>
          <option value="paypal"> PayPal</option>
        </select>
      </div>
      <button type="button" onclick="selectPaymentMethod()">Proceed</button>
    </form>
  </div>

  <script>
    function selectPaymentMethod() {
      const paymentMethod = document.getElementById("paymentMethod").value;

      if (!paymentMethod) {
        alert("⚠️ Please select a payment method.");
        return;
      }

      switch (paymentMethod) {
        case "card":
          window.location.href = "credit-card-details.jsp";
          break;
        case "bank":
          window.location.href = "bank-transfer-details.jsp";
          break;
        case "paypal":
          window.location.href = "paypal-redirect.jsp";
          break;
        default:
          alert("Invalid payment method.");
      }
    }
  </script>

</body>
</html>
