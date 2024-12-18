<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Đăng nhập</title>
    <link href="../asset/login.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../asset/login.js"></script>


    <%
        String error =(String) request.getAttribute("error");
        String type = request.getParameter("type");
        if(type == null ) type = "login";
    %>



</head>
<body>
<div class="container">
    <input type="hidden" id="pageType" value="<%= type %>" />
    <div class="c1">

        <div class="c11">
            <h1 class="mainhead">MINUCE STORE</h1>
            <p class="mainp">Fast foods</p>
        </div>
        <div id="left"><h1 class="s1class"><span>ĐĂNG</span><span class="su">NHẬP</span>
        </h1></div>
        <div id="right"><h1 class="s2class"><span>ĐĂNG</span><span class="su">KÝ</span></h1></div>
    </div>
    <div class="c2">
        <form class="signup" action="${pageContext.request.contextPath}/userservlet" method="post">
            <h1 class="signup1">ĐĂNG KÝ</h1>
            <br><br><br><br>
            <input name="username" type="text" placeholder="Username*" class="username" required/>

            <input name="email" type="text" placeholder="Email*" class="username" required/>

            <input name="password" type="password" placeholder="Password*" class="username" required/>

            <button class="btn" type="submit" name="action" value="register">Đăng ký</button>
            <br><br>

            <%
                if (error != null && !error.isEmpty() && "register".equals(type)) {
                    out.println("<small class='error-message'>Lỗi: " + error + "</small>");

                }

            %>

        </form>
        <form class="signin" action="${pageContext.request.contextPath}/userservlet" method="post">

            <h1 class="signup1">ĐĂNG NHẬP</h1>
            <br><br><br><br>
            <input name="username" type="text" placeholder="Username*" class="username" required/>

            <input name="password" type="password" placeholder="Password*" class="username" required/>

            <button class="btn" type="submit" name="action" value="login">Đăng nhập</button>
            <br><br><br><br><br>

            <%
                if (error != null && !error.isEmpty() && "login".equals(type)) {
                    out.println("<small class='error-message'>Lỗi: " + error + "</small>");

                }
            %>

        </form>



    </div>
</div>
</body>
</html>