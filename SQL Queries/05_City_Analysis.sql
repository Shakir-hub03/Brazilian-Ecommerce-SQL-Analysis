-- ============================================================
-- 05_City_Analysis.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================================


-- 1. City Revenue

CREATE TEMPORARY TABLE City_Revenue AS
SELECT
    c.customer_city,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_city;


-- 2. Complete City Performance Report

SELECT
    customer_city,
    customers,
    orders,
    revenue,

    ROUND(
        revenue / NULLIF(customers, 0),
        2
    ) AS RPC,

    ROUND(
        revenue / NULLIF(orders, 0),
        2
    ) AS AOV,

    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS city_rank,

    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS revenue_percentage,

    ROUND(
        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ),
        2
    ) AS running_revenue,

    ROUND(
        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ) * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS running_revenue_percentage,

    LAG(revenue) OVER(
        ORDER BY revenue DESC
    ) AS previous_city_revenue,

    ROUND(
        LAG(revenue) OVER(
            ORDER BY revenue DESC
        ) - revenue,
        2
    ) AS revenue_difference,

    CASE
        WHEN revenue > 500000 THEN 'Top City'
        WHEN revenue >= 100000 THEN 'Growth City'
        ELSE 'Low City'
    END AS segment

FROM City_Revenue
ORDER BY revenue DESC;


-- 3. Top 10 Cities

SELECT
    customer_city,
    customers,
    orders,
    revenue
FROM City_Revenue
ORDER BY revenue DESC
LIMIT 10;


-- 4. City Revenue Per Customer Ranking

SELECT
    customer_city,
    customers,
    revenue,

    ROUND(
        revenue / NULLIF(customers, 0),
        2
    ) AS RPC,

    DENSE_RANK() OVER(
        ORDER BY
            revenue / NULLIF(customers, 0) DESC
    ) AS RPC_rank

FROM City_Revenue
ORDER BY RPC DESC;


-- 5. City Revenue Contribution

SELECT
    customer_city,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS city_contribution
FROM City_Revenue
ORDER BY revenue DESC;


-- 6. Top 10 Cities' Contribution

WITH Top_Cities AS
(
    SELECT
        customer_city,
        revenue,
        ROUND(
            revenue * 100.0 /
            SUM(revenue) OVER(),
            2
        ) AS city_contribution
    FROM City_Revenue
    ORDER BY revenue DESC
    LIMIT 10
)

SELECT
    ROUND(SUM(revenue), 2) AS top_10_city_revenue,
    ROUND(SUM(city_contribution), 2) AS top_10_city_contribution
FROM Top_Cities;


-- 7. City Segmentation

SELECT
    customer_city,
    customers,
    orders,
    revenue,

    CASE
        WHEN revenue > 500000 THEN 'Top City'
        WHEN revenue >= 100000 THEN 'Growth City'
        ELSE 'Low City'
    END AS segment

FROM City_Revenue
ORDER BY revenue DESC;


-- 8. High Revenue but Small Customer Base

SELECT
    customer_city,
    customers,
    orders,
    revenue,

    ROUND(
        revenue / NULLIF(customers, 0),
        2
    ) AS RPC

FROM City_Revenue
WHERE customers < 100
AND revenue > 100000
ORDER BY revenue DESC;