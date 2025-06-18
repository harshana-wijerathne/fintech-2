package site.wijerathne.harshana.fintech.dao;

import site.wijerathne.harshana.fintech.dto.AuditLogDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class AuditLogDAO {
    public void saveAuditLog(AuditLogDTO logDTO,Connection connection) {
        String sql = "INSERT INTO audit_logs (actor_user_id, action_type, entity_type, entity_id, description, ip_address) VALUES (?, ?, ?, ?, ?, ?)";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql);
        ) {
            stmt.setString(1, logDTO.getActorUserId());
            stmt.setString(2, logDTO.getActionType());
            stmt.setString(3, logDTO.getEntityType());
            stmt.setString(4, logDTO.getEntityId());
            stmt.setString(5, logDTO.getDescription());
            stmt.setString(6, logDTO.getIpAddress());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // You can improve this with a logger
        }
    }
}

