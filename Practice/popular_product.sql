WITH product_totals AS (
    SELECT
        TRIM(LOWER(customer_email)) AS customer_email,
        product_name,
        SUM(quantity_purchased) AS total_per_product
    FROM purchases
    GROUP BY customer_email, product_name
),
ranked AS (
    SELECT
        customer_email,
        product_name,
        total_per_product,
        ROW_NUMBER() OVER (
            PARTITION BY customer_email
            ORDER BY total_per_product DESC, product_name ASC
        ) AS row_number
    FROM product_totals
)
SELECT
    customer_email,
    product_name,
    total_per_product
FROM ranked
WHERE row_number = 1
ORDER BY customer_email;