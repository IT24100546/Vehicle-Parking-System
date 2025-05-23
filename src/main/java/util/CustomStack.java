package util;

import model.ParkingSlot;
import java.util.EmptyStackException;
import java.util.Arrays;

public class CustomStack {
    private ParkingSlot[] elements;
    private int size;
    private static final int DEFAULT_CAPACITY = 10;

    public CustomStack() {
        this.elements = new ParkingSlot[DEFAULT_CAPACITY];
        this.size = 0;
    }

    public CustomStack(int initialCapacity) {
        if (initialCapacity <= 0) {
            throw new IllegalArgumentException("Initial capacity must be positive");
        }
        this.elements = new ParkingSlot[initialCapacity];
        this.size = 0;
    }

    public void push(ParkingSlot data) {
        ensureCapacity();
        elements[size++] = data;
    }

    public ParkingSlot pop() {
        if (isEmpty()) {
            throw new EmptyStackException();
        }
        ParkingSlot data = elements[--size];
        elements[size] = null;
        return data;
    }

    public ParkingSlot peek() {
        if (isEmpty()) {
            throw new EmptyStackException();
        }
        return elements[size - 1];
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int size() {
        return size;
    }

    private void ensureCapacity() {
        if (size == elements.length) {
            int newCapacity = elements.length * 2;
            elements = Arrays.copyOf(elements, newCapacity);
        }
    }
} 