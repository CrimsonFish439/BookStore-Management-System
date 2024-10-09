package com.crimsonlogic.bms3.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.bms3.dao.OrderDao;
import com.crimsonlogic.bms3.dao.OrderDaoImpl;
import com.crimsonlogic.bms3.model.Order;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    public void init() {
        orderDao = new OrderDaoImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("viewHistory".equals(action)) {
            showOrderHistory(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void showOrderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        // Fetch order history for the user
        List<Order> orders = orderDao.getOrderHistoryByUserId(userId);

        // Set orders as a request attribute
        request.setAttribute("orders", orders);

        // Forward to the order history JSP
        request.getRequestDispatcher("/users/orderHistory.jsp").forward(request, response);
    }
}
