package model.bo;

import model.bean.Product;
import model.dao.productDao;

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
            totalPrice += quantity * _productDao.getProductById(key).getPrice();
        }
        return totalPrice;
    }
}
