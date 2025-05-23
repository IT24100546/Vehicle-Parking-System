<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Location</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-gray-900">Create Location</h2>
        <a href="${pageContext.request.contextPath}/" class="px-3 py-1 rounded bg-gray-200 hover:bg-gray-300 text-gray-700 transition">Back</a>
    </div>
    <form id="createLocationForm" class="space-y-4">
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
            <input type="text" id="name" name="name" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400" placeholder="Location Name">
            <span id="nameError" class="text-xs text-red-500 hidden">Name must be 2-50 letters.</span>
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Slot ID</label>
            <input type="text" id="slotId" name="slotId" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400" placeholder="Slot ID">
            <span id="slotIdError" class="text-xs text-red-500 hidden">Slot ID must be 2-20 alphanumeric.</span>
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Type</label>
            <select id="type" name="type" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400">
                <option value="">Select Type</option>
                <option value="vip">VIP</option>
                <option value="regular">Regular</option>
            </select>
            <span id="typeError" class="text-xs text-red-500 hidden">Please select a type.</span>
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Available</label>
            <select id="availabilityStatus" name="availabilityStatus" required class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-gray-400">
                <option value="">Select</option>
                <option value="true">Yes</option>
                <option value="false">No</option>
            </select>
            <span id="availabilityError" class="text-xs text-red-500 hidden">Please select availability.</span>
        </div>
        <button type="submit" id="submitBtn" class="w-full py-2 px-4 bg-gray-900 text-white rounded hover:bg-gray-700 transition flex items-center justify-center">
            <span id="submitText">Create</span>
            <svg id="loadingSpinner" class="animate-spin h-5 w-5 ml-2 text-white hidden" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
            </svg>
        </button>
    </form>
</div>
<script>
    // Regex patterns
    var patterns = {
        name: /^[A-Za-z\s]{2,50}$/,
        slotId: /^[A-Za-z0-9]{2,20}$/
    };

    function showError(id, show) {
        document.getElementById(id).classList.toggle('hidden', !show);
    }

    document.getElementById('createLocationForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        var valid = true;

        var name = document.getElementById('name').value.trim();
        var slotId = document.getElementById('slotId').value.trim();
        var type = document.getElementById('type').value;
        var availabilityStatus = document.getElementById('availabilityStatus').value;

        showError('nameError', !patterns.name.test(name));
        showError('slotIdError', !patterns.slotId.test(slotId));
        showError('typeError', !type);
        showError('availabilityError', !availabilityStatus);

        if (!patterns.name.test(name)) valid = false;
        if (!patterns.slotId.test(slotId)) valid = false;
        if (!type) valid = false;
        if (!availabilityStatus) valid = false;

        if (!valid) return;

        document.getElementById('submitBtn').disabled = true;
        document.getElementById('submitText').classList.add('opacity-50');
        document.getElementById('loadingSpinner').classList.remove('hidden');

        try {
            var response = await fetch(contextPath + '/api/locations', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    name: name,
                    slotId: slotId,
                    type: type,
                    availabilityStatus: availabilityStatus === 'true'
                })
            });
            var data = await response.json();
            if (response.ok) {
                alert('Location created successfully!');
                window.location.href = contextPath + '/';
            } else {
                alert(data.error || 'Failed to create location.');
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