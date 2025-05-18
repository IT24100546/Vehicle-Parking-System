import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payment;

import java.io.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@WebServlet("/billingHistory")
public class BillingHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String vehicleNumber = request.getParameter("vehicleNumber");
        request.getRequestDispatcher("/billingHistory.jsp").forward(request, response);
    }
}