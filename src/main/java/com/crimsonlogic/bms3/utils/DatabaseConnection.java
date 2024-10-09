package com.crimsonlogic.bms3.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

	private static final String URL = "jdbc:postgresql://localhost:5432/bms3";
	private static final String USERNAME = "postgres";
	private static final String PASSWORD = "crimson@123";
	
	static {
		try {
	        Class.forName("org.postgresql.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	
	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}
	
	public static void closeConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public static void printSQLException(SQLException se){
		for(Throwable te:se){
			if(te instanceof SQLException){
				te.printStackTrace(System.err);
				System.err.println("SQLState : "+ ((SQLException) te).getSQLState());
				System.err.println("Error Code : " + ((SQLException) te).getErrorCode());
				System.err.println("Message : " + te.getMessage());
				Throwable t =  se.getCause();
				while(t!=null){
					System.out.println("Cause : " + t.getCause());
				}
			}
		}
	}
	
}
