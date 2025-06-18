package site.wijerathne.harshana.fintech.model;

import lombok.*;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Transaction {
    private String transactionId;
    private String accountNumber;
    private Timestamp transactionDate;
    private String transactionType;
    private BigDecimal amount;
    private BigDecimal balanceAfter;
}

