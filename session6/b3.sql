DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    points INT
);

INSERT INTO Customer (name, email, phone, points) VALUES
('Nguyen Van An', 'an@gmail.com', '0901234567', 100),
('Tran Thi Binh', 'binh@gmail.com', '0902345678', 200),
('Le Van C', NULL, '0903456789', 150),  -- ❗ không có email
('Pham Thi D', 'd@gmail.com', '0904567890', 300),
('Hoang Van E', 'e@gmail.com', '0905678901', 250),
('Nguyen Van An', 'an2@gmail.com', '0906789012', 180),
('Do Thi F', 'f@gmail.com', '0907890123', 220);

SELECT DISTINCT name FROM Customer;

SELECT * FROM Customer
WHERE email IS NULL;

SELECT * FROM Customer
ORDER BY points DESC
OFFSET 1
LIMIT 3;

SELECT * FROM Customer
ORDER BY name DESC;