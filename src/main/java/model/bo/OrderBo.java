package model.bo;

import model.bean.Order;
import model.bean.OrderDetail;
import model.bean.Product;
import model.dao.OrderDao;
import model.dao.productDao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class OrderBo {

    private OrderDao orderDAO;
    private productDao _productDao;

    public OrderBo() {
        orderDAO = new OrderDao();
        _productDao = new productDao();
    }

    // Phương thức thêm đơn hàng và chi tiết
    public boolean addOrderWithDetails(int userId, Map<Integer,Integer> cart) {

        Set<Integer> keys = cart.keySet();
        long totalPrice = 0;
        List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
        for (Integer key : keys) {
            Integer quantity = cart.get(key);
            Product product = _productDao.getProductById(key);
            long price = product.getPrice();
            totalPrice += quantity * price;
            OrderDetail od = new OrderDetail(key,quantity,price);
            orderDetails.add(od);
        }
        // Lấy thời gian hiện tại
        Timestamp currentDateTime = Timestamp.valueOf(LocalDateTime.now());
        Order order = new Order(userId, totalPrice, currentDateTime, "completed");
        return orderDAO.addOrderWithDetails(order, orderDetails);
    }


    public List<OrderDetail> getOrderDetails(int orderId) {
        return orderDAO.getOrderDetails(orderId);
    }

    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }
}
