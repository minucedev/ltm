<%@ page import="java.util.List" %>
<%@ page import="model.bean.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Đơn Hàng</title>
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
<div class="container my-4">
    <h2>Danh Sách Đơn Hàng</h2>
    <table class="table">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>User ID</th>
            <th>Total Price</th>
            <th>Order Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Order> orderList = (List<Order>) request.getAttribute("orderList");
            if (orderList != null) {
                for (Order order : orderList) {
        %>
        <tr>
            <td><%= order.getOrder_id() %></td>
            <td><%= order.getUserId() %></td>
            <td><%= order.getTotalPrice() %></td>
            <td><%= order.getOrderDate() %></td>
            <td><%= order.getStatus() %></td>
            <td>
                <form action="OrderServlet" method="get">
                    <input type="hidden" name="orderId" value="<%= order.getOrder_id() %>" />
                    <input type="hidden" name="action" value="viewDetails" />
                    <input type="submit" class="btn btn-primary" value="Xem chi tiết" />
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
