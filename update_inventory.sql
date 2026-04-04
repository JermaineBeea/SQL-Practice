UPDATE inventory SET
    total_purchased = (
        SELECT COALESCE(SUM(p.quantity_purchased),0)
        FROM purchases AS p
        WHERE p.product_name = inventory.product_name
    ),
    remaining = quantity_produced - (
        SELECT COALESCE(SUM(p.quantity_purchased),0)
        FROM purchases AS p
        WHERE p.product_name = inventory.product_name
    )
;
