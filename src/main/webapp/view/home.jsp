<%@ page import="java.util.List" %>
<%@ page import="model.bean.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    .card-img-top {
      width: 100%;
      height: 250px;
      object-fit: cover;
    }
  </style>
</head>

<body>

<!-- Thanh điều hướng -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Shop</a>
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
          <a class="nav-link" href="#">Cá nhân</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="CartServlet?action=cart">Giỏ hàng</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Đăng xuất</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link" href="#">Đăng nhập</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="view/register-form.jsp">Đăng ký</a>
        </li>
        <% } %>

      </ul>
    </div>
  </div>
</nav>

<!-- Thanh tìm kiếm -->
<form class="container my-4" method="POST" action="#">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="input-group">
        <input type="text" class="form-control" id="search" placeholder="Tìm kiếm sản phẩm...">
        <button class="btn btn-primary" id="search-btn">Tìm kiếm</button>
      </div>
    </div>
  </div>
</form>
<div id="notification" class="alert alert-info" style="display: none;"></div>
<!-- Trang sản phẩm -->
<div class="container my-4">
  <div class="row">

    <%
      // Giả sử danh sách sản phẩm được truyền từ Servlet hoặc một lớp khác
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
    // Gửi yêu cầu AJAX đến servlet
    $.ajax({
      url: "CartServlet",
      type: "POST",
      data: { productId: id, quantity: quantity, action: "addToCart" },
      success: function(response) {
        alert("Thêm vào giỏ hàng thành công ");
      },
      error: function(xhr) {
        if (xhr.status === 401) {
          // Chuyển hướng đến trang đăng nhập
          window.location.href = "view/login.jsp";
        } else {

          alert("Lỗi: " + xhr.responseText);
        }
      }
    });
  }
</script>

</body>
</html>
