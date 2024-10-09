package com.crimsonlogic.bms3.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.crimsonlogic.bms3.model.User;
import com.crimsonlogic.bms3.utils.DatabaseConnection;

public class UserDaoImpl implements UserDao{

	
	
	@Override
	public boolean addUser(User user) {
		String query = "INSERT INTO users (first_name, last_name, email, password, phone_no) VALUES (?, ?, ?, ?, ?);";
		boolean rowInserted = false;
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, user.getUserFirstName());
            preparedStatement.setString(2, user.getUserLastName());
            preparedStatement.setString(3, user.getUserEmail());
            preparedStatement.setString(4, user.getUserPassword());
            preparedStatement.setLong(5, user.getUserPhoneNo());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    
	}

	@Override
	public void updateUser(User user) {
		String query = "UPDATE users SET first_name = ?, last_name = ?, email = ?, password = ?, phone_no = ?, dob = ?, restricted = ? WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, user.getUserFirstName());
            preparedStatement.setString(2, user.getUserLastName());
            preparedStatement.setString(3, user.getUserEmail());
            preparedStatement.setString(4, user.getUserPassword());
            preparedStatement.setLong(5, user.getUserPhoneNo());
            preparedStatement.setDate(6, java.sql.Date.valueOf(user.getUserDateOfBirth()));
            preparedStatement.setBoolean(7, user.isRestricted());
            preparedStatement.setInt(8, user.getUserId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
	}

	@Override
	public Optional<User> getUserById(int userId) {
	    String query = "SELECT * FROM users WHERE user_id = ?";
	    try (Connection connection = DatabaseConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {
	        preparedStatement.setInt(1, userId);
	        ResultSet rs = preparedStatement.executeQuery();
	        if (rs.next()) {
	            return Optional.of(mapResultSetToUser(rs));
	        }
	    } catch (SQLException e) {
	        DatabaseConnection.printSQLException(e);
	    }
	    return Optional.empty(); // Return an empty Optional if no user is found
	}
	
	private User mapResultSetToUser(ResultSet rs) throws SQLException {
	    User user = new User();
	    user.setUserId(rs.getInt("user_id"));
	    user.setUserFirstName(rs.getString("first_name"));
	    user.setUserLastName(rs.getString("last_name"));
	    user.setUserEmail(rs.getString("email"));
	    user.setUserPassword(rs.getString("password"));
	    user.setUserPhoneNo(rs.getLong("phone_no"));
	    user.setUserDateOfBirth(rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null);
	    user.setRestricted(rs.getBoolean("is_restricted"));
	    user.setAdmin(rs.getBoolean("is_admin"));  // Fetch the admin status from the result set
	    return user;
	}


	@Override
	public void restrictUser(int userId) {
		String query = "UPDATE users SET restricted = true WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
	}

	@Override
	public void unrestrictUser(int userId) {
		String query = "UPDATE users SET restricted = false WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
	}

	@Override
	public boolean isUserRestricted(int userId) {
		String query = "SELECT restricted FROM users WHERE user_id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("restricted");
            }
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
        return false;
	}

	@Override
	public List<User> getAllRestrictedUsers() {
		List<User> restrictedUsers = new ArrayList<>();
        String query = "SELECT * FROM users WHERE restricted = true";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                restrictedUsers.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
        return restrictedUsers;
	}

	@Override
	public User getUserByEmail(String userEmail) {
		String query = "SELECT * FROM users WHERE email = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, userEmail);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
        return null;
	}

	@Override
	public List<User> getUsersWithOverdueBooks() {
		List<User> overdueUsers = new ArrayList<>();
        String query = "SELECT u.* FROM users u INNER JOIN rentals r ON u.user_id = r.user_id WHERE r.due_date < CURRENT_DATE AND r.returned = false";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                overdueUsers.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
        return overdueUsers;
	}

	@Override
	public Optional<User> getUserByEmailAndPassword(String email, String password) {
		 String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
		    try (Connection connection = DatabaseConnection.getConnection();
		         PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
		        preparedStatement.setString(1, email);
		        preparedStatement.setString(2, password);

		        try (ResultSet rs = preparedStatement.executeQuery()) {
		            if (rs.next()) {
		                return Optional.of(mapResultSetToUser(rs));
		            }
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return Optional.empty();
    }

	@Override
	public boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
        return false;
    }
	@Override
	public boolean isPhoneExists(long phone) {
        String query = "SELECT COUNT(*) FROM users WHERE phone_no = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setLong(1, phone);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            DatabaseConnection.printSQLException(e);
        }
        return false;
    }
}
