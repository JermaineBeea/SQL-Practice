
WITH reference AS (
    SELECT *, (
        inventory.price * purchases.quantity_purchased
    ) AS total_expenditure
    FROM purchases LEFT JOIN inventory ON purchases.product_name = inventory.product_name
)

SELECT customer_email, SUM(reference.total_expenditure) AS gross_expenditure
FROM reference
GROUP BY reference.customer_email;

