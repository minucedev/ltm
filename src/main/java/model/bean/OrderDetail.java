package model.bean;
import model.bean.Product;

public class OrderDetail {
    private int productId;
    private int quantity;
    private double price;
    private Product product;

    // Constructor, getters và setters
    public OrderDetail(int productId, int quantity, double price) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.product = null;

    }
    public OrderDetail(int productId, int quantity, double price, Product product) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.product = product;

    }

    // Getters và setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }
    public void setProduct(Product product) {
        this.product = product;
    }
}