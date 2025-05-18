<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.parking.model.User" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>User Registrations - Parking Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="card">
        <h2 class="mb-4">Registered Users</h2>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Vehicle Name</th>
                <th>Vehicle Number</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null) {
                    for (User u : users) {
            %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getUsername() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getPhoneNumber() %></td>
                <td><%= u.getVehicleName() %></td>
                <td><%= u.getVehicleNumber() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
        <a href="index.jsp" class="btn btn-secondary w-100 mt-3">Back to Home</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>