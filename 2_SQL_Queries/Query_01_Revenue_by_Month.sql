-- Query 1: Revenue by Month
-- What: Calculate total revenue (price + freight) by order month
-- Why: Understand sales trends, seasonality, and business growth
-- Business Value: Identify peak selling seasons, plan inventory

SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(oi.price + oi.freight_value)::NUMERIC, 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY order_month ASC;