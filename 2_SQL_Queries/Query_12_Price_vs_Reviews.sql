-- Query 12: Product Price vs Review Score
-- What: Compare product price with customer satisfaction
-- Why: Understand pricing strategy impact
-- Business Value: Optimize pricing tiers

SELECT 
    CASE 
        WHEN oi.price < 50 THEN 'Under $50'
        WHEN oi.price BETWEEN 50 AND 150 THEN '$50-150'
        WHEN oi.price BETWEEN 150 AND 500 THEN '$150-500'
        WHEN oi.price BETWEEN 500 AND 1000 THEN '$500-1000'
        ELSE 'Above $1000'
    END AS price_range,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    COUNT(*) AS items_sold,
    ROUND(AVG(oi.price)::NUMERIC, 2) AS avg_price,
    ROUND(AVG(COALESCE(rr.review_score, 0))::NUMERIC, 2) AS avg_review_score,
    ROUND(
        100.0 * SUM(CASE WHEN COALESCE(rr.review_score, 0) >= 4 THEN 1 ELSE 0 END) 
        / COUNT(*)::NUMERIC, 1
    ) AS positive_review_pct
FROM order_items oi
LEFT JOIN order_reviews rr ON oi.order_id = rr.order_id
GROUP BY price_range
ORDER BY avg_price ASC;