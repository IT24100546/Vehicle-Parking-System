package com.app.parkingmanagement.vehicle_parking_management.dao;

import com.app.parkingmanagement.vehicle_parking_management.model.ParkingLogEntry;
import com.app.parkingmanagement.vehicle_parking_management.util.ParkingLogUtils;


import java.io.*;
import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

public class ParkingLogDAO {
    private static final String FILE_PATH = "C:\\226-parking\\parking_log.txt";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    static {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.createNewFile();  // Create the file if it doesn't exist
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //new entry
    public static void addEntry(ParkingLogEntry entry) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(entry.getVehicleNumber() + "," + entry.getEntryTime() + ",null,0.0");
            bw.newLine();
        }
    }

    // Get all entries
    public static List<ParkingLogEntry> getAllEntries() throws IOException {
        List<ParkingLogEntry> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                list.add(new ParkingLogEntry(parts[0], parts[1], parts[2], Double.parseDouble(parts[3])));
            }
        }
        return list;
    }

    // Update the exit time and the fee
    public static void updateExit(String vehicleNumber, String exitTime) throws IOException {
        List<ParkingLogEntry> entries = getAllEntries();
        for (ParkingLogEntry entry : entries) {
            if (entry.getVehicleNumber().equals(vehicleNumber) && entry.getExitTime().equals("null")) {
                entry.setExitTime(exitTime);

                LocalDateTime entryTimeObj = ParkingLogUtils.parseTime(entry.getEntryTime());
                LocalDateTime exitTimeObj = ParkingLogUtils.parseTime(exitTime);
                long minutes = Duration.between(entryTimeObj, exitTimeObj).toMinutes();
                double fee = ParkingLogUtils.calculateFee(minutes);

                entry.setFee(fee);
                break;
            }
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (ParkingLogEntry e : entries) {
                bw.write(e.getVehicleNumber() + "," + e.getEntryTime() + "," + e.getExitTime() + "," + e.getFee());
                bw.newLine();
            }
        }
    }


    // Delete a completed parking transaction from the log (Deletes every entry in same vehicle..Not used here)
    public static void deleteEntry(String vehicleNumber) throws IOException {
        List<ParkingLogEntry> entries = getAllEntries();
        entries.removeIf(entry -> entry.getVehicleNumber().equals(vehicleNumber) && !entry.getExitTime().equals("null"));

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (ParkingLogEntry e : entries) {
                bw.write(e.getVehicleNumber() + "," + e.getEntryTime() + "," + e.getExitTime() + "," + e.getFee());
                bw.newLine();
            }
        }
    }

    public static void saveAllEntries(List<ParkingLogEntry> entries) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (ParkingLogEntry entry : entries) {
                writer.write(entry.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}

