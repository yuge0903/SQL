DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS suppliers;

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100),
    description TEXT
);

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Books'),
('Furniture');

INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Laptop', 1, 2000, 10),
('Phone', 1, 1000, 20),
('Novel Book', 2, 20, 50),
('Chair', 3, 100, 15);

INSERT INTO customers (customer_name, email, city, join_date) VALUES
('Nguyen A', 'a@gmail.com', 'Hanoi', '2024-01-01'),
('Tran B', 'b@gmail.com', 'Danang', '2024-02-01'),
('Le C', 'c@gmail.com', 'HCM', '2024-03-01');

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2026-01-01', 3000, 'Completed'),
(1, '2026-02-01', 2000, 'Completed'),
(2, '2026-03-01', 1500, 'Pending'),
(3, '2026-04-01', 4000, 'Completed');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 2000),
(1, 2, 1, 1000),
(2, 2, 2, 1000),
(3, 3, 10, 20),
(4, 1, 2, 2000);

INSERT INTO suppliers (supplier_name, email) VALUES
('Supplier X', 'x@gmail.com'),
('Supplier Y', 'y@gmail.com');

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT REFERENCES categories(category_id),
    price NUMERIC(10,2),
    stock_quantity INT
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100),
    join_date DATE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2),
    status VARCHAR(50)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100),
    email VARCHAR(100)
);

-- 1
SELECT 
    product_name AS "Tên SP",
    price AS "Đơn giá",
    price * 1.1 AS "Giá VAT"
FROM products;

-- 2
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- 3
SELECT 
    MAX(price) AS max_price,
    MIN(price) AS min_price,
    AVG(price) AS avg_price
FROM products
WHERE stock_quantity > 0;

-- 4
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status;

-- 1
SELECT o.order_id, c.customer_name, c.email, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 10;

-- 2
SELECT ca.category_name, COUNT(p.product_id) AS total_products
FROM categories ca
LEFT JOIN products p ON ca.category_id = p.category_id
GROUP BY ca.category_name;

-- 3
SELECT c.customer_name, COUNT(o.order_id), SUM(o.total_amount)
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) >= 3 AND SUM(o.total_amount) > 5000000;

-- 4
SELECT ca.category_name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM categories ca
JOIN products p ON ca.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY ca.category_name;

-- 1
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 2
SELECT * FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

-- 3
SELECT * FROM products p
WHERE price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

-- 4
SELECT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount = (SELECT MAX(total_amount) FROM orders);
-- UNION
SELECT email FROM customers
UNION
SELECT email FROM suppliers;

-- INTERSECT
SELECT o.customer_id
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'

INTERSECT

SELECT o.customer_id
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Books';

-- EXCEPT
SELECT product_id FROM products
EXCEPT
SELECT product_id FROM order_items;

-- UPDATE
UPDATE orders o
SET total_amount = sub.total
FROM (
    SELECT order_id, SUM(quantity * unit_price) AS total
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id;

-- VIEW
CREATE VIEW vw_customer_summary AS
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- TOP CITY 2026
SELECT c.city, SUM(o.total_amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2026
GROUP BY c.city
ORDER BY revenue DESC
LIMIT 1;