package Connect;

import my.Apointment;

import java.sql.*;

public class Connect {
    private static final String URL = "jdbc:mysql://localhost:3306/aesculapius?useUnicode=true&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1234";
    private static String result;

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            result = e.toString();
        }
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
