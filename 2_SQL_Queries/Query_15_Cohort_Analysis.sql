-- Query 15: Cohort Analysis - First Purchase Month vs Repeat Purchase
-- What: Track customer retention by first purchase month
-- Why: Understand customer lifetime and churn patterns
-- Business Value: Identify when customers leave, improve retention

WITH customer_cohorts AS (
    SELECT 
        c.customer_id,
        DATE_TRUNC('month', MIN(o.order_purchase_timestamp))::DATE AS first_purchase_month,
        COUNT(DISTINCT o.order_id) AS repeat_purchases,
        DATE_TRUNC('month', MAX(o.order_purchase_timestamp))::DATE AS last_purchase_month,
        ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS lifetime_value
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.order_status = 'delivered'
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
SELECT 
    first_purchase_month,
    COUNT(DISTINCT customer_id) AS cohort_size,
    SUM(CASE WHEN repeat_purchases > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN repeat_purchases > 1 THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 2
    ) AS retention_rate_pct,
    ROUND(AVG(lifetime_value)::NUMERIC, 2) AS avg_customer_lifetime_value,
    ROUND(MAX(lifetime_value)::NUMERIC, 2) AS max_customer_value,
    ROUND(MIN(lifetime_value)::NUMERIC, 2) AS min_customer_value
FROM customer_cohorts
WHERE first_purchase_month IS NOT NULL
GROUP BY first_purchase_month
ORDER BY first_purchase_month;