package com.crimsonlogic.bms3.model;

import java.sql.Date;
import java.util.Objects;

public class Rental {
    private int rentalId;
    private int userId;
    private int bookId;
    private Date rentalStart;
    private Date rentalDue;
    private Date rentalReturned;
    private double fine;
    private String status;

    public Rental() {
		super();
	}

	public Rental(int rentalId, int userId, int bookId, Date rentalStart, Date rentalDue, Date rentalReturned,
			double fine, String status) {
		super();
		this.rentalId = rentalId;
		this.userId = userId;
		this.bookId = bookId;
		this.rentalStart = rentalStart;
		this.rentalDue = rentalDue;
		this.rentalReturned = rentalReturned;
		this.fine = fine;
		this.status = status;
	}

	// Getters and setters
    public int getRentalId() {
        return rentalId;
    }

    public void setRentalId(int rentalId) {
        this.rentalId = rentalId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public Date getRentalStart() {
        return rentalStart;
    }

    public void setRentalStart(Date rentalStart) {
        this.rentalStart = rentalStart;
    }

    public Date getRentalDue() {
        return rentalDue;
    }

    public void setRentalDue(Date rentalDue) {
        this.rentalDue = rentalDue;
    }

    public Date getRentalReturned() {
        return rentalReturned;
    }

    public void setRentalReturned(Date rentalReturned) {
        this.rentalReturned = rentalReturned;
    }

    public double getFine() {
        return fine;
    }

    public void setFine(double fine) {
        this.fine = fine;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

	@Override
	public int hashCode() {
		return Objects.hash(bookId, fine, rentalDue, rentalId, rentalReturned, rentalStart, status, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Rental other = (Rental) obj;
		return bookId == other.bookId && Double.doubleToLongBits(fine) == Double.doubleToLongBits(other.fine)
				&& Objects.equals(rentalDue, other.rentalDue) && rentalId == other.rentalId
				&& Objects.equals(rentalReturned, other.rentalReturned)
				&& Objects.equals(rentalStart, other.rentalStart) && Objects.equals(status, other.status)
				&& userId == other.userId;
	}

	@Override
	public String toString() {
		return "Rental [rentalId=" + rentalId + ", userId=" + userId + ", bookId=" + bookId + ", rentalStart="
				+ rentalStart + ", rentalDue=" + rentalDue + ", rentalReturned=" + rentalReturned + ", fine=" + fine
				+ ", status=" + status + "]";
	}
}
