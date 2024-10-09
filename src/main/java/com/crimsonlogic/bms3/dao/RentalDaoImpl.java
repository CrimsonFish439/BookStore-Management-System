package com.crimsonlogic.bms3.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.crimsonlogic.bms3.model.Rental;
import com.crimsonlogic.bms3.utils.DatabaseConnection;

public class RentalDaoImpl implements RentalDao {

    @Override
    public boolean rentBook(int userId, int bookId, Rental rental) {
        String sql = "INSERT INTO rentals (user_id, book_id, rental_start, rental_due, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ps.setDate(3, new java.sql.Date(rental.getRentalStart().getTime()));
            ps.setDate(4, new java.sql.Date(rental.getRentalDue().getTime()));
            ps.setString(5, "active");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Rental> getRentalsByUserId(int userId) {
        List<Rental> rentals = new ArrayList<>();
        String sql = "SELECT * FROM rentals WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rental rental = new Rental();
                rental.setRentalId(rs.getInt("rental_id"));
                rental.setUserId(rs.getInt("user_id"));
                rental.setBookId(rs.getInt("book_id"));
                rental.setRentalStart(rs.getDate("rental_start"));
                rental.setRentalDue(rs.getDate("rental_due"));
                rental.setRentalReturned(rs.getDate("rental_returned"));
                rental.setFine(rs.getDouble("fine"));
                rental.setStatus(rs.getString("status"));
                rentals.add(rental);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rentals;
    }
    
    public List<Rental> getRentalHistoryByUserId(int userId) {
        List<Rental> rentals = new ArrayList<>();
        String sql = "SELECT * FROM rentals WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Rental rental = new Rental();
                    rental.setRentalId(rs.getInt("rental_id"));
                    rental.setUserId(rs.getInt("user_id"));
                    rental.setBookId(rs.getInt("book_id"));
                    rental.setRentalStart(rs.getDate("rental_start"));
                    rental.setRentalDue(rs.getDate("rental_due"));
                    rental.setRentalReturned(rs.getDate("rental_returned"));
                    rental.setFine(rs.getDouble("fine"));
                    rental.setStatus(rs.getString("status"));
                    rentals.add(rental);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rentals;
    }


    @Override
    public boolean returnBook(int rentalId, double fine) {
        String sql = "UPDATE rentals SET rental_returned = NOW(), fine = ?, status = 'returned' WHERE rental_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, fine);
            ps.setInt(2, rentalId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public Rental getRentalById(int rentalId) {
        System.out.println("Fetching rental with ID: " + rentalId);
        String query = "SELECT * FROM rentals WHERE rental_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, rentalId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Rental rental = new Rental();
                rental.setRentalId(rs.getInt("rental_id"));
                rental.setUserId(rs.getInt("user_id"));
                rental.setBookId(rs.getInt("book_id"));
                rental.setRentalStart(rs.getDate("rental_start"));
                rental.setRentalDue(rs.getDate("rental_due"));
                rental.setRentalReturned(rs.getDate("rental_returned"));
                rental.setFine(rs.getLong("fine"));
                rental.setStatus(rs.getString("status"));
                System.out.println("Rental found: " + rental);
                return rental;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Rental with ID: " + rentalId + " not found.");
        return null;
    }

    @Override
    public boolean updateRental(Rental rental) {
        System.out.println("Updating rental with ID: " + rental.getRentalId());
        String query = "UPDATE rentals SET rental_returned = ?, fine = ?, status = ? WHERE rental_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setDate(1, rental.getRentalReturned());
            ps.setDouble(2, rental.getFine());
            ps.setString(3, rental.getStatus());
            ps.setInt(4, rental.getRentalId());

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Rental with ID: " + rental.getRentalId() + " updated successfully.");
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Failed to update rental with ID: " + rental.getRentalId());
        return false;
    }
    
    @Override
    public int getLatestRentalIdForUser(int userId) {
        String sql = "SELECT rental_id FROM rentals WHERE user_id = ? ORDER BY rental_start DESC LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("rental_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;  // Return -1 if no rentals found or an error occurs
    }

}
