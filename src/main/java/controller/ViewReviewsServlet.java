package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

public class ViewReviewsServlet extends HttpServlet {
    private String FILE_PATH;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        FILE_PATH = context.getRealPath("/dataBase/review.txt");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Review> reviews = new ArrayList<>();

        Path path = Paths.get(FILE_PATH);
        if (Files.exists(path)) {
            List<String> lines = Files.readAllLines(path);
            for (String line : lines) {
                Review review = Review.fromString(line);
                if (review != null) reviews.add(review);
            }
        }

        request.setAttribute("reviews", reviews);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/viewReviews.jsp");
        dispatcher.forward(request, response);
    }
}
