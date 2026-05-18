-- Query 6: Revenue by Payment Type
-- What: Analyze spending by payment method (EMI, credit card, etc)
-- Why: Understand customer payment preferences and spending patterns
-- Business Value: Optimize payment options, target high-value payment methods

SELECT 
    op.payment_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(SUM(op.payment_value)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(op.payment_value)::NUMERIC, 2) AS avg_payment_value,
    ROUND(AVG(op.payment_installments)::NUMERIC, 2) AS avg_installments,
    ROUND(
        (
            100 * SUM(op.payment_value) 
            / (SELECT SUM(payment_value) FROM order_payments)
        )::NUMERIC, 
        1
    ) AS revenue_percentage
FROM order_payments op
JOIN orders o ON op.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY op.payment_type
ORDER BY total_revenue DESC;