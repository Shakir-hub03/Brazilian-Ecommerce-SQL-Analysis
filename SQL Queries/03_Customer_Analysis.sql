-- ============================================================
-- 03_Customer_Analysis.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================================


-- 1. Customer Revenue

WITH Customer_Revenue AS
(
    SELECT
        c.customer_id,
        c.customer_city,
        COUNT(DISTINCT o.order_id) AS orders,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_city
)

SELECT *
FROM Customer_Revenue
ORDER BY revenue DESC;


-- 2. Top 10 Customers by Revenue

SELECT
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY revenue DESC
LIMIT 10;


-- 3. Customer AOV

SELECT
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue,
    ROUND(
        COALESCE(SUM(oi.price), 0) /
        NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS AOV
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY revenue DESC;


-- 4. Customer Segmentation

WITH Customer_Revenue AS
(
    SELECT
        c.customer_id,
        COUNT(DISTINCT o.order_id) AS orders,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)

SELECT
    customer_id,
    orders,
    revenue,
    CASE
        WHEN revenue > 10000 THEN 'High Value Customer'
        WHEN revenue >= 5000 THEN 'Medium Value Customer'
        ELSE 'Low Value Customer'
    END AS segment
FROM Customer_Revenue
ORDER BY revenue DESC;


-- 5. Customer Revenue Contribution

WITH Customer_Revenue AS
(
    SELECT
        c.customer_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)

SELECT
    customer_id,
    revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER(),
        2
    ) AS revenue_percentage
FROM Customer_Revenue
ORDER BY revenue DESC;


-- 6. Customer Ranking

WITH Customer_Revenue AS
(
    SELECT
        c.customer_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)

SELECT
    customer_id,
    revenue,
    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS customer_rank
FROM Customer_Revenue
ORDER BY revenue DESC;


-- 7. Customer Quartiles

WITH Customer_Revenue AS
(
    SELECT
        c.customer_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)

SELECT
    customer_id,
    revenue,
    NTILE(4) OVER(
        ORDER BY revenue DESC
    ) AS quartile
FROM Customer_Revenue
ORDER BY revenue DESC;