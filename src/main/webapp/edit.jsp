<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit User</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        var contextPath = "<%= request.getContextPath() %>";
        function getQueryParam(name) {
            var url = new URL(window.location.href);
            return url.searchParams.get(name);
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-gray-900">Edit User</h2>
            <button onclick="window.location.href=contextPath+'/'" class="px-3 py-1 rounded bg-gray-200 hover:bg-gray-300 text-gray-700 transition">Back</button>
        </div>
        <form id="editUserForm" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                <input type="text" id="name" name="name" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400" placeholder="Full Name">
                <span id="nameError" class="text-xs text-red-500 hidden">Name must be 2-50 letters.<br><span class="text-gray-400">e.g. John Doe</span></span>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                <input type="email" id="emailAddress" name="emailAddress" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400" placeholder="Email">
                <span id="emailError" class="text-xs text-red-500 hidden">Invalid email address.<br><span class="text-gray-400">e.g. john@example.com</span></span>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                <select id="role" name="role" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400">
                    <option value="">Select Role</option>
                    <option value="admin">Admin</option>
                    <option value="staff">Staff</option>
                    <option value="user">User</option>
                </select>
                <span id="roleError" class="text-xs text-red-500 hidden">Please select a role.<br><span class="text-gray-400">e.g. Admin</span></span>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <input type="text" id="username" name="username" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400" placeholder="Username" readonly>
                <span id="usernameError" class="text-xs text-red-500 hidden">Username must be 4-20 letters, numbers, or underscores.<br><span class="text-gray-400">e.g. johndoe_123</span></span>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input type="password" id="password" name="password" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400" placeholder="Password">
                <span id="passwordError" class="text-xs text-red-500 hidden">Password must be at least 6 characters.<br><span class="text-gray-400">e.g. secret1</span></span>
            </div>
            <button type="submit" id="submitBtn" class="w-full py-2 px-4 bg-gray-900 text-white rounded hover:bg-gray-700 transition flex items-center justify-center">
                <span id="submitText">Update</span>
                <svg id="loadingSpinner" class="animate-spin h-5 w-5 ml-2 text-white hidden" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
                </svg>
            </button>
        </form>
    </div>
    <script>
        // Regex patterns
        const patterns = {
            name: /^[A-Za-z\s]{2,50}$/,
            emailAddress: /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/,
            username: /^[A-Za-z0-9_]{4,20}$/,
            password: /^.{6,}$/
        };

        function showError(id, show) {
            document.getElementById(id).classList.toggle('hidden', !show);
        }

        // Fetch user data and populate form
        document.addEventListener("DOMContentLoaded", function() {
            var userId = getQueryParam("id");
            if (!userId) {
                alert("No user ID provided.");
                window.location.href = contextPath + "/";
                return;
            }
            document.getElementById('submitBtn').disabled = true;
            document.getElementById('submitText').classList.add('opacity-50');
            document.getElementById('loadingSpinner').classList.remove('hidden');
            fetch(contextPath + "/api/users/" + encodeURIComponent(userId))
                .then(function(response) {
                    if (!response.ok) throw new Error("User not found");
                    return response.json();
                })
                .then(function(user) {
                    document.getElementById('name').value = user.name || "";
                    document.getElementById('emailAddress').value = user.emailAddress || "";
                    document.getElementById('role').value = user.role || "";
                    document.getElementById('username').value = user.username || "";
                    document.getElementById('password').value = user.password || "";
                })
                .catch(function() {
                    alert("Failed to load user.");
                    window.location.href = contextPath + "/";
                })
                .finally(function() {
                    document.getElementById('submitBtn').disabled = false;
                    document.getElementById('submitText').classList.remove('opacity-50');
                    document.getElementById('loadingSpinner').classList.add('hidden');
                });
        });

        document.getElementById('editUserForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            let valid = true;

            // Validate fields
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('emailAddress').value.trim();
            const role = document.getElementById('role').value;
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;

            showError('nameError', !patterns.name.test(name));
            showError('emailError', !patterns.emailAddress.test(email));
            showError('roleError', !role);
            showError('usernameError', !patterns.username.test(username));
            showError('passwordError', !patterns.password.test(password));

            if (!patterns.name.test(name)) valid = false;
            if (!patterns.emailAddress.test(email)) valid = false;
            if (!role) valid = false;
            if (!patterns.username.test(username)) valid = false;
            if (!patterns.password.test(password)) valid = false;

            if (!valid) return;

            // Loading state
            document.getElementById('submitBtn').disabled = true;
            document.getElementById('submitText').classList.add('opacity-50');
            document.getElementById('loadingSpinner').classList.remove('hidden');

            var userId = getQueryParam("id");
            try {
                const response = await fetch(contextPath + "/api/users/" + encodeURIComponent(userId), {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ name, emailAddress: email, role, username, password })
                });
                const data = await response.json();
                if (response.ok) {
                    alert('User updated successfully!');
                    window.location.href = contextPath + "/";
                } else {
                    alert(data.error || 'Failed to update user.');
                }
            } catch (err) {
                alert('An error occurred. Please try again.');
            } finally {
                document.getElementById('submitBtn').disabled = false;
                document.getElementById('submitText').classList.remove('opacity-50');
                document.getElementById('loadingSpinner').classList.add('hidden');
            }
        });
    </script>
</body>
</html>