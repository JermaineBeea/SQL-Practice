UPDATE inventory SET
    total_purchased = reference.totals,
    remaining = quantity_produced - reference.totals
    FROM (
        SELECT product_name, SUM(quantity_purchased) AS totals
        FROM purchases
        GROUP BY purchases.product_name ORDER BY product_name DESC
    ) AS reference
    
    WHERE inventory.product_name = reference.product_name
;
    