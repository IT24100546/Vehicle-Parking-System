package com.parking.services;

import  com.parking.model.LocationModel;

import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


public class LocationService {
    private static final String DATA_FILE = "locations.txt";
    
    // Create a new location
    public LocationModel createLocation(LocationModel location) {
        try {
            // Generate ID and set creation time
            location.setId(UUID.randomUUID().toString());
            location.setCreatedAt(LocalDateTime.now());
            
            // Get existing locations
            List<LocationModel> locations = getAllLocations();
            
            // Add new location
            locations.add(location);
            
            // Save all locations
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
            List<LocationModel> locations = getAllLocations();
            
            return locations.stream()
                    .filter(loc -> loc.getId().equals(id))
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            System.err.println("Error getting location by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Get all locations
    public List<LocationModel> getAllLocations() {
        List<LocationModel> locations = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(DATA_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                LocationModel location = parseLocation(line);
                if (location != null) {
                    locations.add(location);
                }
            }
        } catch (FileNotFoundException e) {
            // File doesn't exist yet, return empty list
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
            List<LocationModel> locations = getAllLocations();
            
            boolean found = false;
            for (int i = 0; i < locations.size(); i++) {
                if (locations.get(i).getId().equals(updatedLocation.getId())) {
                    // Preserve creation time
                    LocalDateTime createdAt = locations.get(i).getCreatedAt();
                    updatedLocation.setCreatedAt(createdAt);
                    
                    // Replace the old location with updated one
                    locations.set(i, updatedLocation);
                    found = true;
                    break;
                }
            }
            
            if (found) {
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
            List<LocationModel> locations = getAllLocations();
            
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
    
    // Helper method to save locations to file
    private void saveLocations(List<LocationModel> locations) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_FILE))) {
            for (LocationModel location : locations) {
                writer.write(formatLocation(location));
                writer.newLine();
                System.out.println("Saved location: " + DATA_FILE+location);
            }
        }
    }
    
    // Helper method to format location as a string for storage
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
    
    // Helper method to parse location from a string
    private LocationModel parseLocation(String line) {
        try {
            String[] parts = line.split("\\|");
            if (parts.length != 6) {
                return null;
            }
            
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
}