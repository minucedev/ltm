package model.bean;

import java.sql.Timestamp;

public class Order {
    private int order_id;
    private int userId;
    private long totalPrice;
    private Timestamp orderDate; // Sử dụng Timestamp thay vì LocalDateTime
    private String status;


    // Constructor
    public Order(int userId, long totalPrice, Timestamp orderDate, String status) {
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.status = status;
    }
    public Order(int order_id, int userId, long totalPrice, Timestamp orderDate, String status) {
        this.order_id = order_id;
        this.userId = userId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.status = status;
    }

    // Getters và setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getOrder_id() {
        return order_id;
    }
}
