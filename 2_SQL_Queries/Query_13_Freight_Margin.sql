-- Query 13: Freight Cost as % of Order Value
-- What: Analyze shipping costs as % of order total
-- Why: Understand impact on margins
-- Business Value: Negotiate better rates, adjust prices

SELECT 
    CASE 
        WHEN c.customer_state IN ('SP', 'RJ', 'MG') THEN 'Southeast'
        WHEN c.customer_state IN ('BA', 'PE', 'CE') THEN 'Northeast'
        WHEN c.customer_state IN ('RS', 'PR', 'SC') THEN 'South'
        ELSE 'North/Central'
    END AS region,
    COUNT(*) AS items_ordered,
    ROUND(SUM(oi.price)::NUMERIC, 2) AS product_value,
    ROUND(SUM(oi.freight_value)::NUMERIC, 2) AS freight_cost,
    ROUND(AVG(oi.freight_value)::NUMERIC, 2) AS avg_freight,
    ROUND(
        (
            100 * SUM(oi.freight_value)
            / SUM(oi.price + oi.freight_value)
        )::NUMERIC,
        2
    ) AS freight_as_pct_of_order
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY region
ORDER BY freight_as_pct_of_order DESC;