<%@ page import="java.util.List" %>
<%@ page import="model.bean.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Giỏ hàng</title>
  <!-- Liên kết đến file CSS của Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <style>
    body {
      background-color: #f8f9fa;
    }
    .navbar {
      background-color: #FF885B; /* Orange navbar */
      display: flex;
      justify-content: space-between;
    }
    .navbar-brand {
      color: #fff;
      font-size: 1.5rem;
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
      color: #fff;
      font-size: 1rem;
      font-weight: bold;
      padding: 10px 20px;
      margin-right: 15px; /* Increased spacing between buttons */
      border-radius: 5px;
      transition: background-color 0.3s ease, transform 0.3s ease;
    }
    .nav-link:hover {
      background-color: #FF7043; /* Orange similar to navbar */
      color: #ffffff;
      transform: scale(1.1);
    }

    /* Center product images */
    .product-img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      display: block;
      margin: 0 auto; /* Center the image */
    }

    /* Center table columns */
    .table th, .table td {
      vertical-align: middle;
    }

    .btn-danger {
      background-color: #FF5733; /* Red-orange */
      border: none;
      transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .btn-danger:hover {
      background-color: #FF7043; /* Orange similar to navbar */
      transform: scale(1.1);
    }

    .btn-success {
      background-color: #007bff; /* Blue */
      border: none;
      transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .btn-success:hover {
      background-color: #0056b3; /* Darker blue */
      transform: scale(1.1);
    }

    .alert-warning {
      background-color: #ffc107; /* Yellow */
      color: #212529;
    }
  </style>
  <%
    // Fetch cart from session
    List<Product> products = null;
    Map<Integer, Integer> cart = (Map<Integer, Integer>) request.getAttribute("cart");
    if (cart == null) {
      cart = new HashMap<>();
    } else products = (List<Product>) request.getAttribute("products");

    long TotalPrice = (long) request.getAttribute("TotalPrice");
  %>
</head>

<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/productservlet">
      <img class="logo" src="../asset/logo.png"> Minuce Store
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="userservlet?action=getinfo">Cá nhân</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="CartServlet?action=cart">Giỏ hàng</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userservlet?action=logout">Đăng xuất</a>
        </li>
      </ul>
    </div>
  </div>
</nav>



<!-- Cart Table -->
<div class="container mt-5">
  <h1 class="text-center mb-4">Giỏ hàng của bạn</h1>
  <%
    if (cart.isEmpty()) {
  %>
  <div class="alert alert-warning text-center" role="alert">
    Giỏ hàng trống!
  </div>
  <%
  } else {
  %>
  <table class="table table-striped table-bordered text-center">
    <thead class="thead-dark">
    <tr>
      <th>STT</th>
      <th>Ảnh sản phẩm</th>
      <th>Tên sản phẩm</th>
      <th>Mô tả</th>
      <th>Giá</th>
      <th>Số lượng</th>
      <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <%
      int count = 1;
      for (Product product : products) {
    %>
    <tr>
      <td><%= count++ %></td>
      <td><img class="product-img" src="<%= product.getImage() %>" alt="<%= product.getName() %>" width="100"></td>
      <td><%= product.getName() %></td>
      <td><%= product.getDescription() %></td>
      <td><%= product.getPrice() %> VND</td>
      <td><%= cart.get(product.getId()) %></td>
      <td>
        <form method="post" action="CartServlet?action=delete&id=<%= product.getId() %>">
          <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
        </form>
      </td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
  <div class="d-flex justify-content-end">
    <strong class="row text-danger mx-5">Tổng giá: <%= TotalPrice %> VND</strong>
    <a href="CartServlet?action=purchase" class="btn btn-success">Thanh toán</a>
  </div>
  <%
    }
  %>
</div>

<!-- Liên kết đến file JavaScript của Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
