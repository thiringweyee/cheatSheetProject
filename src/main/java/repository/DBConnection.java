package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() {
		Connection con=null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/cheatsheetsPrj","root","12345678");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver error : "+e.getMessage());
		} catch (SQLException e) {
			System.out.println("connection error : "+e.getMessage());
		}
		return con;
	}
}
