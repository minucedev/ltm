$(document).ready(function () {
    // Hiển thị container khi tải trang
    $(".container").fadeIn(1000);

    // Lấy giá trị của biến type từ thẻ input ẩn
    var type = $("#pageType").val();
    if (type == null) type = "login"; // Mặc định là đăng nhập

    if (type === "register") {
        $("#left").removeClass("left_hover");
        $(".s2class").css({ "color": "#EE9BA3" });
        $(".s1class").css({ "color": "#748194" });
        $("#right").addClass("right_hover");
        $(".signin").css({ "display": "none" });
        $(".signup").css({ "display": "" });
    } else {
        $("#left").addClass("left_hover");
        $(".s1class").css({ "color": "#EE9BA3" });
        $(".s2class").css({ "color": "#748194" });
        $("#right").removeClass("right_hover");
        $(".signup").css({ "display": "none" });
        $(".signin").css({ "display": "" });
    }

    // Sự kiện khi nhấn vào Sign Up
    $("#right").click(function () {
        $("#left").removeClass("left_hover");
        $(".s2class").css({ "color": "#EE9BA3" });
        $(".s1class").css({ "color": "#748194" });
        $("#right").addClass("right_hover");
        $(".signin").css({ "display": "none" });
        $(".signup").css({ "display": "" });
    });

    // Sự kiện khi nhấn vào Sign In
    $("#left").click(function () {
        $(".s1class").css({ "color": "#EE9BA3" });
        $(".s2class").css({ "color": "#748194" });
        $("#right").removeClass("right_hover");
        $("#left").addClass("left_hover");
        $(".signup").css({ "display": "none" });
        $(".signin").css({ "display": "" });
    });
});
