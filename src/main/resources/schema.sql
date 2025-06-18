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


CREATE TABLE users (
                       user_id     CHAR(36) PRIMARY KEY,
                       username    VARCHAR(100) UNIQUE NOT NULL,
                       full_name   VARCHAR(100)        NOT NULL,
                       password    VARCHAR(500)        NOT NULL,
                       email       VARCHAR(100),
                       role        ENUM('ADMIN', 'USER') DEFAULT 'USER',
                       created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE saving_accounts (
                                 account_number CHAR(36) PRIMARY KEY,
                                 customer_id    CHAR(36)                             NOT NULL,
                                 opening_date   DATETIME                             NOT NULL,
                                 balance        DECIMAL(15,2) DEFAULT 0.00           NOT NULL CHECK (balance >= 0),
                                 created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);


CREATE TABLE transactions (
                              transaction_id    CHAR(36) PRIMARY KEY,
                              account_number    CHAR(36)                              NOT NULL,
                              transaction_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              transaction_type  ENUM('DEPOSIT', 'WITHDRAW')           NOT NULL,
                              amount            DECIMAL(15,2)                         NOT NULL CHECK (amount > 0.00),
                              balance_after     DECIMAL(15,2)                         NOT NULL,
                              FOREIGN KEY (account_number) REFERENCES saving_accounts(account_number) ON DELETE CASCADE
);

CREATE TABLE audit_logs (
                            log_id         BIGINT AUTO_INCREMENT PRIMARY KEY,
                            actor_user_id  CHAR(36)                         NOT NULL,  -- who did the action
                            action_type    ENUM('CREATE', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT') NOT NULL,
                            entity_type    ENUM('CUSTOMER', 'ACCOUNT', 'TRANSACTION', 'USER')    NOT NULL,
                            entity_id      CHAR(36),  -- ID of the affected record (nullable for LOGIN/LOGOUT)
                            description    TEXT,
                            ip_address     VARCHAR(45),   -- support for IPv6
                            created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                            INDEX idx_actor_user_id (actor_user_id),
                            INDEX idx_entity_type (entity_type),
                            INDEX idx_created_at (created_at)
);

