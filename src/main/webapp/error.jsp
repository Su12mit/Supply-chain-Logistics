<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <style>
        /* Global Styles */
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f7a7b7, #c7f0d7); /* Modern gradient */
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            text-align: center;
        }

        /* Title Text */
        h1 {
            font-size: 3.5em;
            color: #ee4b4b;
            margin-bottom: 20px;
            animation: fadeIn 1.5s ease-in-out;
        }

        /* Animation for text fade-in */
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        /* Cartoon character animation */
        .cartoon-character {
            width: 120px;
            height: 120px;
            background: url('https://i.imgur.com/7gM1KrT.png') no-repeat center center;
            background-size: contain;
            margin: 30px;
            animation: float 2s ease-in-out infinite;
        }

        /* Float animation for the character */
        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-30px); }
            100% { transform: translateY(0); }
        }

        /* Error Message Styling */
        .message {
            font-size: 1.6em;
            color: #4b4b4b;
            margin-top: 20px;
            animation: slideIn 1s ease-in-out;
        }

        /* Slide-in animation for the message */
        @keyframes slideIn {
            0% { transform: translateX(-30px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        /* Optional error details */
        .error-details {
            font-size: 1.2em;
            color: #333;
            margin-top: 15px;
        }

        /* Button to go back or refresh */
        .btn {
            margin-top: 30px;
            padding: 15px 25px;
            font-size: 1.2em;
            background-color: #ee4b4b;
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #d73838;
        }
    </style>
</head>
<body>
    <h1>Oops! Something went wrong.</h1>

    <!-- Cartoon character with floating animation -->
    <div class="cartoon-character"></div>

    <div class="message">
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error occurred. Please try again later." %>
    </div>

    <!-- Optional error details -->
    <div class="error-details">
        Please try again later or contact support.
    </div>

    <!-- Go back button -->
    <button class="btn" onclick="window.location.href='/'">Go to Home</button>
</body>
</html>
