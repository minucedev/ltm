<%@ page import="model.bean.OrderDetail" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
<div class="container mt-4">
    <h2>Chi Tiết Đơn Hàng <%
        if(request.getAttribute("id")!= null)
            out.println(request.getAttribute("id"));
    %>
    </h2>
    <table class="table table-hover">
        <thead>
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Product Image</th>
            <th>Description</th>
            <th>Unit Price</th>
            <th>Quantity</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
            if (orderDetails != null) {
                for (OrderDetail detail : orderDetails) {
        %>
        <tr>
            <td><%= detail.getProductId() %></td>
            <td><%= detail.getProduct().getName() %></td>
            <td><img src="<%= detail.getProduct().getImage() %>" alt="<%= detail.getProduct().getName() %>" style="width: 100px; height: auto;"></td>
            <td><%= detail.getProduct().getDescription() %></td>
            <td><%= (long)detail.getPrice() %></td>
            <td><%= detail.getQuantity() %></td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
