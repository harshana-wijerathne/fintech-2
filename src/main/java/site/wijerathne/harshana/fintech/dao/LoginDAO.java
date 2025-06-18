package site.wijerathne.harshana.fintech.dao;

import site.wijerathne.harshana.fintech.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {
    public User getUserByUsername(String username,Connection connection) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return User.builder()
                        .userId(rs.getString("user_id"))
                        .username(rs.getString("username"))
                        .fullName(rs.getString("full_name"))
                        .password(rs.getString("password"))
                        .email(rs.getString("email"))
                        .role(rs.getString("role"))
                        .createdAt(rs.getTimestamp("created_at"))
                        .build();
            }

        } catch (Exception e) {
            e.printStackTrace(); // Use proper logging in production
        }

        return null;
    }
}
