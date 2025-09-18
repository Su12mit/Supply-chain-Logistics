<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Supply Chain Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            width: 400px;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #1d4ed8;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        select, input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        select:focus, input:focus {
            outline: none;
            border: 1px solid #1d4ed8;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #1d4ed8;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #123a8f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Supply Chain Login</h2>
        <form method="post" action="SupplyChainLoginServlet">
            <div class="form-group">
                <label for="userType">Login Type</label>
                <select id="userType" name="userType" required>
                <option value="#">Select</option>
                    <option value="supplier">Supplier</option>
                    <option value="manufacturer">Manufacturer</option>
                    <option value="warehouse">Warehouse</option>
                    <option value="transport">Transport</option>
                    <option value="wholeseller">Wholeseller</option>
                    <option value="retailer">Retailer</option>
                </select>
            </div>
            <div class="form-group">
                <label for="username">Username/Email</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required minlength="6">
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
    </div>
</body>
<script>
  // Push a dummy state on page load
  history.pushState(null, null, location.href);
  
  // Block both forward and back navigation
  window.addEventListener('popstate', function () {
    history.pushState(null, null, location.href);
  });
</script>


</html>