<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>Make Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }
        .payment-form {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #3498db;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<h1>Make Payment</h1>

<div class="payment-form">
    <form action="payment" method="post">
        <div class="form-group">
            <label for="vehicleNumber">Vehicle Number:</label>
            <input type="text" id="vehicleNumber" name="vehicleNumber" required
                   pattern="[A-Za-z0-9]+" title="Alphanumeric characters only">
        </div>

        <div class="form-group">
            <label for="amount">Amount (Rs. ):</label>
            <input type="number" id="amount" name="amount" step="0.01" min="0.01" required>
        </div>

        <div class="form-group">
            <label for="paymentType">Payment Type:</label>
            <select id="paymentType" name="paymentType">
                <option value="online">Online Payment</option>
                <option value="cash">Cash Payment</option>
            </select>
        </div>

        <input type="hidden" name="timestamp" value="<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) %>">

        <input type="submit" value="Process Payment">
    </form>
</div>

<% if (request.getAttribute("message") != null) { %>
<div class="message <%= request.getAttribute("messageType") != null ? request.getAttribute("messageType") : "" %>">
    <%= request.getAttribute("message") %>
</div>
<% } %>

<a href="index.jsp" class="back-link">Back to Home</a>
</body>
</html>