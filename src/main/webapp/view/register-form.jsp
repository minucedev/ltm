<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/userservlet" method="post">
    <label for="username">Username</label>
    <input type="text" id="username" name="username" required>
    <br>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" required>
    <br>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" required>
    <br>

    <input type="hidden" name="action" value="register">
    <button type="submit">Register</button>
</form>

<%-- Hiển thị thông báo lỗi nếu có --%>
<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<% if (errorMessage != null) { %>
<p style="color: red;"><%= errorMessage %></p>
<% } %>

</body>
</html>
