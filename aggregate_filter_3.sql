SELECT product_name
FROM (
    SELECT
        product_name,
        COUNT(*) AS cnt,
        MAX(COUNT(*)) OVER () AS max_cnt
    FROM purchases
    GROUP BY product_name
)
WHERE cnt = max_cnt;