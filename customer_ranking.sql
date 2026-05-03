-- ================================================
-- Problem: Customer Ranking by Total Revenue
-- Concepts: DENSE_RANK, GROUP BY, SUM, Subquery
-- Author: Amresh
-- ================================================

-- Business Question:
-- Rank all customers by total spending.
-- Same rank for ties. No gaps in ranking.

SELECT *,
    DENSE_RANK() OVER(ORDER BY total_spending DESC) AS rnk
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_spending
    FROM orders
    GROUP BY customer_id
) AS temp;

-- Output:
-- customer_id | total_spending | rnk
-- Customers ranked 1, 2, 3... no gaps on ties
