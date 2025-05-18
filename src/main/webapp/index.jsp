<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Locations</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body class="bg-gray-50 min-h-screen">
    <div id="successMessage" class="hidden fixed top-4 right-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded"></div>
    <script>
        // Check for success message in URL
        var urlParams = new URLSearchParams(window.location.search);
        var message = urlParams.get('message');
        if (message) {
            var messageDiv = document.getElementById('successMessage');
            messageDiv.textContent = message;
            messageDiv.classList.remove('hidden');
            setTimeout(function() {
                messageDiv.classList.add('hidden');
                // Clean up URL
                window.history.replaceState({}, document.title, window.location.pathname);
            }, 3000);
        }
    </script>
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="sm:flex sm:items-center sm:justify-between mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Locations</h1>
            <div class="mt-4 sm:mt-0">
                <a href="${pageContext.request.contextPath}/create.jsp"
                   class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    <svg class="mr-2 -ml-1 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Add Location
                </a>
            </div>
        </div>

        <div class="sm:flex sm:gap-x-4 mb-6">
            <div class="flex-grow mt-4 sm:mt-0">
                <div class="relative rounded-md shadow-sm">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </div>
                    <input type="text" id="searchInput" 
                           class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                           placeholder="Search locations..."
                           onkeyup="filterTable()">
                </div>
            </div>
            <div class="mt-4 sm:mt-0">
                <button onclick="generatePDF()" 
                        class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                    <svg class="mr-2 -ml-1 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                    </svg>
                    Export PDF
                </button>
            </div>
        </div>

        <div class="mt-8 flex flex-col">
            <div class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8">
                <div class="inline-block min-w-full py-2 align-middle md:px-6 lg:px-8">
                    <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 rounded-lg">
                        <table id="locationsTable" class="min-w-full divide-y divide-gray-300">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Name</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Slot ID</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Type</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Available</th>
                                    <th scope="col" class="relative py-3.5 pl-3 pr-4 sm:pr-6">
                                        <span class="sr-only">Actions</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="locationsTableBody" class="divide-y divide-gray-200 bg-white">
                                <!-- JS will render rows here -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var contextPath = "${pageContext.request.contextPath}";

        const getLocations =async ()=>{
            try{
                const response = await fetch(contextPath+"/api/locations")
                const result =  await response.json()
                renderLocations(result)
            }catch(err){
                console.error("error getting locations "+err)

            }
        }

        function renderLocations(locations) {
            var tbody = document.getElementById('locationsTableBody');
            tbody.innerHTML = '';
            locations.forEach(function(loc) {
                var tr = document.createElement('tr');
                tr.className = 'hover:bg-gray-50';
                tr.innerHTML =
                    '<td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">' + loc.name + '</td>' +
                    '<td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">' + loc.slotId + '</td>' +
                    '<td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">' + loc.type + '</td>' +
                    '<td class="whitespace-nowrap px-3 py-4 text-sm">' +
                        '<span class="inline-flex rounded-full px-2 text-xs font-semibold leading-5 ' + 
                        (loc.availabilityStatus ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800') + '">' +
                        (loc.availabilityStatus ? 'Available' : 'Not Available') +
                        '</span>' +
                    '</td>' +
                    '<td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">' +
                        '<a href="' + contextPath + '/edit?id=' + loc.id + '" class="text-blue-600 hover:text-blue-900 mr-4">Edit</a>' +
                        '<button onclick="confirmDelete(\'' + loc.id + '\')" class="text-red-600 hover:text-red-900">Delete</button>' +
                    '</td>';
                tbody.appendChild(tr);
            });
        }

        function filterTable() {
            var input = document.getElementById("searchInput").value.toLowerCase();
            var table = document.getElementById("locationsTable");
            var trs = table.getElementsByTagName("tr");
            for (var i = 1; i < trs.length; i++) {
                var tds = trs[i].getElementsByTagName("td");
                var show = false;
                for (var j = 0; j < 3; j++) {
                    if (tds[j] && tds[j].innerText.toLowerCase().indexOf(input) > -1) {
                        show = true;
                        break;
                    }
                }
                trs[i].style.display = show ? "" : "none";
            }
        }

        function confirmDelete(id) {
            if (confirm("Are you sure you want to delete this location?")) {
                fetch(contextPath + "/api/locations/" + id, { method: "DELETE" })
                    .then(function(response) {
                        if (response.status === 204) {
                            getLocations();
                        } else {
                            alert("Failed to delete location");
                        }
                    });
            }
        }

        function generatePDF() {
            var jsPDF = window.jspdf.jsPDF;
            var doc = new jsPDF();
            doc.text("Locations", 10, 10);
            var rows = [];
            var table = document.getElementById("locationsTable").getElementsByTagName("tbody")[0];
            for (var i = 0, row; row = table.rows[i]; i++) {
                var rowData = [];
                for (var j = 0; j < 4; j++) {
                    rowData.push(row.cells[j].innerText);
                }
                rows.push(rowData);
            }
            var startY = 20;
            rows.forEach(function(row, idx) {
                doc.text(row.join(" | "), 10, startY + idx * 10);
            });
            doc.save("locations.pdf");
        }

        document.addEventListener("DOMContentLoaded", getLocations);
    </script>
</body>
</html>