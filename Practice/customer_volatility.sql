-- CUSTOMER PURCHASE VARIANCE
--
-- Purpose:
--   Measure how variable (volatile) each customer's purchasing behavior is.
--   Variance quantifies how far individual purchases deviate from the
--   customer's average purchase quantity.
--
-- Business context:
--   Customers with high variance purchase erratically (stochastic behavior),
--   while customers with low variance are more consistent.
--   This can inform personalized promotions or demand forecasting.

-- STEPS TO SOLUTION
--
-- 1. For each customer, compute the mean (average) purchase quantity
--    using a window function partitioned by customer_email.
--
-- 2. For each individual purchase, compute its squared deviation
--    from the customer’s mean purchase quantity:
--        (quantity_purchased - mean_quantity)^2
--
-- 3. Preserve these squared deviations for each purchase event.
--
-- 4. Aggregate (average) the squared deviations per customer.
--    This produces the population variance of purchases per customer.
--
-- 5. Join to the customers table to expose customer names in the final output.

WITH reference AS (
    SELECT
        customer_email,
        quantity_purchased,

        -- Compute squared deviation from the customer's mean purchase quantity
        POWER(
            quantity_purchased
            - AVG(quantity_purchased) OVER (
                PARTITION BY customer_email
            ),
            2
        ) AS square_difference
    FROM purchases
)

-- Final aggregation step:
-- Average the squared deviations per customer to obtain variance
SELECT
    customers.name,
    AVG(reference.square_difference) AS purchase_variance
FROM customers
JOIN reference
    ON customers.email = reference.customer_email

-- Group at the customer level to ensure one variance value per customer
GROUP BY customers.email, customers.name;