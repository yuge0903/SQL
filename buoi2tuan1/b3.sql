CREATE SCHEMA sales;

CREATE TABLE sales.customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE sales.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price REAL NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE sales.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id)
);

CREATE TABLE sales.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity >= 1),
    FOREIGN KEY (order_id) REFERENCES sales.orders(order_id),
    FOREIGN KEY (product_id) REFERENCES sales.products(product_id)
);
SELECT datname 
FROM pg_database;

SELECT schema_name
FROM information_schema.schemata;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'sales';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'sales'
AND table_name = 'customers';