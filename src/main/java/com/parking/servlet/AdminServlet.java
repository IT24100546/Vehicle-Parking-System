package com.parking.servlet;

import com.parking.model.User;
import com.parking.util.FileHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all users
        FileHandler fileHandler = new FileHandler();
        List<User> users = fileHandler.readUsers();

        // Set users as request attribute to pass to JSP
        request.setAttribute("users", users);

        // Forward to the users.jsp page
        request.getRequestDispatcher("/users.jsp").forward(request, response);
    }
}