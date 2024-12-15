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

    /* Căn giữa ảnh sản phẩm */
    .product-img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      display: block;
      margin: 0 auto; /* Căn giữa ảnh */
    }
    /* Căn giữa các cột trong bảng */
    .table th, .table td {
      vertical-align: middle;
    }
  </style>
  <%
    // Lấy giỏ hàng từ session
    List<Product> products = null;
    Map<Integer, Integer> cart = (Map<Integer, Integer>) request.getAttribute("cart");
    if (cart == null) {
      cart = new HashMap<>();
    } else products = (List<Product>) request.getAttribute("products");

    long TotalPrice = (long) request.getAttribute("TotalPrice");
  %>
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

        <li class="nav-item">
          <a class="nav-link" href="#">Cá nhân</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="CartServlet?action=cart">Giỏ hàng</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Đăng xuất</a>
        </li>

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
  <table class="table table-bordered table-hover text-center">
    <thead class="table-dark">
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
        <form method="post" action="CartServlet?action=delete&id=<%=product.getId()%>">
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
    <strong class="row text-danger mx-5">Tổng giá<%=TotalPrice%> VND</strong>
    <a href="CartServlet?action=purchase" class="btn btn-success">Thanh toán</a>
  </div>
  <%
    }
  %>
</div>

<!-- Liên kết đến file JavaScript của Bootstrap -->


</body>
</html>
