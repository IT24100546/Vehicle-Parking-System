package com.parking.util;

import com.parking.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {
    private static final String FILE_PATH = "C:\\Users\\User\\Desktop\\ParkingManagementSystemt";

    public void saveUser(User user) throws IOException {
        List<User> users = readUsers();
        users.add(user);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User u : users) {
                writer.write(u.getId() + "," + u.getUsername() + "," + u.getPassword() + "," + u.getEmail() + "," +
                        u.getPhoneNumber() + "," + u.getVehicleName() + "," + u.getVehicleNumber());
                writer.newLine();
            }
        }
    }

    public List<User> readUsers() throws IOException {
        List<User> users = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.createNewFile();
            return users;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 7) {
                    users.add(new User(Integer.parseInt(parts[0]), parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]));
                }
            }
        }
        return users;
    }

    public void updateUser(User updatedUser) throws IOException {
        List<User> users = readUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId() == updatedUser.getId()) {
                users.set(i, updatedUser);
                break;
            }
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User u : users) {
                writer.write(u.getId() + "," + u.getUsername() + "," + u.getPassword() + "," + u.getEmail() + "," +
                        u.getPhoneNumber() + "," + u.getVehicleName() + "," + u.getVehicleNumber());
                writer.newLine();
            }
        }
    }

    public void deleteUser(int userId) throws IOException {
        List<User> users = readUsers();
        users.removeIf(user -> user.getId() == userId);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User u : users) {
                writer.write(u.getId() + "," + u.getUsername() + "," + u.getPassword() + "," + u.getEmail() + "," +
                        u.getPhoneNumber() + "," + u.getVehicleName() + "," + u.getVehicleNumber());
                writer.newLine();
            }
        }
    }

    public int generateId() throws IOException {
        List<User> users = readUsers();
        return users.isEmpty() ? 1 : users.get(users.size() - 1).getId() + 1;
    }
}