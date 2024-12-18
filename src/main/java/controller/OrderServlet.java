package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.Order;
import model.bean.OrderDetail;
import model.bo.OrderBo;


import java.io.IOException;
import java.util.List;


@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderBo orderBo;

    public void init() {
        orderBo = new OrderBo();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role")) ) {
            response.sendRedirect("view/login.jsp");
        } else {
            String action = request.getParameter("action");
            if ("viewDetails".equals(action)) {
                viewOrderDetails(request, response);
            } else {
                listOrders(request, response);
            }
        }

    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orderList = orderBo.getAllOrders();
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/view/admin/HistoryOrder.jsp").forward(request, response);
    }

    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        List<OrderDetail> orderDetails = orderBo.getOrderDetails(orderId);
        request.setAttribute("orderDetails", orderDetails);
        request.setAttribute("id", orderId);
        request.getRequestDispatcher("/view/admin/OrderDetail.jsp").forward(request, response);
    }
}



