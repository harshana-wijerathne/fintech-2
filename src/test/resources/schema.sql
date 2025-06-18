CREATE TABLE customers (
                           customer_id    CHAR(36) PRIMARY KEY,
                           nic_passport   VARCHAR(50) UNIQUE NOT NULL,
                           full_name      VARCHAR(100)       NOT NULL,
                           dob            DATE               NOT NULL,
                           address        TEXT               NOT NULL,
                           mobile_no      VARCHAR(15)        NOT NULL,
                           email          VARCHAR(100),
                           created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           INDEX idx_customer_name (full_name),
                           INDEX idx_nic (nic_passport)
);
