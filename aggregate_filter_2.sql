WITH reference AS (
    SELECT product_name,
    SUM(quantity_purchased) AS totals
    FROM purchases
    GROUP BY product_name
)
SELECT product_name
FROM reference
WHERE totals = (
    SELECT MAX(totals) FROM reference
);