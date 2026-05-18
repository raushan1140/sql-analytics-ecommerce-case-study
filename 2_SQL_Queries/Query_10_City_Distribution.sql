-- Query 10: City-wise Customer Concentration
-- What: Top cities by customer count and revenue
-- Why: Identify key markets
-- Business Value: Focus logistics/customer service investments

SELECT 
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT c.customer_id) AS unique_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(oi.price + oi.freight_value)::NUMERIC, 2) AS avg_order_value,
    ROUND(
        100.0 * COUNT(DISTINCT c.customer_id) 
        / (SELECT COUNT(DISTINCT customer_id) FROM customers)::NUMERIC, 2
    ) AS customer_concentration_pct
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered' OR o.order_id IS NULL
GROUP BY c.customer_city, c.customer_state
ORDER BY unique_customers DESC
LIMIT 30;