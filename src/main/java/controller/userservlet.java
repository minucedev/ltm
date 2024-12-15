package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.bean.User;
import model.dao.userDao;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "userservlet", value = "/userservlet")
public class userservlet extends HttpServlet {
    private userDao userdao;

    @Override
    public void init() throws ServletException {
        userdao = new userDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "register" -> addForm(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "login" -> checkLogin(request, response);
            case "register" -> addUser(request, response);

        }
    }

    //Validate user
    private void checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Gọi phương thức checkLogin từ DAO để lấy vai trò
        String role = userdao.checkLogin(username, password);

        if (role != null) { // Kiểm tra nếu role không phải null (nghĩa là thông tin đăng nhập đúng)
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role); // Lưu vai trò vào session

            // Chuyển hướng dựa trên vai trò
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("view/admin/admin-dashboard.jsp"); // Trang dành cho admin
            } else {
                response.sendRedirect("productservlet"); // Trang dành cho user
            }
        } else {
            // Nếu thông tin đăng nhập sai, quay lại trang đăng nhập
            response.sendRedirect("index.jsp?error=invalid_login");
        }
    }


    //Register for user
    private void addForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("view/register-form.jsp");
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        if (!userdao.checkExistUser(username)) {
            User insertedUser = new User(0, username, password, "", email);
            boolean result = userdao.addUser(insertedUser);
            if (result) {
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("errorMessage", "Thêm tài khoản thất bại.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/error.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Username already exists. Please choose another one.");
            request.getRequestDispatcher("view/register-form.jsp").forward(request, response);
        }

    }


}
