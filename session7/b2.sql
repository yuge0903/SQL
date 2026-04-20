DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO customer (full_name, email, phone) VALUES
('Nguyen Van A', 'a@gmail.com', '0901'),
('Tran Thi B', 'b@gmail.com', '0902'),
('Le Van C', 'c@gmail.com', '0903');

INSERT INTO orders (customer_id, total_amount, order_date) VALUES
(1, 500000, '2024-01-10'),
(1, 1500000, '2024-02-15'),
(2, 2000000, '2024-02-20'),
(3, 800000, '2024-03-05'),
(2, 1200000, '2024-03-18');

CREATE OR REPLACE VIEW v_order_summary AS
SELECT 
    c.full_name,
    o.total_amount,
    o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;
SELECT * FROM v_order_summary;

CREATE OR REPLACE VIEW v_order_high_value AS
SELECT 
    c.full_name,
    o.total_amount,
    o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount >= 1000000;
SELECT * FROM v_order_high_value;

UPDATE orders
SET total_amount = 3000000
WHERE order_id = 2;

CREATE OR REPLACE VIEW v_monthly_sales AS
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
SELECT * FROM v_monthly_sales;

DROP VIEW v_order_summary;
DROP VIEW v_order_high_value;
DROP VIEW v_monthly_sales;

CREATE MATERIALIZED VIEW mv_monthly_sales AS
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

--VIEW:
--Không lưu dữ liệu
--Luôn mới
--JOIN không update
--MATERIALIZED VIEW:
--Lưu dữ liệu thật
--Nhanh hơn
--Phải REFRESH