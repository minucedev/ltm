package model.dao;

import model.bean.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class productDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/fast_food";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

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

    // Lấy danh sách sinh viên
    public List<Product> getAllProduct() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT * FROM products"
             )) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("price"),
                        rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public static void main(String[] args) {
        productDao dao = new productDao();
        List<Product> products = dao.getAllProduct();
        for (Product product : products) {
            System.out.println(product);
        }
    }
}
