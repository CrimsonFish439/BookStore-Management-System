package com.crimsonlogic.bms3.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.crimsonlogic.bms3.model.Wallet;
import com.crimsonlogic.bms3.utils.DatabaseConnection;

public class WalletDaoImpl implements WalletDao {
    
    @Override
    public boolean addToWallet(int userId, double amount) {
        if (!walletExists(userId)) {
            createWalletForUser(userId);  // Create wallet if it doesn't exist
        }
        String sql = "UPDATE wallets SET balance = balance + ? WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setDouble(1, amount);
            preparedStatement.setInt(2, userId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deductFromWallet(int userId, double amount) {
        if (!walletExists(userId)) {
            return false;  // Can't deduct from a wallet that doesn't exist
        }
        String sql = "UPDATE wallets SET balance = balance - ? WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setDouble(1, amount);
            preparedStatement.setInt(2, userId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Wallet getWalletByUserId(int userId) {
        String sql = "SELECT * FROM wallets WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    Wallet wallet = new Wallet();
                    wallet.setWalletId(rs.getInt("wallet_id"));
                    wallet.setUserId(rs.getInt("user_id"));
                    wallet.setBalance(rs.getDouble("balance"));
                    return wallet;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private boolean walletExists(int userId) {
        String sql = "SELECT 1 FROM wallets WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                return rs.next();  // If a result is found, wallet exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean createWalletForUser(int userId) {
        String sql = "INSERT INTO wallets (user_id, balance) VALUES (?, 0.0)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
