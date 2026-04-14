BEGIN TRANSACTION;

.headers off
SELECT '';
.headers on 

-- ============================
-- Method 1: Step-based / CTE-driven
-- Mean calculated once, then reused
-- ============================

WITH 
mean AS (
    SELECT AVG(quantity_purchased)
    FROM purchases
),
deviations AS (
    SELECT
        POWER(
            quantity_purchased - (SELECT * FROM mean),
            2
        ) AS square_deviations
    FROM purchases
)
SELECT AVG(square_deviations) AS CTE_variance
FROM deviations;

-- ============================
-- Method 2: Inline / nested aggregation
-- Mean computed inside scalar subquery
-- ============================

.headers off
SELECT '';
.headers on 

SELECT AVG(sqr_deviations) AS SUB_QUERY_variance
FROM (
    SELECT
        POWER(
            quantity_purchased - (
                SELECT AVG(quantity_purchased)
                FROM purchases
            ),
            2
        ) AS sqr_deviations
    FROM purchases
);

END TRANSACTION;