SELECT
    id,
    date_purchase,
    customer_email,
    product_name,
    quantity_purchased,
    SUM(quantity_purchased) OVER (
        ORDER BY date_purchase, id
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS running_total
FROM purchases
ORDER BY date_purchase, id;
