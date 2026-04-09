UPDATE inventory
SET 
    total_purchased = (
        SELECT SUM(quantity_purchased)
        FROM purchases
        WHERE purchases.product_name = inventory.product_name
    ),
    remaining = quantity_produced - (
        SELECT SUM(quantity_purchased)
        FROM purchases
        WHERE purchases.product_name = inventory.product_name
    )
;
