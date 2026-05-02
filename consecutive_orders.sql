WITH temp AS (
    SELECT 
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) AS prev_date
    FROM orders
)

SELECT DISTINCT customer_id
FROM temp
WHERE DATEDIFF(order_date, prev_date) = 1;
