package model;

public class ParkingSlot {
    private int slotNumber;
    private boolean isOccupied;
    private String vehicleNumber;

    public ParkingSlot(int slotNumber) {
        this.slotNumber = slotNumber;
        this.isOccupied = false;
        this.vehicleNumber = null;
    }

    public int getSlotNumber() {
        return slotNumber;
    }

    public boolean isOccupied() {
        return isOccupied;
    }

    public void setOccupied(boolean occupied) {
        isOccupied = occupied;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    @Override
    public String toString() {
        return "ParkingSlot{" +
                "slotNumber=" + slotNumber +
                ", isOccupied=" + isOccupied +
                ", vehicleNumber='" + vehicleNumber + '\'' +
                '}';
    }
} 