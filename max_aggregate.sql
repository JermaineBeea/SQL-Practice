BEGIN TRANSACTION;

-- =========================================================
-- Method 1:
-- This approach constructs an intermediate relation that
-- aggregates total quantities purchased per customer,
-- grouped by customer email. The set of customer emails
-- corresponding to the maximum aggregate purchase quantity
-- is then identified. Finally, these email identifiers are
-- joined with the customers relation in order to retrieve
-- the associated customer names.
-- =========================================================

.headers off
SELECT 'METHOD 1 RETURNED';

WITH grouped AS (
    SELECT
        customer_email,
        SUM(quantity_purchased) AS totals
    FROM purchases
    GROUP BY customer_email
)
SELECT LOWER(c.name)
FROM customers AS c
INNER JOIN grouped AS g
    ON c.email = g.customer_email
WHERE g.totals = (
    SELECT MAX(totals) FROM grouped
);

-- =========================================================
-- Method 2:
-- This approach first joins the purchases and customers
-- relations using customer email as a key. The joined
-- relation is then aggregated by customer name to compute
-- total quantities purchased per customer. Customer names
-- whose aggregated totals equal the maximum aggregate value
-- are subsequently selected.
-- =========================================================

.headers off
SELECT 'METHOD 2 RETURNED';

WITH joined AS (
    SELECT
        c.name,
        SUM(p.quantity_purchased) AS totals
    FROM purchases AS p
    INNER JOIN customers AS c
        ON p.customer_email = c.email
    GROUP BY c.name
)
SELECT LOWER(name)
FROM joined
WHERE totals = (
    SELECT MAX(totals) FROM joined
);

END TRANSACTION;
``