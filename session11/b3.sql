CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    stock INT CHECK (stock >= 0),
    price NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    total_amount NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    subtotal NUMERIC(10,2)
);

INSERT INTO products (product_name, stock, price)
VALUES ('Laptop', 10, 1000.00), ('Mouse', 5, 20.00);

BEGIN;

INSERT INTO orders (customer_name, total_amount) 
VALUES ('Nguyen Van A', 2020.00);

UPDATE products SET stock = stock - 2 WHERE product_id = 1;
INSERT INTO order_items (order_id, product_id, quantity, subtotal) 
VALUES (1, 1, 2, 2000.00);

UPDATE products SET stock = stock - 1 WHERE product_id = 2;
INSERT INTO order_items (order_id, product_id, quantity, subtotal) 
VALUES (1, 2, 1, 20.00);

COMMIT;

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

BEGIN;

INSERT INTO orders (customer_name, total_amount) 
VALUES ('Nguyen Van A', 200.00);

UPDATE products SET stock = stock - 1 WHERE product_id = 1;

UPDATE products SET stock = stock - 10 WHERE product_id = 2;

ROLLBACK;

SELECT * FROM products;
SELECT * FROM orders;