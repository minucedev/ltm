<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận xóa sản phẩm</title>
    <!-- Liên kết đến Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f5ff; /* Tím nhạt nền */
            color: #4a148c; /* Tím đậm chữ */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        h1 {
            color: #6a1b9a; /* Tím đậm */
            text-align: center;
        }
        .container {
            background-color: #ffffff; /* Màu trắng */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        .mb-3 {
            border: 1px solid #b39ddb; /* Viền tím nhạt */
            border-radius: 5px;
            padding: 15px;
            background-color: #f8f9fa;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            transition: background-color 0.3s;
            width: 100%;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            width: 100%;
            margin-top: 10px;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .error {
            background-color: #ffebee; /* Đỏ nhạt */
            color: #d32f2f; /* Đỏ chữ */
            padding: 10px;
            border: 1px solid #e57373;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Xác nhận ngưng bán sản phẩm</h1>

    <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
    </c:if>

    <c:if test="${not empty product}">
        <div class="mb-3">
            <p><strong>ID:</strong> ${product.id}</p>
            <p><strong>Tên:</strong> ${product.name}</p>
            <p><strong>Trạng thái:</strong> ${product.state}</p>
            <p><strong>Mô tả:</strong> ${product.description}</p>
        </div>

        <form action="productservlet?action=delete" method="post" onsubmit="return confirmDelete()">
            <input type="hidden" name="id" value="${product.id}" />
            <button type="submit" class="btn btn-danger">Ngưng bán</button>
            <button type="button" class="btn btn-secondary" onclick="goBack()">Hủy</button>
        </form>
    </c:if>
</div>

<!-- Liên kết đến Bootstrap JS và các phụ thuộc -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function goBack() {
        window.history.back(); // Quay lại trang trước
    }

    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn ngưng bán sản phẩm này?"); // Hiển thị xác nhận xóa
    }
</script>
</body>
</html>
