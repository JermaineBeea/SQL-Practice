SELECT *,
       running_sum * rn AS product_totals
FROM (
    SELECT *,
           SUM(quantity_purchased) OVER w AS running_sum,
           ROW_NUMBER() OVER w AS rn
    FROM purchases
    WINDOW w AS (
        ORDER BY date_purchase, id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
);