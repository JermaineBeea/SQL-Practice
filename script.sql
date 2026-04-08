SELECT *, SUM(quantity_purchased) OVER(ORDER BY  quantity_purchased) AS counts
FROM purchases;