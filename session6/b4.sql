DROP TABLE IF EXISTS OrderInfo;

CREATE TABLE OrderInfo (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total NUMERIC(10,2),
    status VARCHAR(20)
);

INSERT INTO OrderInfo (customer_id, order_date, total, status) VALUES
(1, '2024-10-01', 300000, 'Pending'),
(2, '2024-10-05', 700000, 'Completed'),
(3, '2024-09-28', 1200000, 'Shipped'),
(4, '2024-10-10', 450000, 'Cancelled'),
(5, '2024-10-15', 900000, 'Pending');

SELECT * FROM OrderInfo
WHERE total > 500000;


SELECT * FROM OrderInfo
WHERE order_date BETWEEN DATE '2024-10-01' AND DATE '2024-10-31';

-- (Cách khác)
-- WHERE EXTRACT(MONTH FROM order_date) = 10
--   AND EXTRACT(YEAR FROM order_date) = 2024;


SELECT * FROM OrderInfo
WHERE status <> 'Completed';

SELECT * FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;