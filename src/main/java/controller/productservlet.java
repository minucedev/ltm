package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.bean.Product;
import model.dao.productDao;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "productservlet", value = "/productservlet")
public class productservlet extends HttpServlet {
    private productDao productdao;

    @Override
    public void init() throws ServletException {
        productdao = new productDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            listProducts(request, response);
        } else {
            switch (action) {
                case "showcomponent" -> Product(request, response);
                case "delete" -> confirmDeleteProduct(request, response);
                case "update" -> updateForm(request, response);
                case "insert" -> insertForm(request, response);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "delete" -> deleteProduct(request, response);
            case "update" -> updateProduct(request, response);
            case "insert" -> insertProduct(request, response);
        }
    }

    //Hàm lấy danh sách món ăn
    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productdao.getAllProduct();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/minuce-store.jsp");
        dispatcher.forward(request, response);
    }


    private void Product(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productdao.getAllProduct();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/admin/admin-dashboard.jsp");
        dispatcher.forward(request, response);
    }


    private void confirmDeleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        // Lấy thông tin sản phẩm để hiển thị
        Product product = productdao.getProductById(id);
        if (product != null) {
            request.setAttribute("product", product);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/admin/confirm-delete.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy sinh viên với ID: " + id);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productdao.updateStateProduct(id);
        response.sendRedirect("productservlet?action=showcomponent");
    }

    //Hàm cập nhật sản phẩm
    private void updateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productdao.getProductById(id);

            if (product != null) {
                request.setAttribute("product", product);
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/admin/product-update.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy sinh viên với ID: " + id);
                response.sendRedirect("view/error.jsp");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ.");
            response.sendRedirect("view/error.jsp");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            int state = Integer.parseInt(request.getParameter("state"));
            String description = request.getParameter("description");
            int price = Integer.parseInt(request.getParameter("price"));
            String image = request.getParameter("image");

            // Tạo đối tượng sản phẩm mới
            Product updatedProduct = new Product(id, name, state, description, price, image);

            boolean result = productdao.updateProduct(updatedProduct);

            if (result) {
                response.sendRedirect("productservlet?action=showcomponent");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thất bại.");
                response.sendRedirect("view/error.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
            response.sendRedirect("view/error.jsp");
        }

    }

    //Hàm thêm sản phẩm
    private void insertForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng đến trang thêm sinh viên
        response.sendRedirect("view/admin/product-insert.jsp");
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            // Lấy thông tin từ request
            String name = request.getParameter("name");
            int state = Integer.parseInt(request.getParameter("state"));
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");

            // Tạo đối tượng sản phẩm mới
            Product newProduct = new Product(0, name, state, description, price,image); // Giả sử ID được tự động tăng

            // Gọi DAO để thêm sản phẩm
            boolean result = productdao.insertProduct(newProduct);

            // Điều hướng tùy vào kết quả
            if (result) {
                response.sendRedirect("productservlet?action=showcomponent");
            } else {
                request.setAttribute("errorMessage", "Thêm sản phẩm thất bại. Vui lòng thử lại.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/error.jsp");
                dispatcher.forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/error.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/error.jsp");
            dispatcher.forward(request, response);
        }
    }


}
