<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Retailer Sign Up</title>
  <style>
    body {
      background: linear-gradient(to bottom right, #f8f9fa, #dee2e6);
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
    }

    .container {
      background-color: #fff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      width: 100%;
      position: relative;
      transition: all 0.3s ease;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #343a40;
    }

    .section {
      display: none;
      animation: fade 0.5s ease;
    }

    .section.active {
      display: block;
    }

    @keyframes fade {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      font-weight: 500;
      margin-bottom: 5px;
      color: #495057;
    }

    input, select, textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ced4da;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 15px;
    }

    textarea {
      height: 90px;
      resize: vertical;
    }

    .btn, .next-btn, .prev-btn {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 24px;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .btn:hover, .next-btn:hover, .prev-btn:hover {
      background-color: #0056b3;
    }

    .button-group {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }

    .progress {
      height: 6px;
      background: #e9ecef;
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 25px;
    }

    .progress-bar {
      height: 100%;
      background-color: #007bff;
      transition: width 0.4s ease;
    }

    small {
      color: #6c757d;
    }

    @media (max-width: 600px) {
      .container {
        padding: 20px;
      }

      .button-group {
        flex-direction: column;
        gap: 10px;
      }
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>Retailer Sign Up</h2>
    <div class="progress">
      <div class="progress-bar" id="progressBar" style="width: 25%"></div>
    </div>

    <form id="signUpForm" action="/Supply-chain-and-Logistic/RTsignup" method="post">
      <div class="section active">
        <h3>Personal Information</h3>
        <div class="form-group">
          <label for="name">Full Name:</label>
          <input type="text" id="name" name="name" required />
        </div>
        <div class="form-group">
          <label for="dateOfBirth">Date of Birth:</label>
          <input type="date" id="dateOfBirth" name="dateOfBirth" required />
        </div>
        <div class="form-group">
          <label for="contactNo">Contact Number:</label>
          <input type="tel" id="contactNo" name="contactNo" required />
        </div>
        <div class="form-group">
          <label for="email">Email Address:</label>
          <input type="email" id="email" name="email" required />
        </div>
        <div class="form-group">
          <label for="profilePhoto">Profile Photo:</label>
          <input type="file" id="profilePhoto" name="profilePhoto" accept="image/*" />
        </div>
        <div class="form-group">
          <label for="address">Address:</label>
          <input type="text" id="address" name="address" required />
        </div>
        <div class="button-group">
          <button type="button" class="next-btn">Next</button>
        </div>
      </div>

      <div class="section">
        <h3>Business Information</h3>
        <div class="form-group">
          <label for="shopName">Shop Name:</label>
          <input type="text" id="shopName" name="shopName" required />
        </div>
        <div class="form-group">
          <label for="shopLogo">Shop Logo:</label>
          <input type="file" id="shopLogo" name="shopLogo" accept="image/*" />
        </div>
        <div class="form-group">
          <label for="shopNo">Shop No:</label>
          <input type="text" id="shopNo" name="shopNo" required />
        </div>
        <div class="form-group">
          <label for="businessLicenseNo">Business License No:</label>
          <input type="text" id="businessLicenseNo" name="businessLicenseNo" required />
        </div>
        <div class="form-group">
          <label for="gstNo">GST No:</label>
          <input type="text" id="gstNo" name="gstNo" required />
        </div>
        <div class="button-group">
          <button type="button" class="prev-btn">Previous</button>
          <button type="button" class="next-btn">Next</button>
        </div>
      </div>

      <div class="section">
        <h3>Bank Details</h3>
        <div class="form-group">
          <label for="bankName">Bank Name:</label>
          <input type="text" id="bankName" name="bankName" required />
        </div>
        <div class="form-group">
          <label for="accountNo">Account No:</label>
          <input type="text" id="accountNo" name="accountNo" required />
        </div>
        <div class="form-group">
          <label for="ifscCode">IFSC Code:</label>
          <input type="text" id="ifscCode" name="ifscCode" required />
        </div>
        <div class="button-group">
          <button type="button" class="prev-btn">Previous</button>
          <button type="button" class="next-btn">Next</button>
        </div>
      </div>

      <div class="section">
        <h3>Set a Password</h3>
        <div class="form-group">
          <label for="password">Password:</label>
          <input type="password" id="password" name="password" required />
          <small>(Must contain at least 6 characters, one symbol, and one alphabet)</small>
        </div>
        <div class="form-group">
          <label for="confirmPassword">Confirm Password:</label>
          <input type="password" id="confirmPassword" name="confirmPassword" required />
        </div>
        <div class="form-group">
          <input type="checkbox" id="termsAndConditions" required />
          <label for="termsAndConditions">I agree to the <a href="#">Terms and Conditions</a></label>
        </div>
        <div class="button-group">
          <button type="button" class="prev-btn">Previous</button>
          <button type="submit" class="btn">Sign Up</button>
        </div>
      </div>
    </form>
  </div>

  <script>
    const sections = document.querySelectorAll('.section');
    const nextBtns = document.querySelectorAll('.next-btn');
    const prevBtns = document.querySelectorAll('.prev-btn');
    const progressBar = document.getElementById('progressBar');

    let currentSection = 0;

    function showSection(index) {
      sections.forEach((section, i) => {
        section.classList.toggle('active', i === index);
      });
      progressBar.style.width = `${((index + 1) / sections.length) * 100}%`;
    }

    nextBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        if (currentSection < sections.length - 1) {
          currentSection++;
          showSection(currentSection);
        }
      });
    });

    prevBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        if (currentSection > 0) {
          currentSection--;
          showSection(currentSection);
        }
      });
    });

    document.getElementById('signUpForm').addEventListener('submit', function (e) {
    	  const password = document.getElementById('password').value;
    	  const confirm = document.getElementById('confirmPassword').value;

    	  if (password !== confirm) {
    	    e.preventDefault(); // ✅ Only prevent submission if validation fails
    	    alert('Passwords do not match!');
    	  }
    	});

  </script>
</body>
</html>
