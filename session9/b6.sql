DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name TEXT,
    price NUMERIC(10,2),
    category_id INT
);

INSERT INTO Products (name, price, category_id) VALUES
('A', 100, 1),
('B', 200, 1),
('C', 150, 1),
('D', 300, 2),
('E', 250, 2),
('F', 400, 2),
('G', 500, 3);

CREATE OR REPLACE PROCEDURE update_product_price(
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    new_price NUMERIC;
BEGIN
    FOR rec IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
    LOOP
        new_price := rec.price + (rec.price * p_increase_percent / 100);

        UPDATE Products
        SET price = new_price
        WHERE product_id = rec.product_id;
    END LOOP;
END;
$$;

CALL update_product_price(1, 10);

SELECT * FROM Products WHERE category_id = 1;