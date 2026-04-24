DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    amount NUMERIC(10,2)
);

INSERT INTO Sales (customer_id, product_id, sale_date, amount) VALUES
(1, 101, '2024-10-01', 200),
(1, 102, '2024-10-02', 500),
(1, 103, '2024-10-03', 400),
(2, 101, '2024-10-01', 300),
(2, 104, '2024-10-02', 200),
(3, 105, '2024-10-01', 1500),
(3, 106, '2024-10-02', 200),
(4, 107, '2024-10-01', 100),
(4, 108, '2024-10-02', 150),
(5, 109, '2024-10-01', 2000);

CREATE OR REPLACE VIEW CustomerSales AS
SELECT 
    customer_id,
    SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;

SELECT * 
FROM CustomerSales
WHERE total_amount > 1000;

UPDATE CustomerSales
SET total_amount = 5000
WHERE customer_id = 1;