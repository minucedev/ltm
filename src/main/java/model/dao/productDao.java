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

    // Lấy danh sách sản phẩm
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
                        rs.getInt("state"),
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


    //Lấy thông tin chi tiết sản phẩm theo id
    public Product getProductById(int id) {
        Product product = null; // Khởi tạo biến sản phẩm
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT * FROM products WHERE id = ?"
             )) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("state"),
                        rs.getString("description"),
                        rs.getInt("price"),
                        rs.getString("image_url")
                );
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ một cách chính xác
            e.printStackTrace();
        }
        return product; // Trả về đối tượng sinh viên hoặc null nếu không tìm thấy
    }

    //Update state product
    public boolean updateStateProduct(int id) {
        boolean flag = false;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE products SET state = ? WHERE id = ?"
             )) {
            statement.setString(1, "0"); // Gán giá trị trạng thái
            statement.setInt(2, id);        // Gán ID của sản phẩm

            flag = statement.executeUpdate() > 0; // Kiểm tra nếu có bản ghi bị cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    //Cập nhật sản phẩm
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, state = ?, description = ?, " +
                "price = ?, image_url = ? WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, product.getName());
            statement.setInt(2, product.getState());
            statement.setString(3, product.getDescription());
            statement.setInt(4, product.getPrice());
            statement.setString(5, product.getImage());
            statement.setInt(6, product.getId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Thêm sản phẩm
    public boolean insertProduct(Product product) {
        String sql = "INSERT INTO products (name, state, description, price, image_url ) VALUES (? ,?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Gán giá trị vào các tham số trong câu lệnh SQL
            statement.setString(1, product.getName());
            statement.setInt(2, product.getState());
            statement.setString(3, product.getDescription());
            statement.setInt(4, product.getPrice());
            statement.setString(5, product.getImage());
            // Thực thi câu lệnh INSERT
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu xảy ra lỗi
        }
    }

    public static void main(String[] args) {
        productDao dao = new productDao();
        Product product = new Product(1, "test", 1, "Delicious beef burger with lettuce and tomato", 50000, "https://th.bing.com/th/id/OIP.QGmd5LmQMD1fz5f1Rri5IwHaFj?w=1250&h=938&rs=1&pid=ImgDetMain");
        System.out.println(dao.insertProduct(product));
    }
}
