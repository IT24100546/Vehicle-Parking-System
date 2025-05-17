package utils;

import model.Payment;

import java.io.*;
import java.util.LinkedList;

public class handlePayment {
    private LinkedList<Payment> payments = new LinkedList<>();
    private final String FILE_PATH = "D:\\OOP_Project_Payment\\Data\\payments.txt";
    private int lastPaymentId = 0;

    private String generatePaymentId() {
        lastPaymentId++;
        return String.format("PAY%04d", lastPaymentId);
    }

    public LinkedList<Payment> getPayments() {
        return payments;
    }

    public void addPayment(Payment payment) throws IOException {
        if (payment == null) {
            throw new IllegalArgumentException("Order cannot be null");
        }

        if (payment.getId() == null || payment.getId().isEmpty()) {
            payment.setId(generatePaymentId());
        }

        payments.add(payment);
        saveToFile();
    }

    public void pay(String paymentId) throws IOException {
        Payment payment = findPaymentById(paymentId);
        if (payment != null) {
            payment.setStatus("PAID");
        }

        saveToFile();

    }

    public void removePayment(Payment payment) throws IOException {
        if (payment == null) {
            throw new IllegalArgumentException("Order cannot be null");
        }

        payments.remove(payment);
        saveToFile();
    }

    public Payment findPaymentById(String paymentId) {
        for (Payment payment : payments) {
            if (payment.getId().equals(paymentId)) {
                return payment;
            }
        }
        return null;
    }

    public void saveToFile() throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Payment payment : payments) {
                writer.write(payment.paymentToString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving orders to file: " + e.getMessage());
            e.printStackTrace();
        }

    }

    public void loadFromFile() throws IOException {
        File file = new File(FILE_PATH);

        // Create file if doesn't exist
        if (!file.exists()) {
            file.createNewFile();
            return;
        }

        payments.clear();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                   if (parts.length == 6) {
                       Payment payment = new Payment(parts[0], parts[1], Double.parseDouble(parts[2]), parts[3], parts[4], parts[5]);
                       payments.add(payment);
                       updateLastPaymentId(payment);
                   } else {
                       System.out.println("Invalid order line: " + line);
                   }

            }
        }
    }

    private void updateLastPaymentId(Payment payment) {
        String idNumStr = payment.getId().replace("PAY", "");
        int idNum = Integer.parseInt(idNumStr);
        lastPaymentId = Math.max(lastPaymentId, idNum);
    }

}
