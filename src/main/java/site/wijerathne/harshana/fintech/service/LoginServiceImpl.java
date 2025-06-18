package site.wijerathne.harshana.fintech.service;

import org.mindrot.jbcrypt.BCrypt;
import site.wijerathne.harshana.fintech.dao.AuditLogDAO;
import site.wijerathne.harshana.fintech.dao.LoginDAO;
import site.wijerathne.harshana.fintech.dto.AuditLogDTO;
import site.wijerathne.harshana.fintech.dto.LoginRequestDTO;
import site.wijerathne.harshana.fintech.model.User;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;

public class LoginServiceImpl implements LoginService {

    private final LoginDAO loginDAO = new LoginDAO();
    private final AuditLogDAO auditLogDAO = new AuditLogDAO();

    public User authenticate(LoginRequestDTO loginDTO, HttpServletRequest request, Connection connection) {
        User user = loginDAO.getUserByUsername(loginDTO.getUsername(),connection);
        if (user != null && BCrypt.checkpw(loginDTO.getPassword(), user.getPassword())) {
            AuditLogDTO log = new AuditLogDTO(
                    user.getUserId(),
                    "LOGIN",
                    "USER",
                    null,
                    "User logged in",
                    request.getRemoteAddr()
            );
            auditLogDAO.saveAuditLog(log,connection);
            return user;
        }

        return null;
    }
}
