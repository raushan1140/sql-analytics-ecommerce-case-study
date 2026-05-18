-- Query 11: Average Order Value by State
-- What: Compare avg order value across states
-- Why: Understand regional spending power
-- Business Value: Tailor pricing/products by region

SELECT 
    c.customer_state,
    COUNT(DISTINCT c.customer_id) AS unique_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(oi.price)::NUMERIC, 2) AS avg_product_price,
    ROUND(AVG(oi.freight_value)::NUMERIC, 2) AS avg_freight,
    ROUND(AVG(oi.price + oi.freight_value)::NUMERIC, 2) AS avg_order_value,
    ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(COALESCE(rr.review_score, 0))::NUMERIC, 2) AS avg_satisfaction
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.order_status = 'delivered'
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN order_reviews rr ON o.order_id = rr.order_id
GROUP BY c.customer_state
ORDER BY avg_order_value DESC;