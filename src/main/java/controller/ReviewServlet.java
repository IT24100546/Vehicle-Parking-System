package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;

public class ReviewServlet extends HttpServlet {
    private String FILE_PATH;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        FILE_PATH = context.getRealPath("/dataBase/review.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String reviewTarget = request.getParameter("reviewTarget");
        String targetId = request.getParameter("targetId");
        String content = request.getParameter("content");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Review review = new Review(email, reviewTarget, targetId, content, rating);

        Path filePath = Paths.get(FILE_PATH);
        Files.createDirectories(filePath.getParent()); // Create parent folder if missing

        try (BufferedWriter writer = Files.newBufferedWriter(filePath, StandardOpenOption.CREATE, StandardOpenOption.APPEND)) {
            writer.write(review.toString());
            writer.newLine();
        }

        response.sendRedirect(request.getContextPath() + "/viewReviews");
    }
}
