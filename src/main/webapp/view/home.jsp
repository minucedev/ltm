<%@ page import="java.util.List" %>
<%@ page import="model.bean.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trang sản phẩm</title>
  <!-- Liên kết đến file CSS của Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <style>
    body {
      background-color: #FFE5CF; /* Light cream background */
      color: #33372C; /* Dark green text */
      font-family: 'Arial', sans-serif;
    }

    .navbar {
      background-color: #FF885B; /* Orange navbar */
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

    .card {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border: none;
      border-radius: 10px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      background-color: rgba(255, 255, 255, 0.9);
    }

    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    .card-img-top {
      width: 100%;
      height: 250px;
      object-fit: cover;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
    }

    .btn-success {
      background-color: #557C56; /* Dark green button */
      border: none;
      transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .btn-success:hover {
      background-color: #FF7043; /* Orange color similar to navbar on hover */
      transform: scale(1.1);
    }

    .input-group {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .alert {
      background-color: #FFD1B8; /* Light orange alert */
      color: #33372C;
      border: 1px solid #FF885B;
    }

  </style>

</head>

<body>

<!-- Thanh điều hướng -->
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
        <%
          Boolean isLoggedIn = (Boolean) request.getAttribute("isLoggedIn");
          if (isLoggedIn != null && isLoggedIn) {
        %>
        <li class="nav-item">
          <a class="nav-link" href="userservlet?action=getinfo">Cá nhân</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="CartServlet?action=cart">Giỏ hàng</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userservlet?action=logout">Đăng xuất</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link" href="view/login.jsp">Đăng nhập</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="view/login.jsp?type=register">Đăng ký</a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<!-- Thanh tìm kiếm -->
<form class="container my-4" method="POST" action="productservlet?action=search">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="input-group">
        <input type="text" class="form-control" id="search" name="keyword" value="<%=(request.getAttribute("keyword")!=null)?request.getAttribute("keyword"):""%>" placeholder="Tìm kiếm sản phẩm...">
        <button class="btn btn-primary" id="search-btn" type="submit" style="background-color: #FF885B; border-color: #FF885B;">Tìm kiếm</button>
      </div>
    </div>
  </div>
</form>

<div id="notification" class="alert alert-info" style="display: none;"></div>

<!-- Trang sản phẩm -->
<div class="container my-4">
  <div class="row">
    <%
      List<Product> products = (List<Product>) request.getAttribute("products");
      if (products != null) {
        for (Product product : products) {
    %>
    <div class="col-md-3 mb-4">
      <div class="card h-100">
        <img src="<%= product.getImage() %>" class="card-img-top" alt="<%= product.getName() %>">
        <div class="card-body d-flex flex-column text-center">
          <h5 class="card-title"><%= product.getName() %></h5>
          <strong class="card-text text-danger"><%= product.getPrice() %> đ</strong>
          <p class="card-text flex-grow-1"><%= product.getDescription() %></p>
          <div class="d-flex justify-content-center mt-auto">
            <button onclick="addToCart(<%= product.getId() %>)" class="btn btn-success">Thêm vào giỏ hàng</button>
          </div>
        </div>
      </div>
    </div>
    <%
        }
      }
    %>
  </div>
</div>

<!-- Liên kết đến file JavaScript của Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function addToCart(id) {
    var quantity = 1;
    $.ajax({
      url: "CartServlet",
      type: "POST",
      data: { productId: id, quantity: quantity, action: "addToCart" },
      success: function(response) {
        alert("Thêm vào giỏ hàng thành công ");
      },
      error: function(xhr) {
        if (xhr.status === 401) {
          window.location.href = "view/login.jsp";
        } else {
          alert("Lỗi: " + xhr.responseText);
        }
      }
    });
  }
</script>

</body>
