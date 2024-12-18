<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <!-- Liên kết đến file CSS của Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #E8D9C3; /* Softer background color */
            font-family: 'Roboto', 'Arial', sans-serif; /* Include fallback fonts */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #FFFFFF; /* White background for the container */
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            max-width: 600px;
            margin: auto;
        }

        h1 {
            color: #FF5733; /* Vibrant red-orange */
            font-size: 32px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #FF885B; /* Bright orange */
            color: white;
            padding: 10px;
            text-align: center;
        }

        td {
            background-color: #FFD1B8; /* Light orange */
            color: #33372C; /* Dark green text */
            padding: 10px;
            text-align: center;
            border: 1px solid #FF885B; /* Orange border */
        }

        .alert {
            background-color: #FFD1B8; /* Light orange */
            color: #33372C; /* Dark green text */
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #FF5733; /* Vibrant red-orange */
            border: none;
            padding: 10px 20px;
            color: white;
            font-size: 18px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #FF7043; /* Slightly darker orange */
            transform: scale(1.1);
        }

        a {
            color: white;
            text-decoration: none;
        }

        .navbar {
            background-color: #FF885B; /* Orange navbar */
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            color: #ffffff;
            display: flex;
            align-items: center;
        }

        .navbar-brand .logo {
            width: 40px;
            height: 40px;
            margin-right: 10px;
            border-radius: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .navbar-brand .logo:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .nav-link {
            color: #ffffff;
            font-weight: bold;
            padding: 10px 20px;
            margin-right: 15px; /* Increased spacing between buttons */
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .nav-link:hover {
            background-color: #FF7043; /* Orange color similar to navbar on hover */
            color: #ffffff;
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<!-- Thông tin cá nhân -->
<div class="container">
    <h1>Thông tin cá nhân</h1>
    <c:if test="${not empty user}">
        <table class="table table-bordered">
            <tr>
                <th>Username</th>
                <td>${user.username}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>${user.email}</td>
            </tr>
            <tr>
                <th>Role</th>
                <td>${user.role}</td>
            </tr>
        </table>
    </c:if>
    <c:if test="${empty user}">
        <div class="alert alert-warning" role="alert">
            Người dùng không được tìm thấy!
        </div>
    </c:if>
    <button onclick="window.history.back()" class="btn btn-primary">Quay lại trang trước</button>
</div>

<!-- Liên kết đến file JavaScript của Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
