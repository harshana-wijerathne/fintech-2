package site.wijerathne.harshana.fintech.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LoginRequestDTO {
    private String username;
    private String password;
}
