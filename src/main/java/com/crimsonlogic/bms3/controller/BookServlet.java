package com.crimsonlogic.bms3.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crimsonlogic.bms3.dao.BookDao;
import com.crimsonlogic.bms3.dao.BookDaoImpl;
import com.crimsonlogic.bms3.model.Book;

@WebServlet("/book")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDao bookDao;

    public void init() {
        bookDao = new BookDaoImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addBook(request, response);
                break;
            case "update":
                updateBook(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                response.sendRedirect("admin/adminHome.jsp");
                break;
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");

        Book newBook = new Book();
        newBook.setTitle(title);
        newBook.setAuthor(author);
        newBook.setPrice(price);
        newBook.setQuantity(quantity);
        newBook.setDescription(description);
        newBook.setGenre(genre);  // Set genre

        boolean isBookAdded = bookDao.addBook(newBook);
        if (isBookAdded) {
            response.sendRedirect("admin/displayBooks.jsp?success=true");
        } else {
            response.sendRedirect("admin/addBook.jsp?error=true");
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");

        Book updatedBook = new Book(bookId, title, author, price, quantity, description, genre);

        boolean isBookUpdated = bookDao.updateBook(updatedBook);
        if (isBookUpdated) {
            response.sendRedirect("admin/displayBooks.jsp?success=true");
        } else {
            response.sendRedirect("admin/editBook.jsp?bookId=" + bookId + "&error=true");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        System.out.println("Attempting to delete book with ID: " + bookId);

        boolean isBookDeleted = bookDao.deleteBook(bookId);
        if (isBookDeleted) {
            System.out.println("Book deleted successfully. Redirecting to displayBooks.jsp.");
            response.sendRedirect(request.getContextPath() + "/admin/displayBooks.jsp?success=true");
        } else {
            System.out.println("Book deletion failed. Redirecting to displayBooks.jsp with error.");
            response.sendRedirect(request.getContextPath() + "/admin/displayBooks.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
