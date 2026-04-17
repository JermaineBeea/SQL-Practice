-- CUSTOMER PURCHASE VARIANCE
-- Computes population variance of purchase quantities per customer.
-- This measures volatility in purchasing behavior.

WITH reference AS (
    SELECT
        customer_email,
        quantity_purchased,
        POWER(
            quantity_purchased
            - AVG(quantity_purchased) OVER (PARTITION BY customer_email),
            2
        ) AS square_difference
    FROM purchases
)
SELECT
    customers.name,
    AVG(reference.square_difference) AS purchase_variance
FROM customers
JOIN reference
ON customers.email = reference.customer_email
GROUP BY customers.email, customers.name;
``