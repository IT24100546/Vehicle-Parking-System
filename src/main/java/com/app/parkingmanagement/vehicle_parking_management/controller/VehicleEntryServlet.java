package com.app.parkingmanagement.vehicle_parking_management.controller;

import com.app.parkingmanagement.vehicle_parking_management.dao.ParkingLogDAO;
import com.app.parkingmanagement.vehicle_parking_management.model.ParkingLogEntry;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


@WebServlet("/VehicleEntryServlet")
public class VehicleEntryServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String vehicleNumber = request.getParameter("vehicleNumber");
        String entryTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        ParkingLogDAO.addEntry(new ParkingLogEntry(vehicleNumber, entryTime));
        response.sendRedirect("index.jsp");
    }
}



