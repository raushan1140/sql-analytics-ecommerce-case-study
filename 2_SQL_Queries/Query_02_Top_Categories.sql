-- Query 2: Top 10 Product Categories
-- What: Rank product categories by total revenue
-- Why: Identify best-performing product lines
-- Business Value: Focus marketing/inventory on top performers

SELECT 
    p.product_category_name,
    ct.product_category_name_english,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT oi.product_id) AS unique_products,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price)::NUMERIC, 2) AS revenue,
    ROUND(AVG(oi.price)::NUMERIC, 2) AS avg_price,
    ROUND(AVG(COALESCE(rr.review_score, 0))::NUMERIC, 2) AS avg_rating
FROM products p
LEFT JOIN category_translation ct ON p.product_category_name = ct.product_category_name
JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN order_reviews rr ON oi.order_id = rr.order_id
GROUP BY p.product_category_name, ct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10;