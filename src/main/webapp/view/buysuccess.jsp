<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cảm ơn đã mua hàng</title>
    <!-- Liên kết đến file CSS của Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- Phần cảm ơn -->
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 text-center">
            <div class="alert alert-success" role="alert">
                <h3 class="alert-heading">Cảm ơn bạn đã mua hàng!</h3>
                <p>Chúng tôi rất vui khi nhận được đơn hàng của bạn. Đơn hàng của bạn sẽ được xử lý và giao hàng trong thời gian sớm nhất.</p>
                <hr>
                <p class="mb-0">Vui lòng kiểm tra email của bạn để biết thêm thông tin chi tiết về đơn hàng.</p>
            </div>
            <a href="productservlet" class="btn btn-primary">Quay lại Trang Chủ</a>
        </div>
    </div>
</div>

<!-- Liên kết đến file JavaScript của Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
