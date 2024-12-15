package model.dao;

import model.bean.User;

import java.sql.*;

public class userDao {
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

    // Kiểm tra đăng nhập và trả về vai trò (admin hoặc user)
    public String checkLogin(String username, String password) {
        String role = null;
        String sql = "SELECT role FROM users WHERE username = ? AND password = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                role = rs.getString("role"); // Lấy giá trị của cột 'role'
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ một cách chính xác
            e.printStackTrace();
        }
        return role; // Trả về vai trò hoặc null nếu không tìm thấy
    }

    public int getuid(String username) {
        int user_id = -1;
        String sql = "SELECT id FROM users WHERE username = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                user_id = rs.getInt("id");
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ một cách chính xác
            e.printStackTrace();
        }
        return user_id;
    }


    public boolean checkExistUser(String username) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT COUNT(*) FROM users WHERE username = ? "
             )) {
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; //Account already exist
            }
            else {
                return false;
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ một cách chính xác
            e.printStackTrace();
            return false;
        }
    }


    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, role, email) VALUES (?,?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Gán giá trị vào các tham số trong câu lệnh SQL
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, "user"); //người dùng đăng ký mặc định là user
            statement.setString(4, user.getEmail());

            // Thực thi câu lệnh INSERT
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu xảy ra lỗi
        }
    }
    public static void main(String[] args) {
        userDao dao = new userDao();
        System.out.println(dao.checkLogin("john_doe", "hashed_password_1"));
    }
}
