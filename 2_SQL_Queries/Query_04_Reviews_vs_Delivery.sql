-- Query 4: Review Score vs Delivery Time
-- What: Compare delivery speed with review ratings
-- Why: Prove impact of delivery speed on customer satisfaction
-- Business Value: Justify logistics investment with data

SELECT 
    CASE 
        WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) <= 0 THEN 'On Time'
        WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) BETWEEN 1 AND 5 THEN '1-5 Days Late'
        WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) BETWEEN 6 AND 14 THEN '6-14 Days Late'
        ELSE 'More than 2 weeks late'
    END AS delivery_performance,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(AVG(COALESCE(rr.review_score, 0))::NUMERIC, 2) AS avg_review_score,
    ROUND(
        100.0 * SUM(CASE WHEN COALESCE(rr.review_score, 0) >= 4 THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 1
    ) AS positive_reviews_pct
FROM orders o
LEFT JOIN order_reviews rr ON o.order_id = rr.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_performance
ORDER BY avg_review_score DESC;