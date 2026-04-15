SELECT 
    p.product_name,
    SUM(o.total_price) AS total_revenue
FROM products p
JOIN orders o 
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.total_price) = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT 
            SUM(total_price) AS total_revenue
        FROM orders
        GROUP BY product_id
    ) AS sub
);