CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price) VALUES
(1, 'Laptop', 1, 1500),
(1, 'Mouse', 2, 25),
(2, 'Keyboard', 1, 50);

CREATE OR REPLACE PROCEDURE calculate_order_total(
    IN order_id_input INT, 
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;

    IF total IS NULL THEN
        total := 0;
    END IF;
END;
$$;
DO $$
DECLARE
    v_total NUMERIC;
BEGIN
    CALL calculate_order_total(1, v_total);
    RAISE NOTICE 'Total: %', v_total;
END $$;
