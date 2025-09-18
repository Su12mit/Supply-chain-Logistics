package com.scm.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class PostgresConnection {

	
    // Database connection credentials
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/supply_chain"; // Update with your DB URL
    private static final String DB_USER = "postgres";  // Your DB username
    private static final String DB_PASSWORD = "root";  // Your DB password

    // Method to get a database connection
    public static Connection getConnection() throws SQLException {
        try {
        	try {
				Class.forName("org.postgresql.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
        	e.printStackTrace();
            throw new SQLException("Failed to establish database connection.", e);
        }
    }
}
