package com.crimsonlogic.bms3.dao;

import java.util.List;

import com.crimsonlogic.bms3.model.Book;

public interface BookDao {
	boolean addBook(Book book);
    boolean updateBook(Book book);
    boolean deleteBook(int id);
    Book getBookById(int id);
    List<Book> getAllBooks();
    List<Book> getBooksByGenre(String genre);
    List<String> getAllGenres();
    boolean updateBookQuantity(int bookId, int newQuantity);
}
