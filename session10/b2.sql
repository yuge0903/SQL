DROP TRIGGER IF EXISTS trg_check_credit ON orders;
DROP FUNCTION IF EXISTS check_credit_limit();
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    credit_limit NUMERIC
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_amount NUMERIC
);

CREATE OR REPLACE FUNCTION check_credit_limit()
RETURNS TRIGGER AS $$
DECLARE
    total_amount NUMERIC;
    limit_amount NUMERIC;
BEGIN
    -- Lấy tổng đơn hàng hiện tại của khách
    SELECT COALESCE(SUM(order_amount), 0)
    INTO total_amount
    FROM orders
    WHERE customer_id = NEW.customer_id;

    -- Lấy hạn mức của khách
    SELECT credit_limit
    INTO limit_amount
    FROM customers
    WHERE id = NEW.customer_id;

    -- Kiểm tra nếu vượt hạn mức
    IF total_amount + NEW.order_amount > limit_amount THEN
        RAISE EXCEPTION 'Vuot han muc tin dung!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_check_credit
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

INSERT INTO customers (name, credit_limit)
VALUES 
('An', 1000),
('Binh', 500);

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 300); -- OK

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 400); -- OK (tổng = 700)

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 400); 
-- ERROR: Vuot han muc tin dung!

SELECT * FROM orders;