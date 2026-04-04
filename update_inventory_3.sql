WITH reference AS (
    SELECT product_name, SUM(quantity_purchased) AS totals
    FROM purchases
    GROUP BY product_name
)
UPDATE inventory
SET total_purchased = reference.totals,
    remaining = quantity_produced - reference.totals
FROM reference
WHERE inventory.product_name = reference.product_name;