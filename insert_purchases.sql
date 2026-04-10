INSERT INTO purchases (customer_email, product_name, quantity_purchased)
VALUES ('peter@gmail.com', 'bench', 11)
RETURNING *;