package com.example.demo1.controllers;

import com.example.demo1.models.User;
import com.example.demo1.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/api/users/*")
public class UserController extends HttpServlet {
    private UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String pathInfo = req.getPathInfo();
        PrintWriter out = resp.getWriter();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // Get all users
                List<User> users = userService.getAllUsers();
                out.print(convertToJson(users));
            } else {
                // Get user by ID (path: /api/users/{id})
                String userId = pathInfo.substring(1);
                User user = userService.getUserById(userId);
                
                if (user != null) {
                    out.print(convertToJson(user));
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"error\":\"User not found\"}");
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
            // Parse request body to User object
            String requestBody = readRequestBody(req);
            User user = parseUserJson(requestBody);
            
            // Set creation time
            user.setCreatedAt(LocalDateTime.now());
            
            // Create user
            userService.createUser(user);
            
            // Return created user with 201 status
            resp.setStatus(HttpServletResponse.SC_CREATED);
            out.print(convertToJson(user));
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
            out.print("{\"error\":\"User ID is required\"}");
            return;
        }
        
        try {
            // Get user ID from path
            String userId = pathInfo.substring(1);
            
            // Parse request body to User object
            String requestBody = readRequestBody(req);
            User updatedUser = parseUserJson(requestBody);
            updatedUser.setId(userId);
            
            // Update user
            boolean updated = userService.updateUser(updatedUser);
            
            if (updated) {
                out.print(convertToJson(updatedUser));
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"User not found\"}");
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
            out.print("{\"error\":\"User ID is required\"}");
            return;
        }
        
        try {
            // Get user ID from path
            String userId = pathInfo.substring(1);
            
            // Delete user
            boolean deleted = userService.deleteUser(userId);
            
            if (deleted) {
                resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"User not found\"}");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
    
    // Helper method to read request body
    private String readRequestBody(HttpServletRequest req) throws IOException {
        BufferedReader reader = req.getReader();
        return reader.lines().collect(Collectors.joining());
    }
    
    // Helper method to parse JSON to User object
    private User parseUserJson(String json) {
        // Simple parsing for demonstration
        // In a real application, use a proper JSON library like Jackson or Gson
        User user = new User();
        
        // Remove curly braces and split by commas
        json = json.replaceAll("[{}\"]", "");
        String[] pairs = json.split(",");
        
        for (String pair : pairs) {
            String[] keyValue = pair.split(":");
            if (keyValue.length == 2) {
                String key = keyValue[0].trim();
                String value = keyValue[1].trim();
                
                switch (key) {
                    case "id":
                        user.setId(value);
                        break;
                    case "name":
                        user.setName(value);
                        break;
                    case "emailAddress":
                        user.setEmailAddress(value);
                        break;
                    case "role":
                        user.setRole(value);
                        break;
                    case "username":
                        user.setUsername(value);
                        break;
                    case "password":
                        user.setPassword(value);
                        break;
                }
            }
        }
        
        return user;
    }
    
    // Helper method to convert User to JSON
    private String convertToJson(User user) {
        return "{" +
               "\"id\":\"" + user.getId() + "\"," +
               "\"createdAt\":\"" + user.getCreatedAt() + "\"," +
               "\"name\":\"" + (user.getName() != null ? user.getName() : "") + "\"," +
               "\"emailAddress\":\"" + (user.getEmailAddress() != null ? user.getEmailAddress() : "") + "\"," +
               "\"role\":\"" + (user.getRole() != null ? user.getRole() : "") + "\"," +
               "\"username\":\"" + (user.getUsername() != null ? user.getUsername() : "") + "\"," +
               "\"password\":\"" + (user.getPassword() != null ? user.getPassword() : "") + "\"" +
               "}";
    }
    
    // Helper method to convert List<User> to JSON
    private String convertToJson(List<User> users) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < users.size(); i++) {
            json.append(convertToJson(users.get(i)));
            if (i < users.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}