CREATE TRIGGER trigger_2
AFTER INSERT ON purchases
BEGIN
    UPDATE inventory
    SET
        total_purchased = sub.total,
        remaining = quantity_produced - sub.total
    FROM (
        SELECT product_name, SUM(quantity_purchased) AS total
        FROM purchases
        GROUP BY product_name
    ) AS sub
    WHERE inventory.product_name = sub.product_name;
END;