package servlet;

import model.ParkingLot;
import model.ParkingSlot;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class ParkingServlet extends HttpServlet {
    private static final int PARKING_CAPACITY = 10;

    @Override
    public void init() throws ServletException {
        super.init();
        ParkingLot parkingLot = new ParkingLot(PARKING_CAPACITY);
        getServletContext().setAttribute("parkingLot", parkingLot);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ParkingLot parkingLot = (ParkingLot) getServletContext().getAttribute("parkingLot");
        List<ParkingSlot> slots = parkingLot.getAllSlotsSortedByAvailability();
        request.setAttribute("slots", slots);
        request.setAttribute("availableCount", parkingLot.getAvailableSlotCount());
        request.setAttribute("capacity", parkingLot.getCapacity());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ParkingLot parkingLot = (ParkingLot) getServletContext().getAttribute("parkingLot");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        String message = null;
        String error = null;

        try {
            if ("park".equals(action)) {
                String vehicleNumber = request.getParameter("vehicleNumber");
                if (vehicleNumber == null || vehicleNumber.trim().isEmpty()) {
                    error = "Vehicle number cannot be empty.";
                } else {
                    ParkingSlot parkedSlot = parkingLot.parkVehicle(vehicleNumber.trim());
                    if (parkedSlot != null) {
                        message = "Vehicle " + vehicleNumber + " parked in slot " + parkedSlot.getSlotNumber() + ".";
                    } else {
                        error = "Parking lot is full. Cannot park vehicle " + vehicleNumber + ".";
                    }
                }
            } else if ("leave".equals(action)) {
                String slotNumberStr = request.getParameter("slotNumber");
                if (slotNumberStr == null || slotNumberStr.trim().isEmpty()){
                    error = "Slot number cannot be empty.";
                } else {
                    try {
                        int slotNumber = Integer.parseInt(slotNumberStr);
                        if (parkingLot.leaveVehicle(slotNumber)) {
                            message = "Vehicle left slot " + slotNumber + ".";
                        } else {
                            error = "Could not leave slot " + slotNumber + ". Slot might be empty or invalid.";
                        }
                    } catch (NumberFormatException e){
                        error = "Invalid slot number format.";
                    }
                }
            }
        } catch (Exception e) {
            error = "An unexpected error occurred: " + e.getMessage();
            e.printStackTrace();
        }

        session.setAttribute("message", message);
        session.setAttribute("error", error);
        response.sendRedirect(request.getContextPath() + "/parking");
    }
} 