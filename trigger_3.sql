-- DROP  TRIGGER trigger_3;
CREATE TRIGGER trigger_3
AFTER INSERT ON purchases
BEGIN
    UPDATE inventory
    SET total_purchased = total_purchased + NEW.quantity_purchased,
        remaining = quantity_produced - (total_purchased + NEW.quantity_purchased)
    WHERE product_name = NEW.product_name;
END;