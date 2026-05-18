-- Query 14: Month-over-Month Growth Rate
-- What: Calculate MoM growth in orders and revenue
-- Why: Track business momentum
-- Business Value: Show investors growth trajectory

WITH monthly_metrics AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS month,
        COUNT(DISTINCT o.order_id) AS orders,
        COUNT(DISTINCT o.customer_id) AS customers,
        ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
)
SELECT 
    month,
    orders,
    LAG(orders) OVER (ORDER BY month) AS prev_month_orders,
    ROUND(
        100.0 * (orders - LAG(orders) OVER (ORDER BY month)) 
        / LAG(orders) OVER (ORDER BY month)::NUMERIC, 2
    ) AS orders_growth_pct,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) 
        / LAG(revenue) OVER (ORDER BY month)::NUMERIC, 2
    ) AS revenue_growth_pct,
    customers
FROM monthly_metrics
ORDER BY month;