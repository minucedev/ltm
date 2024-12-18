package model.bo;

import model.bean.Product;
import model.dao.productDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class productBo {
    productDao _productDao = new productDao();

    public List<Product> getProductsByIds(Set<Integer> keys){
        StringBuilder keyBuilder = new StringBuilder();
        for (Integer key : keys) {
            keyBuilder.append("'").append(key).append("',");
        }
        String keyString = keyBuilder.substring(0, keyBuilder.length() - 1);
        return _productDao.getProductsByIds(keyString);

    }
    public long calculatorTotalPrice(Map<Integer,Integer> cart){
        Set<Integer> keys = cart.keySet();
        long totalPrice = 0;
        for (Integer key : keys) {
            Integer quantity = cart.get(key);
            totalPrice += (long) quantity * _productDao.getProductById(key).getPrice();
        }
        return totalPrice;
    }


    public List<Product> getAllProduct() {
        return _productDao.getAllProduct();
    }


    //Lấy thông tin chi tiết sản phẩm theo id
    public Product getProductById(int id) {
        return _productDao.getProductById(id);
    }

    //Update state product
    public boolean updateStateProduct(int id) {
        return _productDao.updateStateProduct(id);
    }

    //Cập nhật sản phẩm
    public boolean updateProduct(Product product) {
        return _productDao.updateProduct(product);
    }

    //Thêm sản phẩm
    public boolean insertProduct(Product product) {
        return _productDao.insertProduct(product);
    }



    public List<Product> searchProductByName(String keyword) {
        return _productDao.searchProductByName(keyword);
    }


    public List<Product> getAllProductSelling() {
        return _productDao.getAllProductSelling();
    }

}
