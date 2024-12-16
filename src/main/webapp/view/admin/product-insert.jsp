<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Insert Product</title>
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
        form {
            background-color: #ffffff; /* Màu trắng */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #b39ddb; /* Viền tím nhạt */
            border-radius: 5px;
        }
        button {
            background-color: #7e57c2; /* Tím */
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            margin-top: 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            width: 100%;
        }
        button:hover {
            background-color: #5e35b1; /* Tím đậm hơn khi hover */
        }
        .error {
            background-color: #ffebee; /* Đỏ nhạt */
            color: #d32f2f; /* Đỏ chữ */
            padding: 10px;
            border: 1px solid #e57373;
            margin-bottom: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div>
    <h1>Thêm sản phẩm</h1>

    <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/productservlet" method="post">
        <!-- Trường Tên -->
        <label for="name">Tên sản phẩm:</label>
        <input type="text" id="name" name="name" placeholder="Nhập tên sản phẩm" value="${product.name}" required />

        <!-- Trường Giá -->
        <label for="price">Giá:</label>
        <input type="text" id="price" name="price" placeholder="Nhập giá sản phẩm" value="${product.price}" required />

        <!-- Trường Trạng Thái -->
        <label for="state">Trạng thái:</label>
        <select id="state" name="state" required>
            <option value="1" ${product.status == 1 ? 'selected' : ''}>Bán</option>
            <option value="0" ${product.status == 0 ? 'selected' : ''}>Không bán</option>
        </select>

        <!-- Trường Mô tả -->
        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" placeholder="Nhập mô tả sản phẩm" required>${product.description}</textarea>

        <!-- Trường Link ảnh -->
        <label for="imageLink">Cập nhật link ảnh:</label>
        <input type="text" id="imageLink" name="image" placeholder="Nhập link ảnh" value="${product.image}" required />

        <!-- Hành động ẩn -->
        <input type="hidden" name="action" value="insert">

        <!-- Nút Gửi -->
        <button type="submit">Thêm sản phẩm</button>

        <!-- Nút Hủy -->
        <button type="button" onclick="goBack()">Hủy</button>
    </form>
</div>

<script>
    // Hàm quay lại trang trước
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
