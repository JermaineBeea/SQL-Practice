SELECT
    id,
    customer_email,
    date_purchase,
    quantity_purchased,
    quantity_purchased
      - LAG(quantity_purchased) OVER (
            PARTITION BY customer_email
            ORDER BY date_purchase, id
        ) AS change_from_last_purchase
FROM purchases;