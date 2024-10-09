package com.crimsonlogic.bms3.dao;

import java.util.List;

import com.crimsonlogic.bms3.model.Order;

public interface OrderDao {
    void insertOrder(Order order);
    List<Order> getOrderHistoryByUserId(int userId);
	List<Order> getOrdersByMonthAndYear(int month, int year);
}
