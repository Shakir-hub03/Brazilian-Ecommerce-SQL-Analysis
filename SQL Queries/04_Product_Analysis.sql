-- ============================================================
-- 04_Product_Analysis.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================================


-- 1. Product Revenue

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        p.product_category_name,
        COUNT(DISTINCT o.order_id) AS orders,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    LEFT JOIN orders o
        ON oi.order_id = o.order_id
    GROUP BY
        p.product_id,
        p.product_category_name
)

SELECT *
FROM Product_Revenue
ORDER BY revenue DESC;


-- 2. Top 10 Products

SELECT
    p.product_id,
    p.product_category_name,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN orders o
    ON oi.order_id = o.order_id
GROUP BY
    p.product_id,
    p.product_category_name
ORDER BY revenue DESC
LIMIT 10;


-- 3. Product AOV

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        p.product_category_name,
        COUNT(DISTINCT o.order_id) AS orders,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    LEFT JOIN orders o
        ON oi.order_id = o.order_id
    GROUP BY
        p.product_id,
        p.product_category_name
)

SELECT
    product_id,
    product_category_name,
    orders,
    revenue,
    ROUND(
        revenue / NULLIF(orders, 0),
        2
    ) AS AOV
FROM Product_Revenue
ORDER BY revenue DESC;


-- 4. Product Segmentation

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        p.product_category_name,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_category_name
)

SELECT
    product_id,
    product_category_name,
    revenue,
    CASE
        WHEN revenue > 50000 THEN 'Star Product'
        WHEN revenue >= 20000 THEN 'Growth Product'
        ELSE 'Weak Product'
    END AS segment
FROM Product_Revenue
ORDER BY revenue DESC;


-- 5. Category Contribution

WITH Category_Revenue AS
(
    SELECT
        p.product_category_name,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_category_name
)

SELECT
    product_category_name,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS revenue_contribution
FROM Category_Revenue
ORDER BY revenue DESC;


-- 6. Product Ranking Within Category

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        p.product_category_name,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_category_name
)

SELECT
    product_id,
    product_category_name,
    revenue,
    DENSE_RANK() OVER(
        PARTITION BY product_category_name
        ORDER BY revenue DESC
    ) AS category_rank
FROM Product_Revenue
ORDER BY
    product_category_name,
    revenue DESC;


-- 7. Top Product in Each Category

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        p.product_category_name,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_category_name
),

Ranked_Products AS
(
    SELECT
        product_id,
        product_category_name,
        revenue,
        DENSE_RANK() OVER(
            PARTITION BY product_category_name
            ORDER BY revenue DESC
        ) AS category_rank
    FROM Product_Revenue
)

SELECT *
FROM Ranked_Products
WHERE category_rank = 1;


-- 8. Product Pareto Analysis

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id
)

SELECT
    product_id,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS revenue_percentage,
    ROUND(
        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ) * 100.0 /
        SUM(revenue) OVER(),
        2
    ) AS running_revenue_percentage
FROM Product_Revenue
ORDER BY revenue DESC;