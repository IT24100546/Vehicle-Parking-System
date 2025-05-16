import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payment;
import utils.handlePayment;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AdminPaymentServlet")
public class AdminPaymentServlet extends HttpServlet {
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String paymentId = request.getParameter("paymentId");

        try {
            if ("delete".equals(action)) {
                Payment paymentToDelete = paymentHandler.findPaymentById(paymentId);
                if (paymentToDelete != null) {
                    paymentHandler.removePayment(paymentToDelete);
                }
            }
            else if ("updateStatus".equals(action)) {
                String newStatus = request.getParameter("status");
                Payment paymentToUpdate = paymentHandler.findPaymentById(paymentId);
                if (paymentToUpdate != null) {
                    paymentToUpdate.setStatus(newStatus);
                    paymentHandler.saveToFile();
                }
            }

            response.sendRedirect("adminBilling.jsp");
        } catch (IOException e) {
            throw new ServletException("Error processing payment operation", e);
        }
    }
}