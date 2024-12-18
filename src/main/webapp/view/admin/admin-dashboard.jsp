<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <!-- Liên kết đến Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>

        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40;
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
        }
        .nav-link {
            color: #fff;
            font-size: 1rem;
        }
        h1 {
            color: #343a40;
            text-align: left;
        }
        .table thead th {
            background-color: #343a40;
            color: #fff;
            text-align: center;
        }
        .table tbody td {
            text-align: center;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            transform: scale(1.1);
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-primary:focus {
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.5);
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .container {
            padding-top: 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/productservlet?action=showcomponent">
        <img class="logo" src="../asset/logo.png"> Minuce Store
    </a>
    <div class="navbar">
        <a class="nav-link" href="userservlet?action=getinfo">Cá nhân</a>
        <a class="nav-link" href="userservlet?action=logout">Đăng xuất</a>
    </div>
</nav>
<div class="container mt-5">
    <div class="header-container">
        <h1>Danh sách sản phẩm</h1>
        <!-- Nút Thêm Sản Phẩm -->
        <form action="productservlet" method="get">
            <input type="hidden" name="action" value="insert">
            <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
        </form>
    </div>
    <!-- Bảng sản phẩm -->
    <table class="table table-striped table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Trạng thái</th>
            <th>Mô tả</th>
            <th>Giá</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.state}</td>
                <td>${product.description}</td>
                <td>${product.price}</td>
                <td>
                    <a href="productservlet?action=update&id=${product.id}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="productservlet?action=delete&id=${product.id}" class="btn btn-danger btn-sm">Ngưng bán</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- Liên kết đến Bootstrap JS và các phụ thuộc -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
