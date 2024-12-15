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
                case "showcomponent"-> Product(request, response);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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







}
