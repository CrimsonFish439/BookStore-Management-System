package com.crimsonlogic.bms3.dao;

import java.util.List;
import java.util.Optional;

import com.crimsonlogic.bms3.model.User;

public interface UserDao {

	public boolean addUser(User user);
	
	public void updateUser(User user);
	
	public Optional<User> getUserById(int userId);
	
	public void restrictUser(int userId);
	
	public void unrestrictUser(int userId);
	
	public boolean isUserRestricted(int userId);
	
	public List<User> getAllRestrictedUsers();
	
	public User getUserByEmail(String userEmail);
	
	public List<User> getUsersWithOverdueBooks();
	
	Optional<User> getUserByEmailAndPassword(String email, String password);
	
    boolean isEmailExists(String email);
    
    boolean isPhoneExists(long phone);
}
