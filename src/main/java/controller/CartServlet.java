package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.Product;
import model.bo.OrderBo;
import model.bo.productBo;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@WebServlet(name = "CartServlet", value = "/CartServlet")
public class CartServlet extends HttpServlet {
    productBo _productBo = new productBo();
    OrderBo _orderBo = new OrderBo();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role")) ) {
            //chuyển hướng theo yêu cầu ajax
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            } else {
                response.sendRedirect("view/login.jsp");
            }
        } else {
            String action = request.getParameter("action");
            switch (action) {
                case "addToCart": addTocart(request, response, session); break;
                case "delete": deleteFromCart(request, response, session); break;

            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || !"user".equals(session.getAttribute("role")) ) {
            response.sendRedirect("view/login.jsp");
        } else {
            String action = request.getParameter("action");
            switch (action) {
                case "cart":
                    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
                    List<Product> products = null;
                    long ToltalPrice = 0;
                    if (cart != null ) {
                        if (!cart.isEmpty()){
                            Set<Integer> keys = cart.keySet();
                            products = _productBo.getProductsByIds(keys);
                            ToltalPrice = _productBo.calculatorTotalPrice(cart);
                        }

                    }
                    request.setAttribute("TotalPrice", ToltalPrice);
                    request.setAttribute("cart", cart);
                    request.setAttribute("products", products);
                    request.getRequestDispatcher("view/customer/cart.jsp").forward(request, response);
                    break;
                case "purchase": purchase(request, response, session); break;

            }
        }
    }

    private void purchase(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        int uid = Integer.parseInt(session.getAttribute("uid").toString()) ;
        _orderBo.addOrderWithDetails(uid, cart);
        cart.clear();
        session.setAttribute("cart", cart);
        response.sendRedirect("view/buysuccess.jsp");
    }

    private void addTocart(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        Integer productId = Integer.parseInt(request.getParameter("productId")) ;
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        cart.put(productId, cart.getOrDefault(productId, 0) + quantity);
        session.setAttribute("cart", cart);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Thêm sản phẩm vào giỏ hàng thành công!");
    }

    private void deleteFromCart(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id")) ;

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        } else cart.remove(id);
        session.setAttribute("cart", cart);
        response.sendRedirect("CartServlet?action=cart");
    }

}
