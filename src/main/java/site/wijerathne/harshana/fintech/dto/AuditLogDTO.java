package site.wijerathne.harshana.fintech.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuditLogDTO {
    private String actorUserId;
    private String actionType;
    private String entityType;
    private String entityId;
    private String description;
    private String ipAddress;
}