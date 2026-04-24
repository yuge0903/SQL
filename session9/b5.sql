DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC(10,2),
    sale_date DATE
);

INSERT INTO Sales (customer_id, amount, sale_date) VALUES
(1, 200, '2024-10-01'),
(1, 500, '2024-10-02'),
(2, 300, '2024-10-03'),
(2, 700, '2024-10-04'),
(3, 1500, '2024-10-05'),
(3, 200, '2024-10-06'),
(4, 100, '2024-10-07'),
(5, 2000, '2024-10-08');

CREATE OR REPLACE PROCEDURE calculate_total_sales(
    IN start_date DATE,
    IN end_date DATE,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(amount)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;

CALL calculate_total_sales('2024-10-01', '2024-10-05', NULL);

-- Cách xem kết quả trong psql
DO $$
DECLARE result NUMERIC;
BEGIN
    CALL calculate_total_sales('2024-10-01', '2024-10-05', result);
    RAISE NOTICE 'Total = %', result;
END;
$$;