package com.crimsonlogic.bms3.model;

import java.time.LocalDate;
import java.util.Objects;

public class User {
	
	private int userId;
	private String userFirstName;
    private String userLastName;
    private String userEmail;
    private String userPassword;
    private long userPhoneNo;
    private LocalDate userDateOfBirth;
    private boolean isRestricted;
    private boolean isAdmin; 
    
	public User() {
		super();
	}
	
	public User(int userId, String userFirstName, String userLastName, String userEmail, String userPassword,
            long userPhoneNo, LocalDate userDateOfBirth, boolean isRestricted, boolean isAdmin) {
    this.userId = userId;
    this.userFirstName = userFirstName;
    this.userLastName = userLastName;
    this.userEmail = userEmail;
    this.userPassword = userPassword;
    this.userPhoneNo = userPhoneNo;
    this.userDateOfBirth = userDateOfBirth;
    this.isRestricted = isRestricted;
    this.isAdmin = isAdmin;
}
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserFirstName() {
		return userFirstName;
	}
	public void setUserFirstName(String userFirstName) {
		this.userFirstName = userFirstName;
	}
	public String getUserLastName() {
		return userLastName;
	}
	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public long getUserPhoneNo() {
		return userPhoneNo;
	}
	public void setUserPhoneNo(long userPhoneNo) {
		this.userPhoneNo = userPhoneNo;
	}
	public LocalDate getUserDateOfBirth() {
		return userDateOfBirth;
	}
	public void setUserDateOfBirth(LocalDate userDateOfBirth) {
		this.userDateOfBirth = userDateOfBirth;
	}
	public boolean isRestricted() {
		return isRestricted;
	}
	public void setRestricted(boolean isRestricted) {
		this.isRestricted = isRestricted;
	}
	public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, userFirstName, userLastName, userEmail, userPassword, userPhoneNo, userDateOfBirth, isRestricted, isAdmin);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null || getClass() != obj.getClass())
            return false;
        User other = (User) obj;
        return userId == other.userId &&
               Objects.equals(userFirstName, other.userFirstName) &&
               Objects.equals(userLastName, other.userLastName) &&
               Objects.equals(userEmail, other.userEmail) &&
               Objects.equals(userPassword, other.userPassword) &&
               userPhoneNo == other.userPhoneNo &&
               Objects.equals(userDateOfBirth, other.userDateOfBirth) &&
               isRestricted == other.isRestricted &&
               isAdmin == other.isAdmin;
    }

    @Override
    public String toString() {
        return "User [userId=" + userId + ", userFirstName=" + userFirstName + ", userLastName=" + userLastName
                + ", userEmail=" + userEmail + ", userPassword=" + userPassword + ", userPhoneNo=" + userPhoneNo
                + ", userDateOfBirth=" + userDateOfBirth + ", isRestricted=" + isRestricted + ", isAdmin=" + isAdmin + "]";
    }
    
}
