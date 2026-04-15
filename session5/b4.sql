DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10,2)
);

INSERT INTO customers (customer_name, city) VALUES
('Nguyễn Văn A', 'Hà Nội'),
('Trần Thị B', 'Đà Nẵng'),
('Lê Văn C', 'Hồ Chí Minh'),
('Phạm Thị D', 'Hà Nội');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-12-20', 3000),
(2, '2025-01-05', 1500),
(1, '2025-02-10', 2500),
(3, '2025-02-15', 4000),
(4, '2025-03-01', 800);

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop Dell', 2, 1500),
(2, 'iPhone 15', 1, 1500),
(3, 'Bàn học gỗ', 5, 500),
(4, 'Ghế xoay', 4, 1000);

SELECT 
    c.customer_name AS customer_name,
    o.order_date AS order_date,
    o.total_amount AS total_amount
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id;

SELECT 
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    MAX(total_amount) AS max_order,
    MIN(total_amount) AS min_order,
    COUNT(order_id) AS order_count
FROM orders;

SELECT 
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

SELECT 
    c.customer_name,
    c.city,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id;

SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_revenue)
    FROM (
        SELECT SUM(total_amount) AS customer_revenue
        FROM orders
        GROUP BY customer_id
    ) sub
);

SELECT customer_name FROM customers WHERE city = 'Hà Nội'
UNION
SELECT customer_name FROM customers WHERE city = 'Đà Nẵng';

SELECT customer_id FROM orders WHERE total_amount > 2000
INTERSECT
SELECT customer_id FROM orders WHERE total_amount < 5000;