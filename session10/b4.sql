DROP TRIGGER IF EXISTS trg_orders_stock ON orders;
DROP FUNCTION IF EXISTS manage_stock();
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    stock INT
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT
);

CREATE OR REPLACE FUNCTION manage_stock()
RETURNS TRIGGER AS $$
BEGIN
    -- INSERT: trừ stock
    IF TG_OP = 'INSERT' THEN
        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;

        RETURN NEW;
    END IF;

    -- UPDATE: điều chỉnh theo chênh lệch
    IF TG_OP = 'UPDATE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity - NEW.quantity
        WHERE id = NEW.product_id;

        RETURN NEW;
    END IF;

    -- DELETE: hoàn lại stock
    IF TG_OP = 'DELETE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;

        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_orders_stock
AFTER INSERT OR UPDATE OR DELETE ON orders
FOR EACH ROW
EXECUTE FUNCTION manage_stock();

INSERT INTO products (name, stock)
VALUES 
('Laptop', 10),
('Mouse', 50);

INSERT INTO orders (product_id, quantity)
VALUES (1, 2); -- stock còn 8

UPDATE orders
SET quantity = 5
WHERE id = 1; 
-- trước là 2  giờ 5  trừ thêm 3  stock còn 5

DELETE FROM orders
WHERE id = 1;
-- hoàn lại 5  stock về 10