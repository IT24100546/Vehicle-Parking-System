package com.parking.services;

import com.parking.model.LocationModel;

import java.io.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Stack;
import java.util.UUID;

public class LocationService {
    private static final String DATA_FILE = "locations.txt";

    // Create a new location
    public LocationModel createLocation(LocationModel location) {
        try {
            location.setId(UUID.randomUUID().toString());
            location.setCreatedAt(LocalDateTime.now());

            Stack<LocationModel> locations = getAllLocations();
            locations.push(location);

            quicksort(locations, 0, locations.size() - 1);  // Sort before saving

            saveLocations(locations);

            return location;
        } catch (Exception e) {
            System.err.println("Error creating location: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Get a location by ID
    public LocationModel getLocationById(String id) {
        try {
            Stack<LocationModel> locations = getAllLocations();

            for (LocationModel loc : locations) {
                if (loc.getId().equals(id)) {
                    return loc;
                }
            }

            return null;
        } catch (Exception e) {
            System.err.println("Error getting location by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Get all locations
    public Stack<LocationModel> getAllLocations() {
        Stack<LocationModel> locations = new Stack<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(DATA_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                LocationModel location = parseLocation(line);
                if (location != null) {
                    locations.push(location);
                }
            }
        } catch (FileNotFoundException e) {
            System.out.println("Locations file not found. Creating new file on next save.");
        } catch (Exception e) {
            System.err.println("Error reading locations: " + e.getMessage());
            e.printStackTrace();
        }

        return locations;
    }

    // Update a location
    public boolean updateLocation(LocationModel updatedLocation) {
        try {
            Stack<LocationModel> locations = getAllLocations();
            boolean found = false;

            for (int i = 0; i < locations.size(); i++) {
                if (locations.get(i).getId().equals(updatedLocation.getId())) {
                    updatedLocation.setCreatedAt(locations.get(i).getCreatedAt());
                    locations.set(i, updatedLocation);
                    found = true;
                    break;
                }
            }

            if (found) {
                quicksort(locations, 0, locations.size() - 1);
                saveLocations(locations);
                return true;
            }

            return false;
        } catch (Exception e) {
            System.err.println("Error updating location: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete a location
    public boolean deleteLocation(String id) {
        try {
            Stack<LocationModel> locations = getAllLocations();
            boolean removed = locations.removeIf(loc -> loc.getId().equals(id));

            if (removed) {
                saveLocations(locations);
                return true;
            }

            return false;
        } catch (Exception e) {
            System.err.println("Error deleting location: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private void saveLocations(Stack<LocationModel> locations) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_FILE))) {
            for (LocationModel location : locations) {
                writer.write(formatLocation(location));
                writer.newLine();
                System.out.println("Saved location: " + DATA_FILE + location);
            }
        }
    }

    private String formatLocation(LocationModel location) {
        return String.join("|",
                location.getId(),
                location.getCreatedAt().toString(),
                location.getName(),
                location.getSlotId(),
                location.getType(),
                String.valueOf(location.isAvailabilityStatus())
        );
    }

    private LocationModel parseLocation(String line) {
        try {
            String[] parts = line.split("\\|");
            if (parts.length != 6) return null;

            LocationModel location = new LocationModel();
            location.setId(parts[0]);
            location.setCreatedAt(LocalDateTime.parse(parts[1]));
            location.setName(parts[2]);
            location.setSlotId(parts[3]);
            location.setType(parts[4]);
            location.setAvailabilityStatus(Boolean.parseBoolean(parts[5]));

            return location;
        } catch (Exception e) {
            System.err.println("Error parsing location: " + e.getMessage());
            return null;
        }
    }

    // Custom quicksort for LocationModel by name (you can change the key)
    private void quicksort(Stack<LocationModel> stack, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(stack, low, high);
            quicksort(stack, low, pivotIndex - 1);
            quicksort(stack, pivotIndex + 1, high);
        }
    }

    private int partition(Stack<LocationModel> stack, int low, int high) {
        LocationModel pivot = stack.get(high);
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (stack.get(j).getName().compareToIgnoreCase(pivot.getName()) <= 0) {
                i++;
                LocationModel temp = stack.get(i);
                stack.set(i, stack.get(j));
                stack.set(j, temp);
            }
        }
        LocationModel temp = stack.get(i + 1);
        stack.set(i + 1, stack.get(high));
        stack.set(high, temp);
        return i + 1;
    }
}