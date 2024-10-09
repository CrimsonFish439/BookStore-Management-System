package com.crimsonlogic.bms3.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.bms3.dao.BookDao;
import com.crimsonlogic.bms3.dao.BookDaoImpl;
import com.crimsonlogic.bms3.dao.RentalDao;
import com.crimsonlogic.bms3.dao.RentalDaoImpl;
import com.crimsonlogic.bms3.model.Book;
import com.crimsonlogic.bms3.model.Rental;

@WebServlet("/rental")
public class RentalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RentalDao rentalDao;
    private BookDao bookDao;  

    public void init() {
        rentalDao = new RentalDaoImpl();
        bookDao = new BookDaoImpl();  
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

        if ("rent".equals(action)) {
            rentBook(request, response);
        } else if ("returnBook".equals(action)) {
            returnBook(request, response);
        } else if ("viewHistory".equals(action)) {
            showRentalHistory(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void rentBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        String bookIdStr = request.getParameter("bookId");

        if (bookIdStr == null || bookIdStr.isEmpty()) {
            System.out.println("Book ID not found in request.");
            response.sendRedirect(request.getContextPath() + "/users/userHome.jsp?error=bookNotFound");
            return;
        }

        int bookId = Integer.parseInt(bookIdStr);
        Book book = bookDao.getBookById(bookId);  // Fetch the book details

        if (book.getQuantity() <= 0) {  // Check if the book is out of stock
            System.out.println("Book is out of stock for Book ID: " + bookId);
            response.sendRedirect(request.getContextPath() + "/users/userHome.jsp?error=outOfStock");
            return;
        }

        int rentalDays = 1;  // Define the number of rental days

        // Set rental start and due dates
        Calendar calendar = Calendar.getInstance();
        Date rentalStart = new Date(calendar.getTimeInMillis());
        calendar.add(Calendar.DAY_OF_YEAR, rentalDays);
        Date rentalDue = new Date(calendar.getTimeInMillis());

        Rental rental = new Rental();
        rental.setUserId(userId);
        rental.setBookId(bookId);
        rental.setRentalStart(rentalStart);
        rental.setRentalDue(rentalDue);

        boolean isRented = rentalDao.rentBook(userId, bookId, rental);

        if (isRented) {
            System.out.println("Book rented successfully for User ID: " + userId + " and Book ID: " + bookId);

            // Fetch the latest rentalId for this user and set it in the session
            int rentalId = rentalDao.getLatestRentalIdForUser(userId);  // New method call
            session.setAttribute("rentalId", rentalId);  // Store it in the session for later use

            // Update the book quantity after successful rental
            updateBookQuantity(bookId);

            // Prevent duplicate rentals by using redirect after the POST
            response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&success=rentSuccess");
        } else {
            System.out.println("Failed to rent book for User ID: " + userId + " and Book ID: " + bookId);
            response.sendRedirect(request.getContextPath() + "/users/userHome.jsp?error=rentFailed");
        }
    }


    private void updateBookQuantity(int bookId) {
        // Fetch the current quantity from the database
        Book book = bookDao.getBookById(bookId);
        int currentQuantity = book.getQuantity();

        System.out.println("Updating book quantity for Book ID: " + bookId + ", current quantity: " + currentQuantity);

        // Reduce the quantity by 1
        if (currentQuantity > 0) {
            int newQuantity = currentQuantity - 1;
            bookDao.updateBookQuantity(bookId, newQuantity);
            System.out.println("New quantity for Book ID: " + bookId + " is: " + newQuantity);
        }
    }

    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rentalIdStr = request.getParameter("rentalId");  // Get rentalId from the form

        if (rentalIdStr == null || rentalIdStr.isEmpty()) {
            System.out.println("Rental ID is missing from the request.");
            response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&error=returnFailed");
            return;
        }

        try {
            int rentalId = Integer.parseInt(rentalIdStr);
            System.out.println("Processing return for Rental ID: " + rentalId);

            Rental rental = rentalDao.getRentalById(rentalId);

            if (rental == null) {
                System.out.println("Rental with ID: " + rentalId + " not found.");
                response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&error=returnFailed");
                return;
            }

            // Set the return date to the current date
            Date returnDate = new Date(System.currentTimeMillis());
            rental.setRentalReturned(returnDate);

            // Calculate fine if the return date is past the due date
            long fine = 0;
            if (returnDate.after(rental.getRentalDue())) {
                long daysLate = (returnDate.getTime() - rental.getRentalDue().getTime()) / (1000 * 60 * 60 * 24);
                fine = daysLate * 10;  // Example fine of $10 per day late
                System.out.println("Late return. Days late: " + daysLate + ", Fine: " + fine);
            }
            rental.setFine(fine);
            rental.setStatus("Returned");

            boolean isUpdated = rentalDao.updateRental(rental);

            if (isUpdated) {
                System.out.println("Rental returned successfully. Rental ID: " + rentalId);

                // Increase the book quantity after return
                updateBookQuantityAfterReturn(rental.getBookId());
                response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&success=returnSuccess");
            } else {
                System.out.println("Failed to update rental for Rental ID: " + rentalId);
                response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&error=returnFailed");
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid rental ID: " + rentalIdStr);
            response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&error=returnFailed");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/rental?action=viewHistory&error=returnFailed");
        }
    }


    private void updateBookQuantityAfterReturn(int bookId) {
        Book book = bookDao.getBookById(bookId);
        int currentQuantity = book.getQuantity();
        int newQuantity = currentQuantity + 1;
        bookDao.updateBookQuantity(bookId, newQuantity);
        System.out.println("Updated book quantity after return. Book ID: " + bookId + ", New quantity: " + newQuantity);
    }

    private void showRentalHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        System.out.println("Fetching rental history for User ID: " + userId);

        // Fetch rental history for the user
        List<Rental> rentals = rentalDao.getRentalHistoryByUserId(userId);

        // Set rentals as a request attribute
        request.setAttribute("rentals", rentals);

        // Forward to the rental history JSP
        request.getRequestDispatcher("/users/rentalHistory.jsp").forward(request, response);
    }
}
