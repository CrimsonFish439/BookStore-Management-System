package com.crimsonlogic.bms3.dao;

import java.util.Map;

public interface CartDao {
    void addToCart(int userId, int bookId, int quantity);
    Map<Integer, Integer> getCartItems(int userId);  // Returns a map of bookId and quantity
    void clearCart(int userId);
}
