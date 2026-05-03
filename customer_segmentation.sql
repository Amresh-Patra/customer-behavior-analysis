-- ================================================
-- Problem: Customer Segmentation by Total Spending
-- Concepts: CASE WHEN, GROUP BY, SUM
-- Author: Amresh
-- ================================================

-- Business Question:
-- Segment customers into Platinum, Gold, Silver, Bronze
-- based on their total spending.

SELECT
    customer_id,
    SUM(amount) AS total_spending,
    CASE
        WHEN SUM(amount) >= 1000 THEN 'Platinum'
        WHEN SUM(amount) >= 600  THEN 'Gold'
        WHEN SUM(amount) >= 300  THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_segment
FROM orders
GROUP BY customer_id;

-- Why descending conditions?
-- CASE checks top to bottom — first match wins.
-- So >= 1000 catches Platinum first,
-- then >= 600 catches only 600-999 (Gold),
-- then >= 300 catches only 300-599 (Silver),
-- ELSE catches everything below 300 (Bronze).

-- Output:
-- customer_id | total_spending | customer_segment
-- Every customer gets exactly one segment label
