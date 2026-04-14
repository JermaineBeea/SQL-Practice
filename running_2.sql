WITH purchases_with_running AS (
    SELECT *,
           SUM(quantity_purchased) OVER (
               ORDER BY date_purchase, id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS running_sum,
           ROW_NUMBER() OVER (
               ORDER BY date_purchase, id
           ) AS rn
    FROM purchases
)
SELECT *,
       running_sum * rn AS product_totals
FROM purchases_with_running;
``