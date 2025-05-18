package com.app.parkingmanagement.vehicle_parking_management.model;

public class ParkingLogEntry {
    private String vehicleNumber;
    private String entryTime;
    private String exitTime;
    private double fee;

    public ParkingLogEntry(String vehicleNumber, String entryTime, String exitTime, double fee) {
        this.vehicleNumber = vehicleNumber;
        this.entryTime = entryTime;
        this.exitTime = exitTime;
        this.fee = fee;
    }

    public ParkingLogEntry(String vehicleNumber, String entryTime) {
        this(vehicleNumber, entryTime, null, 0.0);
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(String entryTime) {
        this.entryTime = entryTime;
    }

    public String getExitTime() {
        return exitTime;
    }

    public void setExitTime(String exitTime) {
        this.exitTime = exitTime;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    @Override
    public String toString() {
        return getVehicleNumber() + "," + getEntryTime() + "," + getExitTime() + "," + getFee();
    }


}

