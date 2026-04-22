CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    discount_percent INT
);

INSERT INTO products (name, price, discount_percent) 
VALUES ('Tivi', 1000, 20), ('Loa', 500, 70);

CREATE OR REPLACE PROCEDURE calculate_discount(p_id INT, OUT p_final_price NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC;
    v_discount INT;
BEGIN
    SELECT price, discount_percent INTO v_price, v_discount 
    FROM products WHERE id = p_id;

    IF v_discount > 50 THEN
        v_discount := 50;
    END IF;

    p_final_price := v_price - (v_price * v_discount / 100);

    UPDATE products SET price = p_final_price WHERE id = p_id;
END;
$$;

DO $$
DECLARE
    v_res NUMERIC;
BEGIN
    CALL calculate_discount(2, v_res);
    RAISE NOTICE 'Giá sau giảm là: %', v_res;
END $$;

SELECT * FROM products;