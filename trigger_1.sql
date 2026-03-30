DROP TRIGGER trigger_1;
CREATE TRIGGER trigger_1
AFTER INSERT ON purchases
BEGIN
    UPDATE inventory
    SET total_purchased = (
        SELECT COALESCE(SUM(quantity_purchased), 0)
        FROM purchases
        WHERE product_name = NEW.product_name
    ),
    remaining = quantity_produced - (
        SELECT COALESCE(SUM(quantity_purchased), 0)
        FROM purchases
        WHERE product_name = NEW.product_name
    )
    WHERE product_name = NEW.product_name;
END;