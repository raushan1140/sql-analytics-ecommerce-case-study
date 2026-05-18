-- Query 9: Peak Order Hours/Days
-- What: Identify peak ordering times
-- Why: Optimize server capacity, staffing, promotions
-- Business Value: Run campaigns during peak times, improve UX during high traffic

SELECT 
    TO_CHAR(o.order_purchase_timestamp, 'Day') AS day_of_week,
    EXTRACT(DOW FROM o.order_purchase_timestamp)::INT AS day_number,
    EXTRACT(HOUR FROM o.order_purchase_timestamp)::INT AS hour_of_day,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(AVG(oi.price + oi.freight_value)::NUMERIC, 2) AS avg_order_value,
    ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY day_of_week, day_number, hour_of_day
ORDER BY orders DESC
LIMIT 20;