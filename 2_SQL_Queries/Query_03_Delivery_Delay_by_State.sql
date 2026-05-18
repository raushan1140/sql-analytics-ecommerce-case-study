-- Query 3: Average Delivery Delay by State
-- What: Calculate avg days late per state
-- Why: Identify problem regions, improve logistics
-- Business Value: Prioritize logistics improvements in late-shipping regions

SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)))::NUMERIC, 1) AS avg_days_late,
    ROUND(
        100.0 * SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 1
    ) AS late_delivery_percentage,
    MIN(o.order_delivered_customer_date - o.order_estimated_delivery_date) AS best_performance,
    MAX(o.order_delivered_customer_date - o.order_estimated_delivery_date) AS worst_performance
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_days_late DESC;