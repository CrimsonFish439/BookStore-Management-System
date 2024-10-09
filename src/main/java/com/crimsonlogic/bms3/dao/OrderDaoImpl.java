package com.crimsonlogic.bms3.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.crimsonlogic.bms3.model.Order;
import com.crimsonlogic.bms3.utils.DatabaseConnection;

public class OrderDaoImpl implements OrderDao {

    private static final String SELECT_ORDER_HISTORY = "SELECT * FROM orders WHERE user_id = ?";
    private static final String INSERT_ORDER = "INSERT INTO orders (user_id, book_id, order_date, price, status) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ORDERS_BY_MONTH_YEAR = "SELECT * FROM orders WHERE EXTRACT(MONTH FROM order_date) = ? AND EXTRACT(YEAR FROM order_date) = ?";

    @Override
    public List<Order> getOrdersByMonthAndYear(int month, int year) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ORDERS_BY_MONTH_YEAR)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setBookId(rs.getInt("book_id"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setPrice(rs.getDouble("price"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
    @Override
    public List<Order> getOrderHistoryByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ORDER_HISTORY)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setBookId(rs.getInt("book_id"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setPrice(rs.getDouble("price"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public void insertOrder(Order order) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_ORDER)) {
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getBookId());
            ps.setDate(3, order.getOrderDate());
            ps.setDouble(4, order.getPrice());  // Insert the price
            ps.setString(5, order.getStatus());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
