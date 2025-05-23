<%@ page import="model.Payment" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="utils.handlePayment" %>

<%
    handlePayment loadPayments = new handlePayment();
    loadPayments.loadFromFile();

    LinkedList<Payment> payments = loadPayments.getPayments();
    LinkedList<Payment> paymentsHistory = new LinkedList<>();

    String vehicleNumber = request.getParameter("vehicleNumber");
    if (vehicleNumber != null && !vehicleNumber.isEmpty()) {
        for (Payment payment : payments) {
            if (payment.getVehicleNumber().equals(vehicleNumber)) {
                paymentsHistory.add(payment);
            }
        }
    }
%>

<html>
<head>
    <title>Billing History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"] {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 8px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-history {
            color: #7f8c8d;
            font-style: italic;
        }
        .back-link {
            display: inline-block;
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
<h1>Billing History</h1>
<form action="billingHistory.jsp" method="get">
    <label for="vehicleNumber">Vehicle Number:</label>
    <input type="text" id="vehicleNumber" name="vehicleNumber" value="<%= vehicleNumber != null ? vehicleNumber : "" %>" required>
    <input type="submit" value="View">
</form>

<% if (vehicleNumber != null && !vehicleNumber.isEmpty()) { %>
<% if (paymentsHistory.isEmpty()) { %>
<p class="no-history">No payment history found for vehicle <%= vehicleNumber %></p>
<% } else { %>
<h2>Payment History for <%= vehicleNumber %></h2>
<table>
    <thead>
    <tr>
        <th>Payment ID</th>
        <th>Type</th>
        <th>Amount</th>
        <th>Status</th>
        <th>Timestamp</th>
    </tr>
    </thead>
    <tbody>
    <% for (Payment payment : paymentsHistory) { %>
    <tr>
        <td><%= payment.getId() %></td>
        <td><%= payment.getPaymentType()%></td>
        <td>Rs. <%= String.format("%.2f", payment.getAmount()) %></td>
        <td><%= payment.getStatus() %></td>
        <td><%= payment.getTimestamp() %></td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>
<% } %>

<a href="PaymentDashboard.jsp" class="back-link">Back to Main</a>
</body>
</html>