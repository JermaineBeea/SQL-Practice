WITH aggregates AS (
    SELECT product_name, COUNT(product_name) AS counts
    FROM purchases
    GROUP BY product_name
)
SELECT product_name
FROM aggregates
WHERE counts = (
    SELECT MAX(counts) FROM aggregates
);