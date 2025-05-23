package com.example.demo1.views;

import com.example.demo1.models.User;
import com.example.demo1.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/create")
public class UserViews extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        System.out.println("Path "+path);
        switch (path) {
            case "/index":
            case "/":
                System.out.println("Index called");
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
        try{
            List<User> users = userService.getAllUsers();
            System.out.println("There are "+users.size());
            req.setAttribute("users", users);
        }catch (Exception e){
            System.out.println(e);
        }
        req.getRequestDispatcher("/AdminDashboard.jsp").forward(req, resp);
    }

    private void showCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/create.jsp").forward(req, resp);
    }

    private void showEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        User user = null;
        if (idParam != null) {
            try {

                List<User> users = userService.getAllUsers();
                for (User u : users) {
                    if (u.getId() .equals(idParam)) {
                        user = u;
                        break;
                    }
                }
            } catch (NumberFormatException e) {
               
            }
        }
        req.setAttribute("user", user);
        req.getRequestDispatcher("/edit.jsp").forward(req, resp);
    }
}
