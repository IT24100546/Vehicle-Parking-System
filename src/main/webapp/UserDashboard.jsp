<%@ page import="com.parking.model.User" %><%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Parking Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .tab-content { display: none; }
        .tab-content.active { display: block; }
    </style>
</head>
<body class="min-h-screen bg-gray-100 p-6">
<div class="max-w-7xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-gray-800">Parking Dashboard</h1>
        <a href="/logout">
            <button class="px-4 py-2 rounded-md text-white bg-red-600 hover:bg-red-700">Logout</button>
        </a>

    </div>

    <!-- Tab Navigation -->
    <div class="flex border-b border-gray-200 mb-6">
        <button class="tab-button px-4 py-2 text-gray-600 font-medium border-b-2 border-transparent hover:border-blue-600 focus:outline-none active" onclick="openTab('parking-slots')">Parking Slots</button>
        <button class="tab-button px-4 py-2 text-gray-600 font-medium border-b-2 border-transparent hover:border-blue-600 focus:outline-none" onclick="openTab('reservation-history')">Reservation History</button>
        <button class="tab-button px-4 py-2 text-gray-600 font-medium border-b-2 border-transparent hover:border-blue-600 focus:outline-none" onclick="openTab('payment-history')">Payment History</button>
        <button class="tab-button px-4 py-2 text-gray-600 font-medium border-b-2 border-transparent hover:border-blue-600 focus:outline-none" onclick="openTab('profile')">Profile</button>
    </div>

    <!-- Parking Slots Tab -->
    <div id="parking-slots" class="tab-content active">
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">Available Parking Slots</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="p-6 rounded-lg shadow-md bg-green-100">
                <h3 class="text-xl font-medium text-gray-800">Slot A1</h3>
                <p class="text-gray-600">Type: Standard</p>
                <p class="text-gray-600">Status: Available</p>
                <button onclick="reserveSlot('A1')" class="mt-4 px-4 py-2 rounded-md text-white bg-blue-600 hover:bg-blue-700">Reserve</button>
            </div>
            <div class="p-6 rounded-lg shadow-md bg-red-100">
                <h3 class="text-xl font-medium text-gray-800">Slot A2</h3>
                <p class="text-gray-600">Type: Standard</p>
                <p class="text-gray-600">Status: Occupied</p>
                <button disabled class="mt-4 px-4 py-2 rounded-md text-white bg-gray-400 cursor-not-allowed">Reserve</button>
            </div>
            <div class="p-6 rounded-lg shadow-md bg-green-100">
                <h3 class="text-xl font-medium text-gray-800">Slot B1</h3>
                <p class="text-gray-600">Type: Premium</p>
                <p class="text-gray-600">Status: Available</p>
                <button onclick="reserveSlot('B1')" class="mt-4 px-4 py-2 rounded-md text-white bg-blue-600 hover:bg-blue-700">Reserve</button>
            </div>
            <div class="p-6 rounded-lg shadow-md bg-green-100">
                <h3 class="text-xl font-medium text-gray-800">Slot B2</h3>
                <p class="text-gray-600">Type: Standard</p>
                <p class="text-gray-600">Status: Available</p>
                <button onclick="reserveSlot('B2')" class="mt-4 px-4 py-2 rounded-md text-white bg-blue-600 hover:bg-blue-700">Reserve</button>
            </div>
            <div class="p-6 rounded-lg shadow-md bg-red-100">
                <h3 class="text-xl font-medium text-gray-800">Slot C1</h3>
                <p class="text-gray-600">Type: Premium</p>
                <p class="text-gray-600">Status: Occupied</p>
                <button disabled class="mt-4 px-4 py-2 rounded-md text-white bg-gray-400 cursor-not-allowed">Reserve</button>
            </div>
        </div>
    </div>

    <!-- Reservation History Tab -->
    <div id="reservation-history" class="tab-content">
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">Reservation History</h2>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Slot</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Time</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Duration</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">A1</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2025-05-15</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">10:00 AM</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2 hours</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Completed</td>
                </tr>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">B1</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2025-05-14</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2:00 PM</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">1 hour</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Completed</td>
                </tr>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">A2</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2025-05-13</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">9:00 AM</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">3 hours</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Cancelled</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Payment History Tab -->
    <div id="payment-history" class="tab-content">
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">Payment History</h2>
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Transaction ID</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Slot</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">TXN001</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">A1</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2025-05-15</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">$10.00</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Paid</td>
                </tr>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">TXN002</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">B1</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2025-05-14</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">$15.00</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Paid</td>
                </tr>
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">TXN003</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">A2</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2025-05-13</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">$8.00</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Refunded</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Profile Tab -->
    <div id="profile" class="tab-content">
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">User Profile</h2>
        <div class="container">
            <div class="card p-4">
                <h3 class="mb-4">Profile</h3>
                <!-- Simulated user data -->
                <div id="error-message" class="alert alert-danger alert-dismissible fade show d-none" role="alert">
                    <span id="error-text"></span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <div id="success-message" class="alert alert-success alert-dismissible fade show d-none" role="alert">
                    Profile updated successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <form id="profileForm" action="profile" method="post">
                    <input type="hidden" name="action" value="update">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" value="<%=user.getUsername()%>" required>
                        <div class="invalid-feedback">Please enter a username.</div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" value="<%=user.getPassword()%>" required>
                        <div class="invalid-feedback">Please enter a password.</div>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%=user.getEmail()%>" required>
                        <div class="invalid-feedback">Please enter a valid email.</div>
                    </div>
                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <input type="tel" class  class="form-control" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNumber()%>" required>
                        <div class="invalid-feedback">Please enter a valid phone number.</div>
                    </div>
                    <div class="mb-3">
                        <label for="vehicleName" class="form-label">Vehicle Name (e.g., Toyota Corolla)</label>
                        <input type="text" class="form-control" id="vehicleName" name="vehicleName" value="<%=user.getVehicleName()%>" required>
                        <div class="invalid-feedback">Please enter the vehicle name.</div>
                    </div>
                    <div class="mb-3">
                        <label for="vehicleNumber" class="form-label">Vehicle Number (License Plate)</label>
                        <input type="text" class="form-control" id="vehicleNumber" name="vehicleNumber" value="<%=user.getVehicleNumber()%>" required>
                        <div class="invalid-feedback">Please enter the vehicle number.</div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Update Profile</button>
                </form>
                <form onsubmit="return confirmDelete()" action="profile" method="post" class="mt-3">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-danger w-100">Delete Account</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });
        document.querySelectorAll('.tab-button').forEach(button => {
            button.classList.remove('active');
            button.classList.add('border-transparent');
        });
        document.getElementById(tabId).classList.add('active');
        event.currentTarget.classList.add('active');
        event.currentTarget.classList.remove('border-transparent');
        event.currentTarget.classList.add('border-blue-600');
    }

    function reserveSlot(slotNumber) {
        const slotCard = Array.from(document.querySelectorAll('#parking-slots .p-6')).find(
            card => card.querySelector('h3').textContent.includes(slotNumber)
        );
        slotCard.classList.remove('bg-green-100');
        slotCard.classList.add('bg-red-100');
        slotCard.querySelector('p:nth-child(3)').textContent = 'Status: Occupied';
        slotCard.querySelector('button').disabled = true;
        slotCard.querySelector('button').classList.remove('bg-blue-600', 'hover:bg-blue-700');
        slotCard.querySelector('button').classList.add('bg-gray-400', 'cursor-not-allowed');

        const tbody = document.querySelector('#reservation-history tbody');
        const newRow = document.createElement('tr');
        const date = new Date().toISOString().split('T')[0];
        const time = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        newRow.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${slotNumber}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${date}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${time}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">1 hour</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Active</td>
            `;
        tbody.insertBefore(newRow, tbody.firstChild);

        const paymentTbody = document.querySelector('#payment-history tbody');
        const newPaymentRow = document.createElement('tr');
        const transactionId = `TXN00${paymentTbody.children.length + 4}`;
        const amount = slotNumber.startsWith('B') ? '$15.00' : '$10.00';
        newPaymentRow.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${transactionId}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${slotNumber}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${date}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${amount}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">Paid</td>
            `;
        paymentTbody.insertBefore(newPaymentRow, paymentTbody.firstChild);
    }

    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            alert('You have been logged out.');
            window.location.href = '/login';
        }
    }

    function validateForm(event) {
        event.preventDefault();
        const form = event.target;
        const username = form.querySelector('#username').value;
        const password = form.querySelector('#password').value;
        const email = form.querySelector('#email').value;
        const phoneNumber = form.querySelector('#phoneNumber').value;
        const vehicleName = form.querySelector('#vehicleName').value;

        let isValid = true;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phoneRegex = /^\+?\d{10,15}$/;

        if (!username) {
            form.querySelector('#username').classList.add('is-invalid');
            isValid = false;
        } else {
            form.querySelector('#username').classList.remove('is-invalid');
        }

        if (!password) {
            form.querySelector('#password').classList.add('is-invalid');
            isValid = false;
        } else {
            form.querySelector('#password').classList.remove('is-invalid');
        }

        if (!email || !emailRegex.test(email)) {
            form.querySelector('#email').classList.add('is-invalid');
            isValid = false;
        } else {
            form.querySelector('#email').classList.remove('is-invalid');
        }

        if (!phoneNumber || !phoneRegex.test(phoneNumber)) {
            form.querySelector('#phoneNumber').classList.add('is-invalid');
            isValid = false;
        } else {
            form.querySelector('#phoneNumber').classList.remove('is-invalid');
        }

        if (!vehicleName) {
            form.querySelector('#vehicleName').classList.add('is-invalid');
            isValid = false;
        } else {
            form.querySelector('#vehicleName').classList.remove('is-invalid');
        }

        if (!vehicleNumber || !vehicleNumberRegex.test(vehicleNumber)) {
            form.querySelector('#vehicleNumber').classList.add('is-invalid');
            isValid = false;
        } else {
            form.querySelector('#vehicleNumber').classList.remove('is-invalid');
        }

        if (!isValid) {
            const errorMessage = document.getElementById('error-message');
            errorMessage.querySelector('#error-text').textContent = 'Please fill out all fields correctly.';
            errorMessage.classList.remove('d-none');
            return false;
        }

        const successMessage = document.getElementById('success-message');
        successMessage.classList.remove('d-none');
        document.getElementById('error-message').classList.add('d-none');
        return false; // Prevent actual form submission for demo
    }

    function confirmDelete() {
        return confirm('Are you sure you want to delete your account? This action cannot be undone.');
    }
</script>
</body>
</html>