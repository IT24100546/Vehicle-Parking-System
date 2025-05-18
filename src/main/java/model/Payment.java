package model;

public class Payment {
    protected String id;
    protected String vehicleNumber;
    protected String paymentType;
    protected double amount;
    protected String status;
    protected String timestamp;

    public Payment(String vehicleNumber, double amount, String status, String timestamp, String paymentType) {
        id = null;
        this.vehicleNumber = vehicleNumber;
        this.amount = amount;
        this.status = status;
        this.timestamp = timestamp;
        this.paymentType = paymentType;
    }

    public Payment(String id, String vehicleNumber, double amount, String status, String timestamp, String paymentType) {
        this.id = id;
        this.vehicleNumber = vehicleNumber;
        this.amount = amount;
        this.status = status;
        this.timestamp = timestamp;
        this.paymentType = paymentType;
    }

    // Getters and Setters
    public String getPaymentType() {return paymentType;}
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }

    public String processPayment() {
        return "Processed " + paymentType + " payment for vehicle " + getVehicleNumber() + " amounting to Rs. " + getAmount();
    }

    public String paymentToString() {
        return id + "|" + vehicleNumber + "|" + amount + "|" + status + "|" + timestamp + "|" + paymentType;
    }

    public Payment stringToPayment(String str) {
        String[] parts = str.split("\\|");
        if (parts.length != 6) {
            return null;
        } else {
            return new Payment(parts[0], parts[1], Double.parseDouble(parts[2]), parts[3], parts[4], parts[5]);
        }
    }

}