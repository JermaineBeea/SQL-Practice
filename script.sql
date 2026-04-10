BEGIN;
    INSERT INTO purchases (customer_email, product_name, quantity_purchased) VALUES ('mark@gmail.com', 'sofa', 5);
    INSERT INTO purchases (customer_email, product_name, quantity_purchased) VALUES ('susan@gmail.com', 'chair', 7);
    INSERT OR IGNORE INTO purchases (customer_email, product_name, quantity_purchased) VALUES ('peter@gmail.com', 'bench', 11);
COMMIT;