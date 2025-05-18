<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Entry and Exit Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<div class="max-w-4xl mx-auto my-12 p-8 bg-white rounded shadow-md">
    <h1 class="text-3xl font-bold text-center mb-8">Vehicle Entry and Exit Management</h1>

    <div class="space-y-6">
        <!-- Vehicle Entry Button -->
        <div class="flex justify-center">
            <a href="vehicleEntry.jsp" class="bg-blue-500 text-white px-6 py-3 rounded-md shadow-lg hover:bg-blue-700 transition duration-300">
                Vehicle Entry
            </a>
        </div>

        <!-- Vehicle Exit Button -->
        <div class="flex justify-center">
            <a href="vehicleExit.jsp" class="bg-green-500 text-white px-6 py-3 rounded-md shadow-lg hover:bg-green-700 transition duration-300">
                Vehicle Exit
            </a>
        </div>

        <!-- Parking Log View Button -->
        <div class="flex justify-center">
            <a href="parkingLog.jsp" class="bg-gray-500 text-white px-6 py-3 rounded-md shadow-lg hover:bg-gray-700 transition duration-300">
                View Parking Log
            </a>
        </div>
    </div>

</div>

</body>
</html>
