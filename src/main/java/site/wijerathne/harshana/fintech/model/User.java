package site.wijerathne.harshana.fintech.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String userId;
    private String username;
    private String fullName;
    private String password;
    private String email;
    private String role;
    private Timestamp createdAt;
}
