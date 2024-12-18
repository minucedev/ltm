<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <!-- Liên kết đến Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../asset/admin.css" rel="stylesheet">


</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/productservlet?action=showcomponent">
        <img class="logo" src="../asset/logo.png"> Minuce Store
    </a>
    <div class="navbar">
        <a class="nav-link" href="/userservlet?action=alluser">Danh sách khách hàng</a>
        <a class="nav-link" href="/OrderServlet">Lịch sử bán hàng</a>
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
    <table class="table ">
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
