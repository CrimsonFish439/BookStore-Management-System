package com.crimsonlogic.bms3.model;

import java.util.Objects;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private double price;
    private int quantity;
    private String description;
    private String genre;
    private int cartQuantity;  // This is the quantity the user is purchasing

    // Default constructor
    public Book() {}

    // Parameterized constructor
    public Book(int bookId, String title, String author, double price, int quantity, String description, String genre) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
        this.genre = genre;
    }

    public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	// Getters and Setters
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public int getCartQuantity() {
        return cartQuantity;
    }

    public void setCartQuantity(int cartQuantity) {
        this.cartQuantity = cartQuantity;
    }

	@Override
	public int hashCode() {
		return Objects.hash(author, bookId, description, genre, price, quantity, title);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		return Objects.equals(author, other.author) && bookId == other.bookId
				&& Objects.equals(description, other.description) && Objects.equals(genre, other.genre)
				&& Double.doubleToLongBits(price) == Double.doubleToLongBits(other.price) && quantity == other.quantity
				&& Objects.equals(title, other.title);
	}

	@Override
	public String toString() {
		return "Book [bookId=" + bookId + ", title=" + title + ", author=" + author + ", price=" + price + ", quantity="
				+ quantity + ", description=" + description + ", genre=" + genre + "]";
	}

    
}
