<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.Review" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <title>All Reviews</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-900 max-w-4xl mx-auto p-6">
<h1 class="text-3xl font-bold mb-6 text-center">All Reviews</h1>

<div class="space-y-4">
  <%
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    if (reviews != null && !reviews.isEmpty()) {
      for (Review r : reviews) {
  %>
  <div class="border p-4 rounded bg-white shadow">
    <p><strong>Email:</strong> <%= r.getEmail() %></p>
    <p><strong>Target:</strong> <%= r.getReviewTarget() %> - ID: <%= r.getTargetId() %></p>
    <p><strong>Rating:</strong> <%= r.getRating() %> ★</p>
    <p><strong>Review:</strong> <%= r.getContent() %></p>
    //Hiiiiiiiiiii
  </div>
  <%
    }
  } else {
  %>
  <p>No reviews found.</p>
  <% } %>
</div>

<div class="mt-6 text-center">
  <a href="review.jsp" class="text-blue-600 underline">Back to Submit Review</a>
</div>
</body>
</html>
