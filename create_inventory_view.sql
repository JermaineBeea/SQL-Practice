CREATE VIEW inventory_view AS
SELECT i.*, COALESCE(SUM(p.quantity_purchased),0) AS total_purchased,
i.quantity_produced - COALESCE(SUM(p.quantity_purchased),0) AS remaining
FROM inventory AS i LEFT JOIN purchases AS p ON i.product_name=p.product_name
GROUP BY i.product_name ORDER BY i.id ASC;