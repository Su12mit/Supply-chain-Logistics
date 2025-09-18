
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Enter Credit Card Details</title>
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
      margin: 50px auto;
      background: white;
      padding: 40px;
      border-radius: 10px;
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
      font-size: 14px;
      font-weight: 600;
      color: #555;
      margin-bottom: 5px;
      display: block;
    }

    input {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 16px;
      background-color: #f9f9f9;
      transition: border-color 0.3s ease;
    }

    input:focus {
      outline: none;
      border-color: #4CAF50;
      background-color: #fff;
    }

    button {
      width: 100%;
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
      font-weight: bold;
      padding: 14px;
      font-size: 16px;
      border-radius: 8px;
      transition: background-color 0.3s ease;
      margin-top: 10px;
    }

    button:hover {
      background-color: #45a049;
    }

    .loader {
      display: none;
      margin-top: 20px;
      text-align: center;
    }

    .loader span {
      display: inline-block;
      width: 10px;
      height: 10px;
      margin: 0 3px;
      background-color: #4CAF50;
      border-radius: 50%;
      animation: bounce 0.6s infinite alternate;
    }

    .loader span:nth-child(2) { animation-delay: 0.2s; }
    .loader span:nth-child(3) { animation-delay: 0.4s; }

    @keyframes bounce {
      to { transform: translateY(-10px); }
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>Enter Credit Card Details</h2>
    <form id="creditCardForm" autocomplete="off">
      <div class="form-group">
        <label for="cardNumber">Card Number</label>
        <input type="text" id="cardNumber" placeholder="xxxx xxxx xxxx xxxx" maxlength="19" required />
      </div>

      <div class="form-group">
        <label for="expiryDate">Expiration Date</label>
        <input type="month" id="expiryDate" required />
      </div>

      <div class="form-group">
        <label for="cvv">CVV</label>
        <input type="text" id="cvv" placeholder="e.g. 123" maxlength="4" required />
      </div>

      <button type="button" onclick="submitCardDetails()">Submit Payment</button>
      <div class="loader" id="loader">
        <span></span><span></span><span></span>
      </div>
    </form>
  </div>

  <script>
    function formatCardNumber(value) {
      return value.replace(/\D/g, '').replace(/(.{4})/g, '$1 ').trim();
    }

    document.getElementById("cardNumber").addEventListener("input", function () {
      this.value = formatCardNumber(this.value);
    });

    function submitCardDetails() {
      const cardNumber = document.getElementById("cardNumber").value.replace(/\s+/g, '');
      const expiryDate = document.getElementById("expiryDate").value;
      const cvv = document.getElementById("cvv").value;
      const loader = document.getElementById("loader");

      if (!cardNumber || cardNumber.length < 13 || cardNumber.length > 19 || isNaN(cardNumber)) {
        alert("Please enter a valid card number.");
        return;
      }

      if (!expiryDate) {
        alert("Please select an expiration date.");
        return;
      }

      if (!cvv || cvv.length < 3 || isNaN(cvv)) {
        alert("Please enter a valid CVV.");
        return;
      }

      // Simulate loading state
      loader.style.display = 'block';

      // Simulate API call and redirect
      setTimeout(() => {
        loader.style.display = 'none';
        alert("Credit Card detailes Submited successfully!");
        window.location.href = "payment-pin-entry.jsp";
      }, 2000);
    }
  </script>

</body>
</html>
