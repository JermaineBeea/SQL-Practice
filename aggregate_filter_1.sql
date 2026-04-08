SELECT product_name
FROM purchases
GROUP BY product_name
HAVING COUNT(*) = (
    SELECT MAX(counts)
    FROM (
        SELECT COUNT(product_name) AS COUNTS
        FROM purchases
        GROUP BY product_name
    )
);