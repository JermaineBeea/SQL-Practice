SELECT product_name
FROM purchases
GROUP BY product_name
HAVING SUM(quantity_purchased) = (
    SELECT MAX(totals) FROM (
        SELECT SUM(quantity_purchased) AS totals
        FROM purchases
        GROUP BY product_name
    )
);