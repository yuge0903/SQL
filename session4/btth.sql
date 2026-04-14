DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(12,2),
    stock_quantity INT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date DATE,
    total_amount DECIMAL(12,2),
    status VARCHAR(20)
);

INSERT INTO customers (full_name, email, phone, city, join_date) VALUES
('Nguyễn Văn A','a@gmail.com','0901','Hà Nội','2023-01-01'),
('Trần Thị B','b@gmail.com',NULL,'HCM','2023-02-01'),
('Lê Văn C','c@gmail.com','0903','Đà Nẵng','2023-03-01'),
('Phạm D','d@gmail.com','0904','Hà Nội','2023-04-01'),
('Hoàng E','e@gmail.com',NULL,'HCM','2023-05-01'),
('Vũ F','f@gmail.com','0906','Hải Phòng','2023-06-01'),
('Đặng G','g@gmail.com','0907','Hà Nội','2023-07-01'),
('Bùi H','h@gmail.com','0908','Đà Nẵng','2023-08-01'),
('Đỗ I','i@gmail.com','0909','HCM','2023-09-01'),
('Ngô K','k@gmail.com','0910','Hà Nội','2023-10-01');

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Dell','Electronics',1500,10),
('iPhone 13','Electronics',1200,5),
('Samsung TV','Electronics',800,0),
('Bàn','Furniture',200,20),
('Ghế','Furniture',100,15),
('Tủ','Furniture',300,0),
('Áo thun','Clothing',50,100),
('Quần jeans','Clothing',80,50),
('Giày','Clothing',120,30),
('Tai nghe','Electronics',200,25),
('Chuột','Electronics',20,200),
('Bàn phím','Electronics',70,150),
('Tủ lạnh','Electronics',900,3),
('Máy giặt','Electronics',700,2),
('Đèn bàn','Furniture',40,10);

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1,'2024-01-01',200,'PENDING'),
(2,'2024-01-02',500,'CONFIRMED'),
(3,'2024-01-03',1000,'PENDING'),
(1,'2024-01-04',300,'CANCELLED'),
(4,'2024-01-05',700,'PENDING'),
(5,'2024-01-06',150,'CONFIRMED'),
(6,'2024-01-07',250,'PENDING'),
(7,'2024-01-08',900,'CONFIRMED');

UPDATE products
SET price = price * 1.10
WHERE category = 'Electronics';

UPDATE customers
SET phone = '0999999999'
WHERE email = 'b@gmail.com';

UPDATE orders
SET status = 'CONFIRMED'
WHERE status = 'PENDING';

DELETE FROM products
WHERE stock_quantity = 0;

DELETE FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
);

SELECT * FROM customers
WHERE full_name ILIKE '%nguyễn%';

SELECT * FROM products
WHERE price BETWEEN 100 AND 1000;

SELECT * FROM customers
WHERE phone IS NULL;

SELECT * FROM products
ORDER BY price DESC
LIMIT 5;

SELECT * FROM orders
ORDER BY order_date
LIMIT 3 OFFSET 3;

SELECT city, COUNT(*) 
FROM customers
GROUP BY city;

SELECT * FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-05';

SELECT * FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM orders o
);