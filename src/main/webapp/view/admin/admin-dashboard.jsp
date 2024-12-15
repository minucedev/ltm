<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: minuce
  Date: 15/12/2024
  Time: 16:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ADMIN DASHBOARD</title>
</head>
<body>
<h1>Food List</h1>
<!-- Nút Thêm Sinh Viên -->
<form action="productservlet" method="get">
    <input type="hidden" name="action" value="insert">
    <button type="submit">Thêm sản phẩm</button>
</form>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>State</th>
        <th>Description</th>
        <th>Price</th>
    </tr>
    <tr>
        <c:forEach var="product" items="${products}">
    <tr>
        <td>${product.id}</td>
        <td>${product.name}</td>
        <td>${product.state}</td>
        <td>${product.description}</td>
        <td>${product.price}</td>
        <td>
            <a href="productservlet?action=update&id=${product.id}">Sửa</a>
            <a href="productservlet?action=delete&id=${product.id}">Xóa</a>

        </td>
    </tr>
    </c:forEach>
    </tr>
</table>
</body>
</html>
