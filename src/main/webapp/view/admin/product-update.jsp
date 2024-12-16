<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận Cập nhật Sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .form-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button[type="submit"] {
            background-color: #28a745;
            color: white;
        }
        button[type="submit"]:hover {
            background-color: #218838;
        }
        .button-cancel {
            background-color: #dc3545;
            color: white;
        }
        .button-cancel:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<h2>Xác nhận cập nhật thông tin sản phẩm</h2>

<div class="form-container">
    <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty product}">
            <form action="productservlet?action=update" method="post">
                <input type="hidden" name="id" value="${product.id}" />

                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${product.name}" required />

                <label for="state">State:</label>
                <input type="number" id="state" name="state" value="${product.state}" required />

                <label for="description">Description:</label>
                <input type="text" id="description" name="description" value="${product.description}" required />

                <label for="price">Price:</label>
                <input type="text" id="price" name="price" value="${product.price}" required />

                <label for="image">Image link:</label>
                <input type="text" id="image" name="image" value="${product.image}" required />

                <div class="button-container">
                    <button type="submit">Cập nhật</button>
                    <button type="button" class="button-cancel" onclick="goBack()">Hủy</button>
                </div>
            </form>
        </c:when>
        <c:otherwise>
            <div class="error">Không có thông tin sản phẩm để cập nhật.</div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function goBack() {
        window.history.back(); // Quay lại trang trước
    }
</script>
</body>
</html>
