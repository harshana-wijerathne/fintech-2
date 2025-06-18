package site.wijerathne.harshana.fintech.model;

import lombok.*;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SavingAccount {
    private String accountNumber;
    private String customerId;
    private Timestamp openingDate;
    private BigDecimal balance;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}

