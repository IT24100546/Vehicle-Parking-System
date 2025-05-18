
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart Park - Home</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome (via CDN) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Alpine.js -->
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<!-- Header -->
<header class="bg-blue-100 shadow-md">
    <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
        <div class="text-4xl font-bold text-blue-800">
            Smart Park
        </div>
        <nav class="space-x-4">
            <a href="Register.jsp" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                <i class="fas fa-user-plus"></i> Register
            </a>
            <a href="login.jsp" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                <i class="fas fa-sign-in-alt"></i> Login
            </a>
        </nav>
    </div>
</header>

<!-- Hero Section with Slider -->
<section class="relative w-full mt-6" x-data="{ current: 0, images: ['images/car1.jpg', 'images/car2.jpg'] }">
    <div class="overflow-hidden rounded-lg shadow-lg">
        <template x-for="(image, index) in images" :key="index">
            <div x-show="current === index" class="relative w-full h-96">
                <img :src="image" alt="Car Image"
                     class="w-full h-full object-cover transition duration-700 ease-in-out">
                <div class="absolute inset-0 bg-black bg-opacity-50 flex items-center px-4 md:px-10">
                    <div class="text-white">
                        <template x-if="index === 0">
                            <div>
                                <h1 class="text-3xl md:text-4xl font-bold mb-2">"Smart Parking Starts Here"</h1>
                                <p class="text-lg">Efficient, stress-free parking solutions for modern drivers.</p>
                            </div>
                        </template>
                        <template x-if="index === 1">
                            <div>
                                <h1 class="text-3xl md:text-4xl font-bold mb-2">"Less Time Parking, More Time Living"</h1>
                                <p class="text-lg">Make every minute count with our smart vehicle parking system.</p>
                            </div>
                        </template>
                    </div>
                </div>
            </div>
        </template>
    </div>

    <div class="absolute inset-0 flex items-center justify-between px-4">
        <button @click="current = (current === 0) ? images.length - 1 : current - 1"
                class="bg-white bg-opacity-75 hover:bg-opacity-100 text-xl rounded-full p-2 shadow">
            &#10094;
        </button>
        <button @click="current = (current === images.length - 1) ? 0 : current + 1"
                class="bg-white bg-opacity-75 hover:bg-opacity-100 text-xl rounded-full p-2 shadow">
            &#10095;
        </button>
    </div>

    <div class="flex justify-center mt-2 space-x-2">
        <template x-for="(image, index) in images" :key="index">
            <button @click="current = index"
                    :class="{'bg-blue-500': current === index, 'bg-gray-300': current !== index}"
                    class="w-3 h-3 rounded-full transition duration-300"></button>
        </template>
    </div>
</section>

<!-- Welcome Section -->
<section class="max-w-7xl mx-auto px-4 py-10 text-center">
    <h2 class="text-3xl font-bold text-blue-600 mb-4">Welcome to Smart Park</h2>
    <p class="text-gray-700 text-lg">Manage your vehicle parking with ease and security.</p>
</section>

<!-- About Us Section (includes features) -->
<section id="about" class="py-16 relative bg-cover bg-center text-white" style="background-image: url('${pageContext.request.contextPath}/images/parking4.jpg');">
    <div class="container mx-auto text-center px-6">
        <div class="absolute inset-0 bg-black bg-opacity-5"></div>
        <div class="bg-black bg-opacity-50 p-10 rounded-lg shadow-lg relative">
            <h2 class="text-4xl font-extrabold mb-6 uppercase tracking-wide text-green-400">About Us</h2>
            <p class="text-lg leading-relaxed max-w-3xl mx-auto mb-10">
                🚗 Welcome to Smart-Park, where innovation meets convenience! We understand that parking can be a challenge in busy urban areas, and that’s why we’ve designed a cutting-edge Vehicle Parking Management System to simplify your experience.
            </p>

            <!-- Feature Part -->
            <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Feature 1 -->
                <div class="relative rounded-lg shadow overflow-hidden h-[400px]">
                    <img src="images/easy_parking.jpg" alt="Easy Parking" class="absolute inset-0 w-full h-full object-cover opacity-100 z-0">
                    <div class="relative z-10 h-full flex flex-col justify-center items-center px-6 text-center">
                        <div class="bg-black bg-opacity-40 p-4 rounded-lg">
                            <i class="fas fa-car text-white text-5xl mb-3 font-bold"></i>
                            <h3 class="text-3xl font-bold text-white mb-2">Easy Parking</h3>
                            <p class="text-white text-lg font-medium">Find and manage parking slots efficiently.</p>
                        </div>
                    </div>
                </div>

                <!-- Feature 2 -->
                <div class="relative rounded-lg shadow overflow-hidden h-[400px]">
                    <img src="images/secure_access.jpg" alt="Secure Access" class="absolute inset-0 w-full h-full object-cover opacity-100 z-0">
                    <div class="relative z-10 h-full flex flex-col justify-center items-center px-6 text-center">
                        <div class="bg-black bg-opacity-40 p-4 rounded-lg">
                            <i class="fas fa-lock text-white text-5xl mb-3 font-bold"></i>
                            <h3 class="text-3xl font-bold text-white mb-2">Secure Access</h3>
                            <p class="text-white text-lg font-medium">User login ensures secure access and tracking.</p>
                        </div>
                    </div>
                </div>

                <!-- Feature 3 -->
                <div class="relative rounded-lg shadow overflow-hidden h-[400px]">
                    <img src="images/real_time_entry.jpg" alt="Real-time Entry" class="absolute inset-0 w-full h-full object-cover opacity-100 z-0">
                    <div class="relative z-10 h-full flex flex-col justify-center items-center px-6 text-center">
                        <div class="bg-black bg-opacity-40 p-4 rounded-lg">
                            <i class="fas fa-clock text-white text-5xl mb-3 font-bold"></i>
                            <h3 class="text-3xl font-bold text-white mb-2">Real-time Entry</h3>
                            <p class="text-white text-lg font-medium">Track vehicle entry and exit in real-time.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-10 mt-16">
    <div class="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-3 gap-8 text-center md:text-left">
        <!-- About -->
        <div>
            <h3 class="text-2xl font-bold mb-2 text-blue-400">Smart Park</h3>
            <p class="text-gray-300 text-sm">Your reliable vehicle parking system that ensures smart, safe, and simple parking management.</p>
        </div>

        <!-- Quick Links -->
        <div>
            <h4 class="text-lg font-semibold mb-2">Quick Links</h4>
            <ul class="text-gray-300 space-y-1 text-sm">
                <li><a href="index.jsp" class="hover:text-white">Home</a></li>
                <li><a href="Register.jsp" class="hover:text-white">Register</a></li>
                <li><a href="login.jsp" class="hover:text-white">Login</a></li>
            </ul>
        </div>

        <!-- Contact + Social -->
        <div>
            <h4 class="text-lg font-semibold mb-2">Contact</h4>
            <p class="text-gray-300 text-sm">support@smartpark.com</p>
            <p class="text-gray-300 text-sm mt-1"><i class="fas fa-phone-alt mr-2"></i>+94 77 575 5145</p>
        </div>
    </div>

    <div class="mt-8 text-center text-gray-500 text-sm border-t border-gray-700 pt-4">
        &copy; 2025 Smart Park. All rights reserved.
    </div>
</footer>


</body>
</html>
