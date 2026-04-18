CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

INSERT INTO Product (name, category, price, stock) VALUES
('iPhone 13', 'Điện tử', 20000000, 10),
('Samsung TV', 'Điện tử', 15000000, 5),
('Laptop Dell', 'Điện tử', 18000000, 7),
('Bàn phím cơ', 'Phụ kiện', 2000000, 20),
('Chuột Logitech', 'Phụ kiện', 1000000, 15);

SELECT * FROM Product;

SELECT * FROM Product
ORDER BY price DESC
LIMIT 3;

SELECT * FROM Product
WHERE category = 'Điện tử' AND price < 10000000;

SELECT * FROM Product
ORDER BY stock ASC;