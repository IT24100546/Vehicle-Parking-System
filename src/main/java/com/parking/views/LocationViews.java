package com.parking.views;

import com.parking.model.LocationModel;
import com.parking.services.LocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class LocationViews extends HttpServlet {
    private LocationService locationService = new LocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/index":
            case "/":
                showIndex(req, resp);
                break;
            case "/create":
                showCreate(req, resp);
                break;
            case "/edit":
                showEdit(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<LocationModel> locations = locationService.getAllLocations();
            req.setAttribute("locations", locations);
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/LocationDashboard.jsp").forward(req, resp);
    }

    private void showCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/create.jsp").forward(req, resp);
    }

    private void showEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        LocationModel location = null;
        
        if (idParam != null) {
            try {
                location = locationService.getLocationById(idParam);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        req.setAttribute("location", location);
        req.getRequestDispatcher("/edit.jsp").forward(req, resp);
    }
}
