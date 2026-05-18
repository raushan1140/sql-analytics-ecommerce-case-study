-- Query 7: Seller Performance Ranking
-- What: Rank sellers by revenue, ratings, fulfillment
-- Why: Identify top performers and problem sellers
-- Business Value: Reward top sellers, provide support to struggling ones

SELECT 
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS orders_fulfilled,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(oi.price)::NUMERIC, 2) AS avg_price,
    ROUND(AVG(COALESCE(rr.review_score, 0))::NUMERIC, 2) AS avg_rating,
    ROUND(
        100.0 * SUM(CASE WHEN COALESCE(rr.review_score, 0) >= 4 THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 1
    ) AS positive_review_pct,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC) AS revenue_rank
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
LEFT JOIN order_reviews rr ON oi.order_id = rr.order_id
GROUP BY s.seller_id, s.seller_state
ORDER BY total_revenue DESC
LIMIT 20;