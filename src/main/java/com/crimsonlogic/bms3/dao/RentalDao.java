package com.crimsonlogic.bms3.dao;

import java.util.List;
import com.crimsonlogic.bms3.model.Rental;

public interface RentalDao {
    boolean rentBook(int userId, int bookId, Rental rental);
    List<Rental> getRentalsByUserId(int userId);
    boolean returnBook(int rentalId, double fine);
    List<Rental> getRentalHistoryByUserId(int userId);
    public Rental getRentalById(int rentalId);
    public boolean updateRental(Rental rental);
	int getLatestRentalIdForUser(int userId);

}
