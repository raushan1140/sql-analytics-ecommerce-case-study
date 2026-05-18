-- Query 5: Customer Retention Rate
-- What: % of customers who made repeat purchases
-- Why: Measure customer loyalty and business health
-- Business Value: Understand if marketing builds loyal customer base

WITH customer_purchases AS (
    SELECT 
        c.customer_id,
        COUNT(DISTINCT DATE_TRUNC('month', o.order_purchase_timestamp)) AS purchase_months,
        COUNT(DISTINCT o.order_id) AS total_orders,
        MIN(DATE_TRUNC('month', o.order_purchase_timestamp)) AS first_purchase_month,
        MAX(DATE_TRUNC('month', o.order_purchase_timestamp)) AS last_purchase_month
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_id
)
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders = 1 THEN 1 ELSE 0 END) AS one_time_buyers,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 2
    ) AS retention_rate_pct,
    ROUND(AVG(total_orders)::NUMERIC, 2) AS avg_purchases_per_customer
FROM customer_purchases;