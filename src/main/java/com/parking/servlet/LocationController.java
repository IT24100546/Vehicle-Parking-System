package com.parking.servlet;

import com.parking.model.LocationModel;
import com.parking.services.LocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Stack;
import java.util.stream.Collectors;

@WebServlet("/api/locations/*")
public class LocationController extends HttpServlet {
    private LocationService locationService = new LocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();
        PrintWriter out = resp.getWriter();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all locations
                Stack<LocationModel> locations = locationService.getAllLocations();
                out.print(convertToJson(locations));
            } else {
                // Get location by ID (path: /api/locations/{id})
                String locationId = pathInfo.substring(1);
                LocationModel location = locationService.getLocationById(locationId);

                if (location != null) {
                    out.print(convertToJson(location));
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"error\":\"Location not found\"}");
                }
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            // Parse request body to LocationModel object
            String requestBody = readRequestBody(req);
            LocationModel location = parseLocationJson(requestBody);

            // Create location
            LocationModel createdLocation = locationService.createLocation(location);

            if (createdLocation != null) {
                // Return created location with 201 status
                resp.setStatus(HttpServletResponse.SC_CREATED);
                out.print(convertToJson(createdLocation));
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Failed to create location\"}");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();
        PrintWriter out = resp.getWriter();

        if (pathInfo == null || pathInfo.equals("/")) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Location ID is required\"}");
            return;
        }

        try {
            // Get location ID from path
            String locationId = pathInfo.substring(1);

            // Parse request body to LocationModel object
            String requestBody = readRequestBody(req);
            LocationModel updatedLocation = parseLocationJson(requestBody);
            updatedLocation.setId(locationId);

            // Update location
            boolean updated = locationService.updateLocation(updatedLocation);

            if (updated) {
                LocationModel location = locationService.getLocationById(locationId);
                out.print(convertToJson(location));
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Location not found\"}");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();
        PrintWriter out = resp.getWriter();

        if (pathInfo == null || pathInfo.equals("/")) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Location ID is required\"}");
            return;
        }

        try {
            // Get location ID from path
            String locationId = pathInfo.substring(1);

            // Delete location
            boolean deleted = locationService.deleteLocation(locationId);

            if (deleted) {
                resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Location not found\"}");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }

    private String readRequestBody(HttpServletRequest req) throws IOException {
        BufferedReader reader = req.getReader();
        return reader.lines().collect(Collectors.joining());
    }

    private LocationModel parseLocationJson(String json) {
        LocationModel location = new LocationModel();
        json = json.replaceAll("[{}\"]", "");
        String[] pairs = json.split(",");

        for (String pair : pairs) {
            String[] keyValue = pair.split(":");
            if (keyValue.length == 2) {
                String key = keyValue[0].trim();
                String value = keyValue[1].trim();

                switch (key) {
                    case "name":
                        location.setName(value);
                        break;
                    case "slotId":
                        location.setSlotId(value);
                        break;
                    case "type":
                        location.setType(value);
                        break;
                    case "availabilityStatus":
                        location.setAvailabilityStatus(Boolean.parseBoolean(value));
                        break;
                }
            }
        }

        return location;
    }

    private String convertToJson(LocationModel location) {
        return "{" +
                "\"id\":\"" + location.getId() + "\"," +
                "\"createdAt\":\"" + location.getCreatedAt() + "\"," +
                "\"name\":\"" + (location.getName() != null ? location.getName() : "") + "\"," +
                "\"slotId\":\"" + (location.getSlotId() != null ? location.getSlotId() : "") + "\"," +
                "\"type\":\"" + (location.getType() != null ? location.getType() : "") + "\"," +
                "\"availabilityStatus\":" + location.isAvailabilityStatus() +
                "}";
    }

    private String convertToJson(Stack<LocationModel> locations) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < locations.size(); i++) {
            json.append(convertToJson(locations.get(i)));
            if (i < locations.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();

    }
}