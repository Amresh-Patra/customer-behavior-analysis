-- ================================================
-- Problem: Top Customer Per City by Total Revenue
-- Concepts: ROW_NUMBER, PARTITION BY, GROUP BY,
--           SUM, Subquery Layering
-- Author: Amresh
-- ================================================

-- Business Question:
-- For each city, which customer has spent the most money?
-- Show one customer per city only.

SELECT
    customer_id,
    city,
    total_spending
FROM (
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY city
            ORDER BY total_spending DESC
        ) AS rnk
    FROM (
        SELECT
            customer_id,
            city,
            SUM(amount) AS total_spending
        FROM orders
        GROUP BY customer_id, city
    ) AS temp2
) AS temp
WHERE rnk = 1;

-- Why ROW_NUMBER and not RANK or DENSE_RANK?
-- ROW_NUMBER gives exactly one rank 1 per city.
-- RANK or DENSE_RANK could give multiple rank 1s on ties.
-- For "top 1 per group" problems always use ROW_NUMBER.

-- Output:
-- city        | customer_id | total_spending
-- Each city appears exactly once with its top spender
