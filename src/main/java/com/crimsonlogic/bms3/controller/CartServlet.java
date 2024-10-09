package com.crimsonlogic.bms3.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.bms3.dao.BookDao;
import com.crimsonlogic.bms3.dao.BookDaoImpl;
import com.crimsonlogic.bms3.dao.WalletDao;
import com.crimsonlogic.bms3.dao.WalletDaoImpl;
import com.crimsonlogic.bms3.model.Book;
import com.crimsonlogic.bms3.model.Wallet;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDao bookDao;
    private WalletDao walletDao;

    public void init() {
        bookDao = new BookDaoImpl();
        walletDao = new WalletDaoImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Book> cart = (List<Book>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "add":
                addToCart(request, response, cart);
                return;  // Ensure the method returns immediately after redirect
            case "remove":
                removeFromCart(request, response, cart);
                return;  // Ensure the method returns immediately after redirect
            case "updateQuantity":
                updateQuantity(request, response, cart);
                return;  // Ensure the method returns immediately after redirect
            case "buy":
                // Redirect to checkout instead of processing the purchase directly
                redirectToCheckout(request, response, cart);
                return;  // Ensure the method returns immediately after redirect
            default:
                break;
        }

        session.setAttribute("cartCount", cart.size());
        session.setAttribute("totalPrice", calculateTotalPrice(cart));

        // Redirect to the cart page
        response.sendRedirect(request.getContextPath() + "/users/cart.jsp");
    }

    private void redirectToCheckout(HttpServletRequest request, HttpServletResponse response, List<Book> cart)
            throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("totalPrice", calculateTotalPrice(cart));  // Calculate and store the total price in the session

        // Redirect to the checkout page
        response.sendRedirect(request.getContextPath() + "/users/checkout.jsp");
    }



    private void addToCart(HttpServletRequest request, HttpServletResponse response, List<Book> cart) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = bookDao.getBookById(bookId);

        boolean bookExists = false;
        for (Book b : cart) {
            if (b.getBookId() == bookId) {
                if (b.getQuantity() + 1 > book.getQuantity()) {
                    response.sendRedirect(request.getContextPath() + "/users/cart.jsp?error=quantityExceeded");
                    return;
                }
                b.setQuantity(b.getQuantity() + 1);
                bookExists = true;
                break;
            }
        }

        if (!bookExists) {
            if (book.getQuantity() <= 0) {
                response.sendRedirect(request.getContextPath() + "/users/cart.jsp?error=outOfStock");
                return;
            }
            book.setQuantity(1);
            cart.add(book);
        }

        // Update total price
        HttpSession session = request.getSession();
        session.setAttribute("totalPrice", calculateTotalPrice(cart));

        response.sendRedirect(request.getContextPath() + "/users/cart.jsp");  // Always return after redirect
    }


    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, List<Book> cart) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        cart.removeIf(book -> book.getBookId() == bookId);

        // Update total price
        HttpSession session = request.getSession();
        session.setAttribute("totalPrice", calculateTotalPrice(cart));

        response.sendRedirect(request.getContextPath() + "/users/cart.jsp");
    }


    private void updateQuantity(HttpServletRequest request, HttpServletResponse response, List<Book> cart) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int requestedQuantity = Integer.parseInt(request.getParameter("quantity"));
        Book bookInStock = bookDao.getBookById(bookId);

        if (requestedQuantity > bookInStock.getQuantity()) {
            response.sendRedirect(request.getContextPath() + "/users/cart.jsp?error=quantityExceeded");
            return;
        }

        for (Book book : cart) {
            if (book.getBookId() == bookId) {
                book.setQuantity(requestedQuantity);
                break;
            }
        }

        // Update total price
        HttpSession session = request.getSession();
        session.setAttribute("totalPrice", calculateTotalPrice(cart));

        response.sendRedirect(request.getContextPath() + "/users/cart.jsp");
    }


    private void processPurchase(HttpServletRequest request, HttpServletResponse response, List<Book> cart)
            throws IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        double totalPrice = calculateTotalPrice(cart);  // Calculate total price dynamically

        Wallet wallet = walletDao.getWalletByUserId(userId);

        // Check if the user has enough funds
        if (wallet.getBalance() < totalPrice) {
            response.sendRedirect(request.getContextPath() + "/users/cart.jsp?error=insufficientFunds");
            return;
        }

        // Deduct the total price from the user's wallet
        boolean deductionSuccessful = walletDao.deductFromWallet(userId, totalPrice);

        if (deductionSuccessful) {
            // Update book quantities in the database
            for (Book book : cart) {
                int newQuantity = bookDao.getBookById(book.getBookId()).getQuantity() - book.getQuantity(); // Deduct purchased quantity
                if (newQuantity < 0) {
                    response.sendRedirect(request.getContextPath() + "/users/cart.jsp?error=quantityExceeded");
                    return;
                }

                // Update the book's quantity in the database
                bookDao.updateBookQuantity(book.getBookId(), newQuantity);
            }

            // Clear the cart and reset session variables
            cart.clear();
            session.setAttribute("cartCount", 0);
            session.setAttribute("totalPrice", 0.0);

            // Redirect to the purchase success page
            response.sendRedirect(request.getContextPath() + "/users/purchaseSuccess.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/users/cart.jsp?error=deductionFailed");
        }
    }

    private double calculateTotalPrice(List<Book> cart) {
        return cart.stream().mapToDouble(book -> book.getPrice() * book.getQuantity()).sum();
        
    }

}
