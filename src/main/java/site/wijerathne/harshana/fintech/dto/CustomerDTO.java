package site.wijerathne.harshana.fintech.dto;

import lombok.*;
import java.sql.Date;
import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDTO {
    private String customerId;
    private String nicPassport;
    private String fullName;
    private Date dob;
    private String address;
    private String mobile;
    private String email;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}