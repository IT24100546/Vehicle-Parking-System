<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - Parking Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="card">
        <h2 class="mb-4">Register</h2>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= request.getAttribute("error") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>
        <form id="registerForm" action="register" method="post" onsubmit="return validateForm('registerForm')">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
                <div class="invalid-feedback">Please enter a username.</div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
                <div class="invalid-feedback">Please enter a password.</div>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
                <div class="invalid-feedback">Please enter a valid email.</div>
            </div>
            <div class="mb-3">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                <div class="invalid-feedback">Please enter a valid phone number.</div>
            </div>
            <div class="mb-3">
                <label for="vehicleName" class="form-label">Vehicle Name (e.g., Toyota Corolla)</label>
                <input type="text" class="form-control" id="vehicleName" name="vehicleName" required>
                <div class="invalid-feedback">Please enter the vehicle name.</div>
            </div>
            <div class="mb-3">
                <label for="vehicleNumber" class="form-label">Vehicle Number (License Plate)</label>
                <input type="text" class="form-control" id="vehicleNumber" name="vehicleNumber" required>
                <div class="invalid-feedback">Please enter the vehicle number.</div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Register</button>
            <a href="login.jsp" class="btn btn-link w-100 text-center mt-2">Already have an account? Login</a>
        </form>
        <a href="index.jsp" class="btn btn-secondary w-100 mt-3">Back to Home</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/scripts.js"></script>
</body>
</html>