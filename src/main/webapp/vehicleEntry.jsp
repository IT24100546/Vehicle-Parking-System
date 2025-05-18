<%--
  Created by IntelliJ IDEA.
  User: sanus
  Date: 4/13/2025
  Time: 10:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <title>Vehicle Entry</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<div class="max-w-xl mx-auto my-16 p-8 bg-white rounded-lg shadow-md">
    <h1 class="text-3xl font-bold text-center mb-8 text-blue-700">Vehicle Entry</h1>

    <form action="VehicleEntryServlet" method="POST">
        <div class="mb-6">
            <label for="vehicleNumber" class="block text-lg font-medium text-gray-700 mb-2">Vehicle Number</label>
            <input
                    type="text"
                    id="vehicleNumber"
                    name="vehicleNumber"
                    class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Enter vehicle number"
                    required
            >
        </div>

        <div class="flex justify-center mt-8">
            <button
                    type="submit"
                    class="bg-green-500 hover:bg-green-600 text-white font-semibold px-6 py-3 rounded-md shadow-md transition duration-300"
            >
                Record Entry
            </button>
        </div>
    </form>

    <div class="flex justify-center mt-6">
        <a
                href="index.jsp"
                class="text-blue-500 hover:text-blue-700 font-medium transition duration-200"
        >
            ← Back to Homepage
        </a>
    </div>
</div>

</body>
</html>

