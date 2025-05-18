import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payment;
import utils.handlePayment;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private handlePayment paymentHandler;

    @Override
    public void init() throws ServletException {
        paymentHandler = new handlePayment();
        try {
            paymentHandler.loadFromFile();
        } catch (IOException e) {
            throw new ServletException("Error loading payment data", e);
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String vehicleNumber = request.getParameter("vehicleNumber");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String paymentType = request.getParameter("paymentType");
        String status = "Pending";

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String timestamp = formatter.format(new Date());

        Payment payment = new Payment(vehicleNumber, amount, status, timestamp, paymentType);
        paymentHandler.addPayment(payment);
        request.setAttribute("message", payment.processPayment());

        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }
}