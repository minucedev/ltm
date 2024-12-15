<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>
</head>
<body>
<%
    String error = (String) request.getAttribute("error");
    if(error!=null){
%>
    <i><%=error%></i>
<%
    }
%>
<form action="userservlet" method="post">

    <label for="username">Username</label>
    <input type="text" id="username" name="username" required>
    <br>
    <label for="password">Password</label>
    <input type="password" id="password" name="password" required>
    <br>
    <!-- Nút cho hành động đăng nhập -->
    <button type="submit" name="action" value="login">Login</button>
    <br>
</form>
<form action="userservlet" method="get">
    <!-- Nút cho hành động đăng ký -->
    <button type="submit" name="action" value="register">Register</button>
</form>
</body>
</html>