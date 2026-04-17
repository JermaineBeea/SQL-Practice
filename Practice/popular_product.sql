-- Most popular product(s) per customer.
-- If multiple products tie for highest quantity, all are returned.

WITH
grouped_purchase AS (
    SELECT
        customer_email,
        product_name,
        SUM(quantity_purchased) AS customer_totals
    FROM purchases
    GROUP BY customer_email, product_name
),
ranked_purchases AS (
    SELECT
        customer_email,
        product_name,
        customer_totals,
        RANK() OVER (
            PARTITION BY customer_email
            ORDER BY customer_totals DESC
        ) AS sub_group_ranking
    FROM grouped_purchase
)
SELECT
    customers.name,
    STRING_AGG(product_name, ',') AS popluar_products
FROM customers
JOIN ranked_purchases
ON customers.email = ranked_purchases.customer_email
WHERE ranked_purchases.sub_group_ranking = 1
GROUP BY customers.name;