package com.parking.servlet;

import com.parking.model.User;
import com.parking.util.FileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        FileHandler fileHandler = new FileHandler();

        if ("update".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String vehicleName = request.getParameter("vehicleName");
            String vehicleNumber = request.getParameter("vehicleNumber");

            if (username == null || password == null || email == null || phoneNumber == null ||
                    vehicleName == null || vehicleNumber == null ||
                    username.trim().isEmpty() || password.trim().isEmpty() || email.trim().isEmpty() ||
                    phoneNumber.trim().isEmpty() || vehicleName.trim().isEmpty() || vehicleNumber.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required.");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
                return;
            }

            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);
            user.setVehicleName(vehicleName);
            user.setVehicleNumber(vehicleNumber);
            fileHandler.updateUser(user);
            session.setAttribute("user", user);
            request.setAttribute("message", "Profile updated successfully.");
        } else if ("delete".equals(action)) {
            fileHandler.deleteUser(user.getId());
            session.invalidate();
            response.sendRedirect("Register.jsp");
            return;
        }

        request.getRequestDispatcher("/UserDashboard.jsp").forward(request, response);
    }
}