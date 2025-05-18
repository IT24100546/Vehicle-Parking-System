<%--
  Created by IntelliJ IDEA.
  User: sanus
  Date: 4/13/2025
  Time: 10:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.app.parkingmanagement.vehicle_parking_management.dao.ParkingLogDAO" %>
<%@ page import="com.app.parkingmanagement.vehicle_parking_management.model.ParkingLogEntry" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Exit</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<div class="max-w-4xl mx-auto my-12 p-8 bg-white rounded shadow-md">
    <h1 class="text-3xl font-bold text-center mb-8">Vehicle Exit</h1>

    <form action="VehicleExitServlet" method="POST">
        <div class="mb-6">
            <label for="vehicleNumber" class="block text-lg font-medium">Select Vehicle</label>
            <select id="vehicleNumber" name="vehicleNumber" class="w-full mt-2 p-3 border rounded-md">
                <option value="" disabled selected>Select Vehicle</option>

                <%
                    // Get all entries
                    List<ParkingLogEntry> entries = ParkingLogDAO.getAllEntries();
                    for (ParkingLogEntry entry : entries) {
                        if (entry.getExitTime().equals("null")) {  // Only show vehicles that haven't exited
                %>
                <option value="<%= entry.getVehicleNumber() %>">
                    <%= entry.getVehicleNumber() %> - Entry Time: <%= entry.getEntryTime() %>
                </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="mb-6">
            <label for="exitTime" class="block text-lg font-medium">Exit Time</label>
            <input type="datetime-local" id="exitTime" name="exitTime" class="w-full mt-2 p-3 border rounded-md" required>
        </div>

        <div class="flex justify-center">
            <button type="submit" class="bg-green-500 text-white px-6 py-3 rounded-md shadow-lg hover:bg-green-700 transition duration-300">
                Record Exit
            </button>
        </div>
    </form>

</div>
</body>
</html>

