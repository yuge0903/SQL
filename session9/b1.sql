DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2)
);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-10-01', 200000),
(2, '2024-10-02', 350000),
(3, '2024-10-03', 150000),
(1, '2024-10-04', 500000),
(2, '2024-10-05', 700000),
(4, '2024-10-06', 120000),
(5, '2024-10-07', 900000),
(1, '2024-10-08', 300000),
(3, '2024-10-09', 450000),
(2, '2024-10-10', 600000);

ANALYZE Orders;

EXPLAIN ANALYZE
SELECT * FROM Orders
WHERE customer_id = 1;

CREATE INDEX idx_orders_customer_id
ON Orders (customer_id);

ANALYZE Orders;

EXPLAIN ANALYZE
SELECT * FROM Orders
WHERE customer_id = 1;

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'orders';