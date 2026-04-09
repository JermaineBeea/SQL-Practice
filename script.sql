CREATE TRIGGER trigger_1
AFTER INSERT ON purchases
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET
        total_purchased = total_purchased + NEW.quantity_purchased,
        remaining = remaining - NEW.quantity_purchased
    WHERE inventory.product_name = NEW.product_name;
END;