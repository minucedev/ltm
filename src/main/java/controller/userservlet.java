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
            case "logout" -> {
                HttpSession session = request.getSession();
                session.setAttribute("username", null);
                session.setAttribute("role", null);
                session.setAttribute("uid", null);
                response.sendRedirect("view/login.jsp");
            }
            case "getinfo" -> getInfor(request, response);
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
        int user_id = userdao.getuid(username);

        if (role != null) { // Kiểm tra nếu role không phải null (nghĩa là thông tin đăng nhập đúng)
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role); // Lưu vai trò vào session
            session.setAttribute("uid", user_id);
            // Chuyển hướng dựa trên vai trò
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("productservlet?action=showcomponent"); // Trang dành cho admin
            } else {
                response.sendRedirect("productservlet"); // Trang dành cho user
            }
        } else {
            // Nếu thông tin đăng nhập sai, quay lại trang đăng nhập
            request.setAttribute("error", "Incorrect account or password");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }


    //Register for user
    private void addForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("view/login.jsp?type=register");
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        if (!userdao.checkExistUser(username)) {
            User insertedUser = new User(0, username, password, "", email);
            boolean result = userdao.addUser(insertedUser);
            if (result) {
                response.sendRedirect("view/login.jsp");
            } else {
                request.setAttribute("error", "Thêm tài khoản thất bại.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/error.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("error", "Username already exists. Please choose another one.");
            request.getRequestDispatcher("view/login.jsp?type=register").forward(request, response);
        }

    }
    private void getInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            String username = (String) session.getAttribute("username");
            if (username != null) {
                User user = userdao.getInfo(username);
                if (user != null) {
                    request.setAttribute("user", user);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("view/user-info.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.sendRedirect("index.jsp?error=user_not_found");
                }
            } else {
                response.sendRedirect("index.jsp?error=not_logged_in");
            }
        } else {
            response.sendRedirect("index.jsp?error=not_logged_in");
        }
    }



}
