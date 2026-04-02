UPDATE inventory SET
    total_purchased = (
    SELECT COALESCE(SUM(quantity_purchased),0) 
    FROM purchases 
    WHERE product_name = inventory.product_name),

    remaining = quantity_produced - 
   ( SELECT COALESCE(SUM(quantity_purchased),0) 
    FROM purchases
    WHERE product_name = inventory.product_name);