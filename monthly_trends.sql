-- ================================================
-- Problem: Monthly Revenue Trends & Analysis
-- Concepts: DATE_FORMAT, MONTH, YEAR, GROUP BY,
--           CTEs, AVG, Cross Join
-- Author: Amresh
-- ================================================

-- -----------------------------------------------
-- Q1: Total revenue per year
-- -----------------------------------------------
SELECT
    YEAR(order_date)  AS year_,
    SUM(amount)       AS total_revenue
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year_;

-- -----------------------------------------------
-- Q2: Total revenue per month for 2023 only
-- -----------------------------------------------
SELECT
    MONTH(order_date) AS month_,
    SUM(amount)       AS total_revenue
FROM orders
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date)
ORDER BY month_;

-- -----------------------------------------------
-- Q3: Monthly revenue + order count
--     Display in 'March 2024' format
-- -----------------------------------------------
SELECT
    DATE_FORMAT(order_date, '%M %Y') AS month_year,
    SUM(amount)                      AS total_revenue,
    COUNT(order_id)                  AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%M %Y')
ORDER BY MIN(order_date);

-- -----------------------------------------------
-- Q4: Months where revenue was above 10,000
-- -----------------------------------------------
SELECT
    DATE_FORMAT(order_date, '%M %Y') AS month_year,
    SUM(amount)                      AS total_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%M %Y')
HAVING SUM(amount) > 10000
ORDER BY MIN(order_date);

-- -----------------------------------------------
-- Q5: Months where revenue was above average
--     monthly revenue (CTE approach)
-- -----------------------------------------------
WITH monthly_data AS (
    SELECT
        MONTH(order_date) AS month_,
        SUM(amount)       AS monthly_revenue
    FROM orders
    GROUP BY MONTH(order_date)
),
avg_data AS (
    SELECT AVG(monthly_revenue) AS avg_revenue
    FROM monthly_data
)
SELECT
    month_,
    monthly_revenue
FROM monthly_data, avg_data
WHERE monthly_revenue > avg_revenue
ORDER BY month_;

-- Why no GROUP BY in avg_data CTE?
-- AVG without GROUP BY collapses entire table
-- into one single number — exactly what we need
-- to compare each month against overall average.
