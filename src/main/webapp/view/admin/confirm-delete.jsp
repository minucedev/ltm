<%--
  Created by IntelliJ IDEA.
  User: minuce
  Date: 09/12/2024
  Time: 16:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận xóa sản phẩm</title>
</head>
<body>
<div>
    <h1>Xác nhận xóa sản phẩm</h1>

    <c:if test="${not empty errorMessage}">
        <div>${errorMessage}</div>
    </c:if>

    <c:if test="${not empty product}">
        <p><strong>ID:</strong> ${product.id}</p>
        <p><strong>Name:</strong> ${product.name}</p>
        <p><strong>State:</strong> ${product.state}</p>
        <p><strong>Description:</strong> ${product.description}</p>

        <form action="productservlet?action=delete" method="post" onsubmit="return confirmDelete()">
            <input type="hidden" name="id" value="${product.id}" />
            <button type="submit">Xóa</button>
            <button type="button" onclick="goBack()">Hủy</button>
        </form>
    </c:if>
</div>

<script>
    function goBack() {
        window.history.back(); // Quay lại trang trước
    }

    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa sản phẩm này?"); // Hiển thị xác nhận xóa
    }
</script>
</body>
</html>
