<%@ page import="model.Payment" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="utils.handlePayment" %>

<%
    handlePayment paymentHandler = new handlePayment();
    paymentHandler.loadFromFile();
    LinkedList<Payment> payments = paymentHandler.getPayments();
%>

<html>
<head>
    <title>Admin Billing Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
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
        .status-select {
            padding: 5px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        button {
            padding: 5px 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
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
        .no-records {
            color: #7f8c8d;
            font-style: italic;
        }
    </style>
</head>
<body>
<h1>Admin Billing Management</h1>

<% if (payments != null && !payments.isEmpty()) { %>
<table>
    <thead>
    <tr>
        <th>Payment ID</th>
        <th>Vehicle Number</th>
        <th>Type</th>
        <th>Amount</th>
        <th>Status</th>
        <th>Timestamp</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Payment payment : payments) { %>
    <tr>
        <td><%= payment.getId() %></td>
        <td><%= payment.getVehicleNumber() %></td>
        <td><%= payment.getPaymentType()%></td>
        <td>Rs. <%= String.format("%.2f", payment.getAmount()) %></td>
        <td>
            <form class="action-form" method="post" action="AdminPaymentServlet">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="paymentId" value="<%= payment.getId() %>">
                <select class="status-select" name="status">
                    <option value="PENDING" <%= "PENDING".equals(payment.getStatus()) ? "selected" : "" %>>PENDING</option>
                    <option value="PAID" <%= "PAID".equals(payment.getStatus()) ? "selected" : "" %>>PAID</option>
                    <option value="FAILED" <%= "FAILED".equals(payment.getStatus()) ? "selected" : "" %>>FAILED</option>
                    <option value="REFUNDED" <%= "REFUNDED".equals(payment.getStatus()) ? "selected" : "" %>>REFUNDED</option>
                </select>
                <button type="submit">Update</button>
            </form>
        </td>
        <td><%= payment.getTimestamp() %></td>
        <td>
            <form class="action-form" method="post" action="AdminPaymentServlet">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="paymentId" value="<%= payment.getId() %>">
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } else { %>
<p class="no-records">No billing records found.</p>
<% } %>

<a href="PaymentDashboard.jsp" class="back-link">Back to Main</a>
</body>
</html>