-- Query 8: Return/Cancellation Rate by Category
-- What: % cancelled/returned orders by product category
-- Why: Identify problematic product categories
-- Business Value: Improve QC, review supplier relationships

SELECT 
    COALESCE(ct.product_category_name_english, p.product_category_name) AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE WHEN o.order_status IN ('canceled', 'unavailable') THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        100.0 * SUM(CASE WHEN o.order_status IN ('canceled', 'unavailable') THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 2
    ) AS cancellation_rate_pct,
    ROUND(AVG(COALESCE(rr.review_score, 0))::NUMERIC, 2) AS avg_review_score,
    COUNT(DISTINCT CASE WHEN rr.review_comment_message LIKE '%broke%' 
                         OR rr.review_comment_message LIKE '%defect%'
                         OR rr.review_comment_message LIKE '%problem%' THEN rr.order_id END) AS quality_complaints
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct ON p.product_category_name = ct.product_category_name
LEFT JOIN order_reviews rr ON o.order_id = rr.order_id
GROUP BY COALESCE(ct.product_category_name_english, p.product_category_name)
ORDER BY cancellation_rate_pct DESC;