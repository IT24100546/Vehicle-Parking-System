package model;

import util.CustomStack;
import util.QuickSort;

import java.util.ArrayList;
import java.util.List;

public class ParkingLot {
    private List<ParkingSlot> allSlots;
    private CustomStack availableSlotsStack;
    private int capacity;

    public ParkingLot(int capacity) {
        this.capacity = capacity;
        this.allSlots = new ArrayList<>(capacity);
        this.availableSlotsStack = new CustomStack(capacity);
        for (int i = 0; i < capacity; i++) {
            ParkingSlot slot = new ParkingSlot(i + 1);
            allSlots.add(slot);
            availableSlotsStack.push(slot);
        }
    }

    public synchronized ParkingSlot parkVehicle(String vehicleNumber) {
        if (availableSlotsStack.isEmpty()) {
            return null;
        }
        ParkingSlot slot = availableSlotsStack.pop();
        slot.setOccupied(true);
        slot.setVehicleNumber(vehicleNumber);
        return slot;
    }

    public synchronized boolean leaveVehicle(int slotNumber) {
        if (slotNumber <= 0 || slotNumber > capacity) {
            return false;
        }
        ParkingSlot slot = allSlots.get(slotNumber - 1);
        if (!slot.isOccupied()) {
            return false;
        }
        slot.setOccupied(false);
        slot.setVehicleNumber(null);
        availableSlotsStack.push(slot);
        return true;
    }

    public List<ParkingSlot> getAllSlotsSortedByAvailability() {
        List<ParkingSlot> sortedSlots = new ArrayList<>(allSlots);
        QuickSort.sort(sortedSlots);
        return sortedSlots;
    }

    public List<ParkingSlot> getAllSlots() {
        return new ArrayList<>(allSlots);
    }

    public int getAvailableSlotCount(){
        return availableSlotsStack.size();
    }

     public int getCapacity(){
        return capacity;
    }
} 