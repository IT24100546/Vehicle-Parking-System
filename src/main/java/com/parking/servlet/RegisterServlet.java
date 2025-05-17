package com.parking.servlet;

import com.parking.model.User;
import com.parking.util.FileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        FileHandler fileHandler = new FileHandler();
        int id = fileHandler.generateId();
        User user = new User(id, username, password, email, phoneNumber, vehicleName, vehicleNumber);
        fileHandler.saveUser(user);

        response.sendRedirect("login.jsp");
    }
}