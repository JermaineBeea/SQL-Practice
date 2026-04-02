UPDATE inventory SET
    total_purchased = subQuery.totals,
    remaining = quantity_produced - subQuery.totals

    FROM (
        SELECT product_name, SUM(quantity_purchased) AS totals FROM purchases GROUP BY product_name
    ) AS subQuery
    WHERE inventory.product_name = subQuery.product_name;