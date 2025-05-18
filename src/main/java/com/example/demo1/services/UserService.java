package com.example.demo1.services;

import com.example.demo1.models.User;
import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class UserService {
    private static final String FILE_PATH = "users.txt";
    
    // Ensure file exists before operations
    private void ensureFileExists() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Create a new user
    public void createUser(User user) {
        ensureFileExists();
        // Generate ID if not set
        user.setId(UUID.randomUUID().toString());
        // Set creation time if not set
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(userToLine(user));
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // Get all users
    public List<User> getAllUsers() {
        ensureFileExists();
        List<User> users = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        users.add(lineToUser(line));
                    } catch (Exception e) {
                        System.err.println("Error parsing user line: " + line);
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    // Get user by ID
    public User getUserById(String id) {
        ensureFileExists();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        User user = lineToUser(line);
                        if (user.getId().equals(id)) {
                            return user;
                        }
                    } catch (Exception e) {
                        System.err.println("Error parsing user line: " + line);
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get user by username
    public User getUserByUsername(String username) {
        ensureFileExists();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        User user = lineToUser(line);
                        if (user.getUsername().equals(username)) {
                            return user;
                        }
                    } catch (Exception e) {
                        System.err.println("Error parsing user line: " + line);
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Update an existing user
    public boolean updateUser(User updatedUser) {
        ensureFileExists();
        List<User> users = getAllUsers();
        boolean userFound = false;
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                if (user.getId().equals(updatedUser.getId())) {
                    // Preserve creation time
                    updatedUser.setCreatedAt(user.getCreatedAt());
                    writer.write(userToLine(updatedUser));
                    userFound = true;
                } else {
                    writer.write(userToLine(user));
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        return userFound;
    }
    
    // Delete a user
    public boolean deleteUser(String id) {
        ensureFileExists();
        List<User> users = getAllUsers();
        boolean userFound = false;
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                if (!user.getId().equals(id)) {
                    writer.write(userToLine(user));
                    writer.newLine();
                } else {
                    userFound = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        return userFound;
    }
    
    // Convert User object to a line of text
    private String userToLine(User user) {
        return String.join(",", 
            user.getId(),
            user.getCreatedAt().toString(),
            user.getName() != null ? user.getName() : "",
            user.getEmailAddress() != null ? user.getEmailAddress() : "",
            user.getRole() != null ? user.getRole() : "",
            user.getUsername() != null ? user.getUsername() : "",
            user.getPassword() != null ? user.getPassword() : ""
        );
    }
    
    // Convert a line of text to User object
    private User lineToUser(String line) {
        String[] parts = line.split(",");
        User user = new User();
        
        if (parts.length >= 7) {
            user.setId(parts[0]);
            user.setCreatedAt(LocalDateTime.parse(parts[1]));
            user.setName(parts[2]);
            user.setEmailAddress(parts[3]);
            user.setRole(parts[4]);
            user.setUsername(parts[5]);
            user.setPassword(parts[6]);
        } else {
            throw new IllegalArgumentException("Invalid user data format: " + line);
        }
        
        return user;
    }
}