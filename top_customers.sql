-- ================================================
-- Problem: Top 3 Customers by Total Revenue
-- Concepts: GROUP BY, SUM, ORDER BY, LIMIT
-- Author: Amresh
-- ================================================

-- Business Question:
-- Which 3 customers have spent the most money overall?

SELECT
    customer_id,
    SUM(amount) AS total_spending
FROM orders
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 3;

-- Output shows:
-- customer_id | total_spending
-- Top 3 highest spenders ranked from most to least
