-- ============================================================
-- 07_Pareto_Analysis.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================================


-- ============================================================
-- CUSTOMER PARETO ANALYSIS
-- ============================================================


-- 1. Customer Revenue and Running Contribution

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

FROM Customer_Revenue
ORDER BY revenue DESC;


-- 2. Customers Responsible for the First 80% of Revenue

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
),

Customer_Pareto AS
(
    SELECT
        customer_id,
        revenue,

        ROUND(
            SUM(revenue) OVER(
                ORDER BY revenue DESC
            ) * 100.0 /
            SUM(revenue) OVER(),
            2
        ) AS running_revenue_percentage

    FROM Customer_Revenue
)

SELECT *
FROM Customer_Pareto
WHERE running_revenue_percentage <= 80
ORDER BY revenue DESC;


-- 3. Percentage of Customers Generating 80% of Revenue

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
),

Customer_Pareto AS
(
    SELECT
        customer_id,
        revenue,

        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ) * 100.0 /
        SUM(revenue) OVER() AS running_revenue_percentage

    FROM Customer_Revenue
)

SELECT
    COUNT(*) AS customers_for_80_percent_revenue,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Customer_Revenue),
        2
    ) AS percentage_of_customers

FROM Customer_Pareto
WHERE running_revenue_percentage <= 80;


-- ============================================================
-- PRODUCT PARETO ANALYSIS
-- ============================================================


-- 4. Product Revenue Pareto

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


-- 5. Products Responsible for the First 80% of Revenue

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

Product_Pareto AS
(
    SELECT
        product_id,
        product_category_name,
        revenue,

        ROUND(
            SUM(revenue) OVER(
                ORDER BY revenue DESC
            ) * 100.0 /
            SUM(revenue) OVER(),
            2
        ) AS running_revenue_percentage

    FROM Product_Revenue
)

SELECT *
FROM Product_Pareto
WHERE running_revenue_percentage <= 80
ORDER BY revenue DESC;


-- 6. Percentage of Products Generating 80% of Revenue

WITH Product_Revenue AS
(
    SELECT
        p.product_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id
),

Product_Pareto AS
(
    SELECT
        product_id,
        revenue,

        SUM(revenue) OVER(
            ORDER BY revenue DESC
        ) * 100.0 /
        SUM(revenue) OVER() AS running_revenue_percentage

    FROM Product_Revenue
)

SELECT
    COUNT(*) AS products_for_80_percent_revenue,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Product_Revenue),
        2
    ) AS percentage_of_products

FROM Product_Pareto
WHERE running_revenue_percentage <= 80;