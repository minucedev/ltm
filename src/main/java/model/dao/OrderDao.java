package model.dao;

import model.bean.Order;
import model.bean.OrderDetail;
import model.bean.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    private String jdbcURL = "jdbc:mysql://localhost:3307/fast_food";
    private String jdbcUsername = "root";
    private String jdbcPassword = "admin";

    // Kết nối tới cơ sở dữ liệu
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    // Phương thức thêm đơn hàng và chi tiết đơn hàng
    public boolean addOrderWithDetails(Order order, List<OrderDetail> orderDetails) {
        Connection connection = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        try {
            // Kết nối với cơ sở dữ liệu
            connection = getConnection();
            connection.setAutoCommit(false); // Bắt đầu giao dịch

            // Truy vấn SQL để thêm đơn hàng
            String sqlOrder = "INSERT INTO orders (user_id, total_price, order_date, status) VALUES (?, ?, ?, ?)";
            psOrder = connection.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setLong(2, order.getTotalPrice());
            psOrder.setTimestamp(3, order.getOrderDate()); // Sử dụng setTimestamp
            psOrder.setString(4, order.getStatus());
            int rowsAffected = psOrder.executeUpdate();

            if (rowsAffected > 0) {
                // Lấy ID của đơn hàng vừa thêm
                int orderId = 0;
                var rs = psOrder.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }

                // Truy vấn SQL để thêm chi tiết đơn hàng
                String sqlDetail = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
                psDetail = connection.prepareStatement(sqlDetail);

                // Thêm chi tiết đơn hàng
                for (OrderDetail detail : orderDetails) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, detail.getProductId());
                    psDetail.setInt(3, detail.getQuantity());
                    psDetail.setDouble(4, detail.getPrice());
                    psDetail.addBatch();
                }

                // Thực thi batch
                int[] rowsAffectedDetails = psDetail.executeBatch();

                // Kiểm tra nếu tất cả các chi tiết được thêm thành công
                boolean detailsInserted = true;
                for (int i : rowsAffectedDetails) {
                    if (i == PreparedStatement.EXECUTE_FAILED) {
                        detailsInserted = false;
                        break;
                    }
                }

                if (detailsInserted) {
                    connection.commit(); // Giao dịch thành công
                    return true;
                } else {
                    connection.rollback(); // Nếu có lỗi, hủy bỏ giao dịch
                    return false;
                }
            } else {
                connection.rollback();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (connection != null) connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (psOrder != null) psOrder.close();
                if (psDetail != null) psDetail.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT od.product_id, od.quantity, od.unit_price, p.id, p.name, p.state, p.description, p.price, p.image_url " +
                             "FROM order_items od " +
                             "JOIN products p ON od.product_id = p.id " +
                             "WHERE od.order_id = ?")) {
            preparedStatement.setInt(1, orderId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                // Lấy thông tin sản phẩm
                Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("state"),
                        rs.getString("description"),
                        rs.getInt("price"),
                        rs.getString("image_url")
                );

                // Tạo đối tượng OrderDetail
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("unit_price"),
                        product
                );

                // Thêm vào danh sách orderDetails
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT * FROM orders")) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getLong("total_price"),
                        rs.getTimestamp("order_date"),
                        rs.getString("status")
                );

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
