package com.crimsonlogic.bms3.model;

import java.util.Objects;

public class Wallet {
    private int walletId;
    private int userId;
    private double balance;

    
    
    public Wallet() {
		super();
	}

	public Wallet(int walletId, int userId, double balance) {
		super();
		this.walletId = walletId;
		this.userId = userId;
		this.balance = balance;
	}

	// Getters and setters
    public int getWalletId() {
        return walletId;
    }

    public void setWalletId(int walletId) {
        this.walletId = walletId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

	@Override
	public int hashCode() {
		return Objects.hash(balance, userId, walletId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Wallet other = (Wallet) obj;
		return Double.doubleToLongBits(balance) == Double.doubleToLongBits(other.balance) && userId == other.userId
				&& walletId == other.walletId;
	}

	@Override
	public String toString() {
		return "Wallet [walletId=" + walletId + ", userId=" + userId + ", balance=" + balance + "]";
	}
    
    
}
