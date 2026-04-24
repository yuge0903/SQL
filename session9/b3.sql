DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    category_id INT,
    price NUMERIC(10,2),
    stock_quantity INT
);

INSERT INTO Products (category_id, price, stock_quantity) VALUES
(1, 100, 50),
(1, 200, 30),
(1, 150, 20),
(2, 300, 40),
(2, 250, 35),
(2, 400, 10),
(3, 500, 15),
(3, 450, 25),
(3, 550, 5),
(1, 180, 60);

CREATE INDEX idx_products_category
ON Products (category_id);

CLUSTER Products USING idx_products_category;

CREATE INDEX idx_products_price
ON Products (price);

ANALYZE Products;

EXPLAIN ANALYZE
SELECT *
FROM Products
WHERE category_id = 1
ORDER BY price;