package com.app.parkingmanagement.vehicle_parking_management.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ParkingLogUtils {

    //Method to convert String to LocalDateTime
    public static LocalDateTime parseTime(String time) {
        return LocalDateTime.parse(time, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    //Method to calculate parking fee based on duration
    public static double calculateFee(long durationInMinutes) {
        return durationInMinutes * 2.5;  // 2.5 rupees per minute  =  150/= for a hour
    }
}
