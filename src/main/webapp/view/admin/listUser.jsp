<%@ page import="java.util.List" %>
<%@ page import="model.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Người Dùng</title>
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
    <h2>Danh Sách Người Dùng</h2>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Role</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<User> userList = (List<User>) request.getAttribute("userList");
            if (userList != null) {
                for (User user : userList) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getRole() %></td>
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
