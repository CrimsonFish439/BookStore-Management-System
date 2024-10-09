package com.crimsonlogic.bms3.dao;

import com.crimsonlogic.bms3.model.Wallet;

public interface WalletDao {
	boolean addToWallet(int userId, double amount);
    boolean deductFromWallet(int userId, double amount);
    Wallet getWalletByUserId(int userId);
}
