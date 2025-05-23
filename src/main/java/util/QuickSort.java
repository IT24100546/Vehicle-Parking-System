package util;

import model.ParkingSlot;
import java.util.List;

public class QuickSort {

    public static void sort(List<ParkingSlot> slots) {
        if (slots == null || slots.size() <= 1) {
            return;
        }
        quickSort(slots, 0, slots.size() - 1);
    }

    private static void quickSort(List<ParkingSlot> slots, int low, int high) {
        if (low < high) {
            int pi = partition(slots, low, high);
            quickSort(slots, low, pi - 1);
            quickSort(slots, pi + 1, high);
        }
    }

    private static int partition(List<ParkingSlot> slots, int low, int high) {
        ParkingSlot pivot = slots.get(high);
        int i = (low - 1);

        for (int j = low; j < high; j++) {
            ParkingSlot current = slots.get(j);

            if (!current.isOccupied() && pivot.isOccupied()) {
                i++;
                swap(slots, i, j);
            }

            else if (current.isOccupied() == pivot.isOccupied()) {
                if (current.getSlotNumber() < pivot.getSlotNumber()) {
                    i++;
                    swap(slots, i, j);
                }
            }
        }
        swap(slots, i + 1, high);
        return i + 1;
    }

    private static void swap(List<ParkingSlot> slots, int i, int j) {
        ParkingSlot temp = slots.get(i);
        slots.set(i, slots.get(j));
        slots.set(j, temp);
    }
} 