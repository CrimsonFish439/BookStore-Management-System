package com.crimsonlogic.bms3.model;

import java.sql.Date;
import java.util.Objects;

public class Order {
    private int orderId;
    private int userId;
    private int bookId;
    private Date orderDate;
    private double price;
    private String status;

    public Order() {
		super();
	}

	public Order(int orderId, int userId, int bookId, Date orderDate, double price, String status) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.bookId = bookId;
		this.orderDate = orderDate;
		this.price = price;
		this.status = status;
	}



	// Getters and setters
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
    
    public Date getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }

	@Override
	public int hashCode() {
		return Objects.hash(bookId, orderDate, orderId, price, status, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Order other = (Order) obj;
		return bookId == other.bookId && Objects.equals(orderDate, other.orderDate) && orderId == other.orderId
				&& Double.doubleToLongBits(price) == Double.doubleToLongBits(other.price)
				&& Objects.equals(status, other.status) && userId == other.userId;
	}

	@Override
	public String toString() {
		return "Order [orderId=" + orderId + ", userId=" + userId + ", bookId=" + bookId + ", orderDate=" + orderDate
				+ ", price=" + price + ", status=" + status + "]";
	}
    
    
}
