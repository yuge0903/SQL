CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    balance NUMERIC(12,2)
);

CREATE TABLE transactions (
    trans_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    amount NUMERIC(12,2),
    trans_type VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO accounts (customer_name, balance) 
VALUES ('Nguyen Van A', 1000.00);

BEGIN;

UPDATE accounts 
SET balance = balance - 200.00 
WHERE account_id = 1 AND balance >= 200.00;

INSERT INTO transactions (account_id, amount, trans_type) 
VALUES (1, 200.00, 'WITHDRAW');

COMMIT;

SELECT * FROM accounts;
SELECT * FROM transactions;

BEGIN;

UPDATE accounts 
SET balance = balance - 100.00 
WHERE account_id = 1;

INSERT INTO transactions (account_id, amount, trans_type) 
VALUES (999, 100.00, 'WITHDRAW');

ROLLBACK;

SELECT * FROM accounts;
SELECT * FROM transactions;