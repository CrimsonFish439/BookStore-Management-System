package com.crimsonlogic.bms3.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.bms3.dao.BookDao;
import com.crimsonlogic.bms3.dao.BookDaoImpl;
import com.crimsonlogic.bms3.dao.OrderDao;
import com.crimsonlogic.bms3.dao.OrderDaoImpl;
import com.crimsonlogic.bms3.dao.WalletDao;
import com.crimsonlogic.bms3.dao.WalletDaoImpl;
import com.crimsonlogic.bms3.model.Book;
import com.crimsonlogic.bms3.model.Order;
import com.crimsonlogic.bms3.model.Wallet;

@WebServlet("/processPayment")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WalletDao walletDao;
    private BookDao bookDao;
    private OrderDao orderDao;  // Add OrderDao for order insertion

    public void init() {
        walletDao = new WalletDaoImpl();
        bookDao = new BookDaoImpl();
        orderDao = new OrderDaoImpl();  // Initialize OrderDao for inserting orders
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        double totalPrice = (double) session.getAttribute("totalPrice");
        String paymentMethod = request.getParameter("paymentMethod");

        if ("wallet".equals(paymentMethod)) {
            processWalletPayment(request, response, userId, totalPrice);
        } else if ("card".equals(paymentMethod)) {
            processCardPayment(request, response, totalPrice);
        }
    }

    private void processWalletPayment(HttpServletRequest request, HttpServletResponse response, int userId, double totalPrice) throws IOException {
        Wallet wallet = walletDao.getWalletByUserId(userId);
        if (wallet.getBalance() < totalPrice) {
            response.sendRedirect(request.getContextPath() + "/checkout.jsp?error=insufficientFunds");
        } else {
            boolean deductionSuccessful = walletDao.deductFromWallet(userId, totalPrice);
            if (deductionSuccessful) {
                insertOrders(request, userId);  // Insert orders after successful payment
                updateBookQuantities(request);  // Update book quantities in the database
                clearCartAndRedirect(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/checkout.jsp?error=deductionFailed");
            }
        }
    }

    private void processCardPayment(HttpServletRequest request, HttpServletResponse response, double totalPrice) throws IOException {
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        if (isValidCardDetails(cardNumber, expiryDate, cvv)) {
            insertOrders(request, (int) request.getSession().getAttribute("userId"));  // Insert orders after card payment
            updateBookQuantities(request);  // Update book quantities in the database
            clearCartAndRedirect(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/checkout.jsp?error=invalidCard");
        }
    }

    private boolean isValidCardDetails(String cardNumber, String expiryDate, String cvv) {
        return cardNumber != null && expiryDate != null && cvv != null;
    }

    private void insertOrders(HttpServletRequest request, int userId) {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Book> cart = (List<Book>) session.getAttribute("cart");

        for (Book book : cart) {
            Order order = new Order();
            order.setUserId(userId);
            order.setBookId(book.getBookId());
            order.setOrderDate(new Date(System.currentTimeMillis()));
            order.setPrice(book.getPrice());  // Set the price of the book
            order.setStatus("Completed");

            // Insert the order into the database
            orderDao.insertOrder(order);
        }
    }

    private void updateBookQuantities(HttpServletRequest request) {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Book> cart = (List<Book>) session.getAttribute("cart");

        // Update the quantity of each book in the database
        for (Book book : cart) {
            int currentQuantityInStock = bookDao.getBookById(book.getBookId()).getQuantity();
            int newQuantity = currentQuantityInStock - book.getQuantity();  // Reduce the quantity
            if (newQuantity >= 0) {
                bookDao.updateBookQuantity(book.getBookId(), newQuantity);
            }
        }
    }

    private void clearCartAndRedirect(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("cart", new java.util.ArrayList<>());  // Clear cart
        session.setAttribute("cartCount", 0);
        session.setAttribute("totalPrice", 0.0);
        response.sendRedirect(request.getContextPath() + "/users/purchaseSuccess.jsp");
    }
}
