package model.bo;


import model.bean.User;
import model.dao.userDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class userBO {
    userDao _userDao = new userDao();


    public String checkLogin(String username, String password) {
        return _userDao.checkLogin(username, password);
    }

    public int getuid(String username) {
        return _userDao.getuid(username);
    }


    public boolean checkExistUser(String username) {
        return _userDao.checkExistUser(username);
    }


    public boolean addUser(User user) {
        return _userDao.addUser(user);
    }

    public User getInfo(String username) {
        return _userDao.getInfo(username);
    }

    public List<User> getAllUser() {
        return _userDao.getAllUsers();
    }


    public static void main(String[] args) {
        userDao dao = new userDao();
        System.out.println(dao.checkLogin("john_doe", "hashed_password_1"));
    }

}
