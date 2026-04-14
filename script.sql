SELECT *,  (
    SUM(quantity_purchased) OVER (
        ORDER BY date_purchase, ID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) * ROW_NUMBER() OVER (
        ORDER BY date_purchase, ID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
) AS product_totals
FROM purchases
;