<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session Expired</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .box {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #e74c3c;
            font-size: 28px;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            color: #555;
        }

        a.button {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 24px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        a.button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="box">
    <h1>Session Expired</h1>
    <p>Your session has timed out due to inactivity or invalid access.</p>
    <a href="select-payment.jsp" class="button">Select Payment Again</a>
</div>
</body>
</html>
