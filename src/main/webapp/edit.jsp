<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Location</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 min-h-screen">
    <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="sm:flex sm:items-center sm:justify-between mb-8">
            <h1 class="text-2xl font-bold text-gray-900">Edit Location</h1>
            <a href="${pageContext.request.contextPath}/" 
               class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                <svg class="mr-2 -ml-1 h-5 w-5 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                </svg>
                Back
            </a>
        </div>

        <div class="bg-white shadow rounded-lg p-6">
            <form id="editLocationForm" class="space-y-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                    <input type="text" id="name" name="name" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                    <span id="nameError" class="mt-1 text-xs text-red-600 hidden">Name must be 2-50 letters</span>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Slot ID</label>
                    <input type="text" id="slotId" name="slotId" required
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                    <span id="slotIdError" class="mt-1 text-xs text-red-600 hidden">Slot ID must be 2-20 alphanumeric characters</span>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Type</label>
                    <select id="type" name="type" required
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                        <option value="">Select Type</option>
                        <option value="vip">VIP</option>
                        <option value="regular">Regular</option>
                    </select>
                    <span id="typeError" class="mt-1 text-xs text-red-600 hidden">Please select a type</span>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Availability Status</label>
                    <select id="availabilityStatus" name="availabilityStatus" required
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                        <option value="">Select Status</option>
                        <option value="true">Available</option>
                        <option value="false">Not Available</option>
                    </select>
                    <span id="availabilityError" class="mt-1 text-xs text-red-600 hidden">Please select availability status</span>
                </div>

                <div class="flex justify-end space-x-3">
                    <button type="submit" id="submitBtn"
                            class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <span id="submitText">Update Location</span>
                        <svg id="loadingSpinner" class="animate-spin ml-2 h-5 w-5 text-white hidden" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
                        </svg>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        var contextPath = '${pageContext.request.contextPath}';
        var locationId = window.location.search.split('=')[1];
        var isLoading = false;

        var patterns = {
            name: /^[A-Za-z\s]{2,50}$/,
            slotId: /^[A-Za-z0-9]{2,20}$/
        };

        function showError(id, show) {
            var errorElement = document.getElementById(id + 'Error');
            if (errorElement) {
                errorElement.classList.toggle('hidden', !show);
            }
        }

        function setLoading(loading) {
            isLoading = loading;
            var submitBtn = document.getElementById('submitBtn');
            var submitText = document.getElementById('submitText');
            var loadingSpinner = document.getElementById('loadingSpinner');
            
            if (submitBtn && submitText && loadingSpinner) {
                submitBtn.disabled = loading;
                submitText.classList.toggle('opacity-50', loading);
                loadingSpinner.classList.toggle('hidden', !loading);
            }
        }

        function redirectWithMessage(message) {
            window.location.href = contextPath + '/?message=' + encodeURIComponent(message);
        }

        // Show loading state while fetching initial data
        setLoading(true);

        // Fetch location data
        fetch(contextPath + '/api/locations/' + locationId)
            .then(function(response) { 
                if (!response.ok) {
                    throw new Error('Failed to fetch location');
                }
                return response.json(); 
            })
            .then(function(location) {
                document.getElementById('name').value = location.name;
                document.getElementById('slotId').value = location.slotId;
                document.getElementById('type').value = location.type;
                document.getElementById('availabilityStatus').value = location.availabilityStatus.toString();
            })
            .catch(function(error) {
                alert('Failed to load location data');
                console.error('Error:', error);
            })
            .finally(function() {
                setLoading(false);
            });

        document.getElementById('editLocationForm').addEventListener('submit', function(e) {
            e.preventDefault();
            if (isLoading) return;

            var valid = true;
            var name = document.getElementById('name').value.trim();
            var slotId = document.getElementById('slotId').value.trim();
            var type = document.getElementById('type').value;
            var availabilityStatus = document.getElementById('availabilityStatus').value;

            // Clear previous errors
            showError('name', false);
            showError('slotId', false);
            showError('type', false);
            showError('availabilityStatus', false);

            // Validate fields
            if (!patterns.name.test(name)) {
                showError('name', true);
                valid = false;
            }
            if (!patterns.slotId.test(slotId)) {
                showError('slotId', true);
                valid = false;
            }
            if (!type) {
                showError('type', true);
                valid = false;
            }
            if (!availabilityStatus) {
                showError('availabilityStatus', true);
                valid = false;
            }

            if (!valid) return;

            setLoading(true);

            fetch(contextPath + '/api/locations/' + locationId, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    name: name,
                    slotId: slotId,
                    type: type,
                    availabilityStatus: availabilityStatus === 'true'
                })
            })
            .then(function(response) {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(function() {
                redirectWithMessage('Location updated successfully!');
            })
            .catch(function(error) {
                alert('Failed to update location');
                console.error('Error:', error);
            })
            .finally(function() {
                setLoading(false);
            });
        });
    </script>
</body>
</html>