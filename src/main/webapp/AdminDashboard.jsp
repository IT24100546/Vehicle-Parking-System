<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin List</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        var contextPath = "<%= request.getContextPath() %>";
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col items-center py-10">
    <div class="w-full max-w-4xl bg-white shadow-lg rounded-lg p-8">
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-6 gap-4">
            <h1 class="text-2xl font-bold text-gray-900">Admin List</h1>
            <div class="flex gap-2">
                <input type="text" id="searchInput" placeholder="Search users..." onkeyup="filterTable()"
                    class="border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-400 transition" />
                <button onclick="navigateToCreate()" class="bg-gray-900 text-white px-4 py-2 rounded hover:bg-gray-700 transition">Create User</button>
                <button onclick="downloadPDF()" class="bg-gray-200 text-gray-700 px-4 py-2 rounded hover:bg-gray-300 transition">Export PDF</button>
            </div>
        </div>
        <div class="overflow-x-auto rounded-lg border border-gray-200">
            <table id="userTable" class="min-w-full bg-white text-sm">
                <thead class="bg-gray-50 border-b">
                    <tr>
                        <!-- Removed ID column -->
                        <th class="px-4 py-3 text-left font-medium text-gray-700">Created At</th>
                        <th class="px-4 py-3 text-left font-medium text-gray-700">Name</th>
                        <th class="px-4 py-3 text-left font-medium text-gray-700">Email</th>
                        <th class="px-4 py-3 text-left font-medium text-gray-700">Role</th>
                        <th class="px-4 py-3 text-left font-medium text-gray-700">Username</th>
                        <th class="px-4 py-3 text-left font-medium text-gray-700">Actions</th>
                    </tr>
                </thead>
                <tbody id="userTableBody" class="divide-y divide-gray-100">
                    <!-- Users will be rendered here by JS -->
                </tbody>
            </table>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetch(contextPath + "/api/users")
                .then(function(response) { return response.json(); })
                .then(function(users) {
                    renderUsers(users);
                })
                .catch(function() {
                    alert("Failed to fetch users.");
                });
        });

        function renderUsers(users) {
            var tbody = document.getElementById("userTableBody");
            tbody.innerHTML = "";
            users.forEach(function(user) {
                var tr = document.createElement("tr");
                tr.className = "hover:bg-gray-50 transition";
                tr.innerHTML =
                    // Removed ID column
                    "<td class='px-4 py-2 whitespace-nowrap text-gray-700'>" + user.createdAt + "</td>" +
                    "<td class='px-4 py-2 whitespace-nowrap text-gray-700'>" + user.name + "</td>" +
                    "<td class='px-4 py-2 whitespace-nowrap text-gray-700'>" + user.emailAddress + "</td>" +
                    "<td class='px-4 py-2 whitespace-nowrap text-gray-700'>" + user.role + "</td>" +
                    "<td class='px-4 py-2 whitespace-nowrap text-gray-700'>" + user.username + "</td>" +
                    "<td class='px-4 py-2 whitespace-nowrap'>" +
                        "<button onclick=\"navigateToEdit('" + user.id + "')\" class=\"bg-gray-200 text-gray-700 px-3 py-1 rounded hover:bg-gray-300 transition mr-2\">Edit</button>" +
                        "<button onclick=\"deleteUser('" + user.id + "', this)\" class=\"bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition\">Delete</button>" +
                    "</td>";
                tbody.appendChild(tr);
            });
        }

        function deleteUser(userId, btn) {
            if (confirm("Are you sure you want to delete this user?")) {
                fetch(contextPath + "/api/users/" + encodeURIComponent(userId), {
                    method: "DELETE"
                })
                .then(function(response) {
                    if (response.status === 204) {
                        var row = btn.closest("tr");
                        row.parentNode.removeChild(row);
                    } else {
                        response.json().then(function(data) {
                            alert(data.error || "Failed to delete user.");
                        });
                    }
                })
                .catch(function() {
                    alert("Failed to delete user.");
                });
            }
        }

        function filterTable() {
            var input = document.getElementById("searchInput");
            var filter = input.value.toLowerCase();
            var table = document.getElementById("userTable");
            var trs = table.getElementsByTagName("tr");
            for (var i = 1; i < trs.length; i++) {
                var tds = trs[i].getElementsByTagName("td");
                var show = false;
                for (var j = 0; j < tds.length - 1; j++) {
                    if (tds[j].innerText.toLowerCase().indexOf(filter) > -1) {
                        show = true;
                        break;
                    }
                }
                trs[i].style.display = show ? "" : "none";
            }
        }

        function navigateToCreate() {
            window.location.href = contextPath + "/create";
        }

        function navigateToEdit(id) {
            window.location.href = contextPath + "/edit?id=" + encodeURIComponent(id);
        }

        function downloadPDF() {
            var jsPDF = window.jspdf.jsPDF;
            var doc = new jsPDF();
            var table = document.getElementById("userTable");
            var rows = [];
            var headers = [];
            table.querySelectorAll("thead th").forEach(function(th) { headers.push(th.innerText); });
            rows.push(headers);
            table.querySelectorAll("tbody tr").forEach(function(tr) {
                if (tr.style.display !== "none") {
                    var row = [];
                    tr.querySelectorAll("td").forEach(function(td, idx) {
                        if (idx < headers.length - 1) row.push(td.innerText);
                    });
                    rows.push(row);
                }
            });
            rows.forEach(function(row, i) {
                doc.text(row.join(" | "), 10, 10 + i * 10);
            });
            doc.save("users.pdf");
        }
    </script>
</body>
</html>