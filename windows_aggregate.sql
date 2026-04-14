BEGIN TRANSACTION;

-- =========================================================
-- Method 1:
-- 1. Define a CTE that computes window-based aggregates:
--    - running sum of quantity_purchased
--    - running row number
-- 2. Reuse these computed fields to calculate
--    a derived running aggregate expression.
-- =========================================================

.headers off
SELECT 'METHOD 1 RETURNED';
.headers on
.mode column

WITH reference AS (
    SELECT
        date_purchase,
        quantity_purchased,
        SUM(quantity_purchased) OVER w AS sum_aggregate,
        ROW_NUMBER() OVER w AS row_number
    FROM purchases
    WINDOW w AS (
        ORDER BY date_purchase, id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
)
SELECT
    date_purchase,
    sum_aggregate * row_number AS running_aggregate
FROM reference;

-- =========================================================
-- Method 2:
-- 1. Compute the running sum and running row number directly
--    inside the SELECT clause using window functions.
-- 2. Multiply the two window expressions inline,
--    without an intermediate CTE.
-- =========================================================

.headers off
SELECT 'METHOD 2 RETURNED';
.headers on
.mode column

SELECT
    date_purchase,
    SUM(quantity_purchased) OVER w
    * ROW_NUMBER() OVER w AS running_aggregate
FROM purchases
WINDOW w AS (
    ORDER BY date_purchase, id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
);

END TRANSACTION;
``