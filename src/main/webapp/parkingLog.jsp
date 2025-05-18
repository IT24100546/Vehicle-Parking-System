<%--
  Created by IntelliJ IDEA.
  User: sanus
  Date: 4/13/2025
  Time: 10:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*,
com.app.parkingmanagement.vehicle_parking_management.model.ParkingLogEntry,
com.app.parkingmanagement.vehicle_parking_management.dao.ParkingLogDAO"
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parking Log</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<div class="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-md">
    <h1 class="text-3xl font-bold text-center mb-8">Parking Log</h1>

    <div class="overflow-x-auto">
        <table class="min-w-full table-auto bg-white border-collapse">
            <thead>
            <tr class="bg-blue-500 text-white">
                <th class="px-6 py-4 text-left text-lg font-semibold">Vehicle Number</th>
                <th class="px-6 py-4 text-left text-lg font-semibold">Entry Time</th>
                <th class="px-6 py-4 text-left text-lg font-semibold">Exit Time</th>
                <th class="px-6 py-4 text-left text-lg font-semibold">Fee (LKR)</th>
                <th class="px-6 py-4 text-left text-lg font-semibold">Action</th>

            </tr>
            </thead>
            <tbody>
            <%
                List<ParkingLogEntry> entries = ParkingLogDAO.getAllEntries();
                for (ParkingLogEntry entry : entries) {
                    if (!entry.getExitTime().equals("null")) {  // Only show vehicles that have exited
            %>
            <!-- Inside your table body loop -->
            <tr class="border-t hover:bg-gray-50">
                <td class="px-4 py-3"><%= entry.getVehicleNumber() %></td>
                <td class="px-4 py-3"><%= entry.getEntryTime() %></td>
                <td class="px-4 py-3"><%= entry.getExitTime() %></td>
                <td class="px-4 py-3"><%= entry.getFee() %></td>
                <td class="px-4 py-3">
                    <form action="DeleteParkingLogServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this log?');">
                        <input type="hidden" name="vehicleNumber" value="<%= entry.getVehicleNumber() %>">
                        <input type="hidden" name="entryTime" value="<%= entry.getEntryTime() %>">
                        <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-md text-sm">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>

            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- Back to Homepage Button -->
    <div class="flex justify-center mt-6">
        <a href="index.jsp" class="bg-blue-500 text-white px-6 py-3 rounded-md shadow-lg hover:bg-blue-700 transition duration-300">
            Back to Homepage
        </a>
    </div>

</div>

</body>
</html>
