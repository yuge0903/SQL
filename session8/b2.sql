CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT
);

INSERT INTO inventory (product_name, quantity) 
VALUES ('iPhone 15', 10), ('Macbook M3', 2);

CREATE OR REPLACE PROCEDURE check_stock(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_current_qty INT;
BEGIN
    SELECT quantity INTO v_current_qty FROM inventory WHERE product_id = p_id;

    IF v_current_qty < p_qty THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho';
    ELSE
        RAISE NOTICE 'Đủ hàng. Số lượng hiện có: %, yêu cầu: %', v_current_qty, p_qty;
    END IF;
END;
$$;

CALL check_stock(1, 5);

CALL check_stock(1, 20);