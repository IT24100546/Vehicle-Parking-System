<%--
  Created by IntelliJ IDEA.
  User: ip
  Date: 5/16/2025
  Time: 3:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><!DOCTYPE html>
      <html lang="en">
      <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Parking Management System</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    .star:hover,
    .star.hovered,
    .star.selected {
      color: #FFD700 !important;
    }
  </style>
</head>
<body class="bg-light text-dark max-w-3xl mx-auto p-5 font-sans">

<h1 class="text-3xl font-bold text-center text-primary mb-8">Parking Management System</h1>

<div class="bg-secondary p-6 rounded-lg shadow mb-6">
  <h2 class="text-xl font-semibold text-primary mb-4">Submit a Review</h2>
  <form action="${pageContext.request.contextPath}/review" method="post" class="space-y-4">

    <div>
      <label for="email" class="block text-primary font-semibold mb-1">Your Email:</label>
      <input type="email" id="email" name="email" required class="w-full p-2 border border-primary rounded bg-light text-dark"/>
    </div>

    <div>
      <label for="reviewTarget" class="block text-primary font-semibold mb-1">What are you reviewing?</label>
      <select id="reviewTarget" name="reviewTarget" required class="w-full p-2 border border-primary rounded bg-light text-dark">
        <option value="">-- Please choose an option --</option>
        <option value="Parking Lot">Parking Lot</option>
        <option value="Parking Staff">Parking Staff</option>
        <option value="Facilities">Facilities</option>
        <option value="Security">Security</option>
        <option value="Other">Other</option>
      </select>
    </div>

    <div>
      <label for="targetId" class="block text-primary font-semibold mb-1">Target ID:</label>
      <input type="text" id="targetId" name="targetId" placeholder="e.g. Parking Lot ID" required class="w-full p-2 border border-primary rounded bg-light text-dark"/>
    </div>

    <div>
      <label for="content" class="block text-primary font-semibold mb-1">Your Review:</label>
      <textarea id="content" name="content" rows="3" required class="w-full p-2 border border-primary rounded bg-light text-dark resize-y"></textarea>
    </div>

    <div>
      <label class="block text-primary font-semibold mb-1">Rating:</label>
      <div id="stars" class="flex text-2xl space-x-1 text-gray-300 cursor-pointer">
        <span class="star" data-value="1"><i class="bi bi-star"></i>  </span>
        <span class="star" data-value="2"><i class="bi bi-star"></i>  </span>
        <span class="star" data-value="3"><i class="bi bi-star"></i>  </span>
        <span class="star" data-value="4"><i class="bi bi-star"></i>  </span>
        <span class="star" data-value="5"><i class="bi bi-star"></i>  </span>
      </div>
      <input type="hidden" name="rating" id="rating" required />
    </div>

    <button type="submit" class="bg-primary text-light px-5 py-3 rounded font-bold hover:bg-dark transition">
      Submit Review
    </button>
  </form>

  <div class="mt-4">
    <a href="${pageContext.request.contextPath}/viewReviews" class="text-primary underline">View All Reviews</a>
  </div>
</div>

<script>
  const stars = document.querySelectorAll('.star');
  const ratingInput = document.getElementById('rating');
  let selectedRating = 0;

  stars.forEach(star => {
    star.addEventListener('mouseenter', () => {
      resetStars();
      highlightStars(star.dataset.value);
    });

    star.addEventListener('mouseleave', () => {
      resetStars();
      if (selectedRating > 0) highlightStars(selectedRating);
    });

    star.addEventListener('click', () => {
      selectedRating = star.dataset.value;
      ratingInput.value = selectedRating;
      highlightStars(selectedRating);
    });
  });

  function highlightStars(value) {
    stars.forEach(star => {
      if (star.dataset.value <= value) {
        star.classList.add('selected');
      }
    });
  }

  function resetStars() {
    stars.forEach(star => star.classList.remove('selected'));
  }
</script>

</body>
</html>
</title>
</head>
<body>

</body>
</html>
