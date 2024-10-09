package com.crimsonlogic.bms3.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.crimsonlogic.bms3.dao.OrderDao;
import com.crimsonlogic.bms3.dao.OrderDaoImpl;
import com.crimsonlogic.bms3.model.Order;

@WebServlet("/orderReports")
public class OrderReportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    public void init() {
        orderDao = new OrderDaoImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String monthStr = request.getParameter("month");
        String yearStr = request.getParameter("year");

        if (monthStr == null || yearStr == null) {
            request.setAttribute("error", "Invalid input");
            request.getRequestDispatcher("/orderReports.jsp").forward(request, response);
            return;
        }

        int month = Integer.parseInt(monthStr);
        int year = Integer.parseInt(yearStr);

        // Fetch orders for the selected month and year
        List<Order> orders = orderDao.getOrdersByMonthAndYear(month, year);

        // Calculate total revenue
        BigDecimal totalRevenue = orders.stream()
                .map(order -> BigDecimal.valueOf(order.getPrice()))  // Convert price to BigDecimal
                .reduce(BigDecimal.ZERO, BigDecimal::add);  // Sum up BigDecimal values


        // Set attributes for the JSP
        request.setAttribute("orders", orders);
        request.setAttribute("totalRevenue", totalRevenue);  // Add total revenue to the request
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);

        // Forward to the report JSP
        request.getRequestDispatcher("/admin/orderReports.jsp").forward(request, response);
    }
}
