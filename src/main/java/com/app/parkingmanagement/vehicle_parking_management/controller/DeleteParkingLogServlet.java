package com.app.parkingmanagement.vehicle_parking_management.controller;

import com.app.parkingmanagement.vehicle_parking_management.dao.ParkingLogDAO;
import com.app.parkingmanagement.vehicle_parking_management.model.ParkingLogEntry;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;

@WebServlet("/DeleteParkingLogServlet")
public class DeleteParkingLogServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String vehicleNumber = request.getParameter("vehicleNumber");
        String entryTime = request.getParameter("entryTime");

        List<ParkingLogEntry> entries = ParkingLogDAO.getAllEntries();

        if (vehicleNumber != null && entryTime != null) {
            entries.removeIf(e -> e.getVehicleNumber().equals(vehicleNumber) && e.getEntryTime().equals(entryTime));
        }

        ParkingLogDAO.saveAllEntries(entries);  // overwrite log file with updated list
        response.sendRedirect("parkingLog.jsp");
    }
}