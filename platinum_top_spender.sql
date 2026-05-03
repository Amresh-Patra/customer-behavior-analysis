-- ================================================
-- Problem: Platinum Top Spender Per City
-- Concepts: CTEs, ROW_NUMBER, PARTITION BY,
--           GROUP BY, SUM, CASE WHEN logic
-- Author: Amresh
-- ================================================

-- Business Question:
-- Find customers who are both:
-- 1. The highest spender in their city
-- 2. Platinum tier (total spending >= 1000)

WITH customer_totals AS (
    SELECT
        customer_id,
        city,
        SUM(amount) AS total_spending
    FROM orders
    GROUP BY customer_id, city
),
ranked_customers AS (
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY city
            ORDER BY total_spending DESC
        ) AS rnk
    FROM customer_totals
)
SELECT *
FROM ranked_customers
WHERE rnk = 1
AND total_spending >= 1000;

-- Why two CTEs?
-- CTE 1 aggregates raw data cleanly
-- CTE 2 ranks the aggregated result
-- Final SELECT filters the exact business condition
-- Much cleaner than nested subqueries

-- Output:
-- city | customer_id | total_spending | rnk
-- Only cities where top spender is also Platinum
