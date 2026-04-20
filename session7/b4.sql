CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

CREATE TABLE order_detail (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES product(product_id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

CREATE OR REPLACE VIEW v_revenue_by_region AS
SELECT 
    c.region,
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'completed'    

SELECT 
    region,
    total_revenue,
    total_orders,
    total_customers,
    ROUND(total_revenue / SUM(total_revenue) OVER () * 100, 2) AS revenue_percentage
FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;


CREATE OR REPLACE VIEW v_revenue_above_avg AS
SELECT 
    region,
    total_revenue,
    total_orders,
    total_customers,
    (SELECT AVG(total_revenue) FROM v_revenue_by_region) AS national_average
FROM v_revenue_by_region
WHERE total_revenue > (SELECT AVG(total_revenue) FROM v_revenue_by_region)
ORDER BY total_revenue DESC;


SELECT * FROM v_revenue_above_avg;

SELECT * FROM v_revenue_above_avg 
LIMIT 3;


CREATE TABLE IF NOT EXISTS customer (...);   
CREATE TABLE IF NOT EXISTS orders (...);
CREATE TABLE IF NOT EXISTS product (...);
CREATE TABLE IF NOT EXISTS order_detail (...);

CREATE OR REPLACE VIEW v_revenue_by_region AS
SELECT 
    c.region,
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('completed', 'shipped')   -- tùy chỉnh theo business logic
GROUP BY c.region;

SELECT 
    region, 
    total_revenue,
    ROUND(total_revenue / SUM(total_revenue) OVER () * 100, 2) AS percentage
FROM v_revenue_by_region
ORDER BY total_revenue DESC 
LIMIT 3;

CREATE OR REPLACE VIEW v_revenue_above_avg AS
SELECT *
FROM v_revenue_by_region
WHERE total_revenue > (SELECT AVG(total_revenue) FROM v_revenue_by_region)
ORDER BY total_revenue DESC;

SELECT * FROM v_revenue_above_avg;