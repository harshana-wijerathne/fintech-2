INSERT INTO users (user_id, username, full_name, password, email, role)
VALUES
    (UUID(), 'admin', 'System Administrator', 'admin123', 'admin@example.com', 'ADMIN');

INSERT INTO customers (customer_id, nic_passport, full_name, dob, address, mobile_no, email)
VALUES
    (UUID(), 'NIC001', 'Alice Johnson', '1990-01-01', '123 Main St', '0771234567', 'alice@example.com'),
    (UUID(), 'NIC002', 'Bob Smith', '1985-02-15', '456 Lake Rd', '0772345678', 'bob@example.com'),
    (UUID(), 'NIC003', 'Charlie Brown', '1992-03-20', '789 Hill Ave', '0773456789', 'charlie@example.com'),
    (UUID(), 'NIC004', 'David Lee', '1988-04-10', '12 Ocean Dr', '0774567890', 'david@example.com'),
    (UUID(), 'NIC005', 'Emma Davis', '1995-05-25', '34 River St', '0775678901', 'emma@example.com'),
    (UUID(), 'NIC006', 'Frank Miller', '1980-06-30', '56 Sunset Blvd', '0776789012', 'frank@example.com'),
    (UUID(), 'NIC007', 'Grace Hall', '1991-07-12', '78 Forest Rd', '0777890123', 'grace@example.com'),
    (UUID(), 'NIC008', 'Hannah Wilson', '1989-08-18', '90 Mountain View', '0778901234', 'hannah@example.com'),
    (UUID(), 'NIC009', 'Ian Thomas', '1993-09-05', '21 Maple St', '0779012345', 'ian@example.com'),
    (UUID(), 'NIC010', 'Jane Taylor', '1987-10-22', '33 Garden Ln', '0770123456', 'jane@example.com');


-- Example with random UUIDs for clarity. Replace with actual customer_id values if already inserted.
INSERT INTO saving_accounts (account_number, customer_id, opening_date, balance)
VALUES
    (UUID(), (SELECT customer_id FROM customers WHERE nic_passport = 'NIC001'), NOW(), 5000.00),
    (UUID(), (SELECT customer_id FROM customers WHERE nic_passport = 'NIC002'), NOW(), 10000.00),
    (UUID(), (SELECT customer_id FROM customers WHERE nic_passport = 'NIC003'), NOW(), 7500.00),
    (UUID(), (SELECT customer_id FROM customers WHERE nic_passport = 'NIC004'), NOW(), 2000.00),
    (UUID(), (SELECT customer_id FROM customers WHERE nic_passport = 'NIC005'), NOW(), 3000.00);


INSERT INTO transactions (transaction_id, account_number, transaction_type, amount, balance_after)
VALUES
    (UUID(), (SELECT account_number FROM saving_accounts WHERE customer_id = (SELECT customer_id FROM customers WHERE nic_passport = 'NIC001')), 'DEPOSIT', 2000.00, 7000.00),
    (UUID(), (SELECT account_number FROM saving_accounts WHERE customer_id = (SELECT customer_id FROM customers WHERE nic_passport = 'NIC002')), 'WITHDRAW', 1000.00, 9000.00),
    (UUID(), (SELECT account_number FROM saving_accounts WHERE customer_id = (SELECT customer_id FROM customers WHERE nic_passport = 'NIC003')), 'DEPOSIT', 1500.00, 9000.00),
    (UUID(), (SELECT account_number FROM saving_accounts WHERE customer_id = (SELECT customer_id FROM customers WHERE nic_passport = 'NIC004')), 'DEPOSIT', 2000.00, 4000.00),
    (UUID(), (SELECT account_number FROM saving_accounts WHERE customer_id = (SELECT customer_id FROM customers WHERE nic_passport = 'NIC005')), 'WITHDRAW', 500.00, 2500.00);
