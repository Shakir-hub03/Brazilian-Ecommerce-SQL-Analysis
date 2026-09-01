-- ============================================================
-- 06_Window_Functions.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================================


-- 1. Customer Running Revenue

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
    ) AS running_revenue_percentage

FROM Customer_Revenue
ORDER BY revenue DESC;


-- 2. Customer Ranking

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

    ROW_NUMBER() OVER(
        ORDER BY revenue DESC
    ) AS row_number_wise,

    RANK() OVER(
        ORDER BY revenue DESC
    ) AS customer_rank,

    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS customer_dense_rank

FROM Customer_Revenue
ORDER BY revenue DESC;


-- 3. LAG 

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

    LAG(revenue) OVER(
        ORDER BY revenue DESC
    ) AS previous_customer_revenue,

    ROUND(
        LAG(revenue) OVER(
            ORDER BY revenue DESC
        ) - revenue,
        2
    ) AS difference_from_previous

FROM Customer_Revenue
ORDER BY revenue DESC;


-- 4. LEAD - Compare With Next Customer

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

    LEAD(revenue) OVER(
        ORDER BY revenue DESC
    ) AS next_customer_revenue,

    ROUND(
        revenue -
        LEAD(revenue) OVER(
            ORDER BY revenue DESC
        ),
        2
    ) AS difference_between_customers

FROM Customer_Revenue
ORDER BY revenue DESC;


-- 5. Customer Quartiles

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


-- 6. Top Product Per Category

WITH Product_Revenue AS
(
    SELECT
        p.product_category_name,
        p.product_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_category_name,
        p.product_id
),

Ranked_Products AS
(
    SELECT
        product_category_name,
        product_id,
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


-- 7. Product Revenue Within Category

WITH Product_Revenue AS
(
    SELECT
        p.product_category_name,
        p.product_id,
        ROUND(COALESCE(SUM(oi.price), 0), 2) AS revenue
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_category_name,
        p.product_id
)

SELECT
    product_category_name,
    product_id,
    revenue,

    DENSE_RANK() OVER(
        PARTITION BY product_category_name
        ORDER BY revenue DESC
    ) AS category_rank,

    ROUND(
        SUM(revenue) OVER(
            PARTITION BY product_category_name
            ORDER BY revenue DESC
        ),
        2
    ) AS running_category_revenue

FROM Product_Revenue
ORDER BY
    product_category_name,
    revenue DESC;


-- 8. Complete Customer Window Report

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

    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS customer_rank,

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

    NTILE(4) OVER(
        ORDER BY revenue DESC
    ) AS quartile,

    LAG(revenue) OVER(
        ORDER BY revenue DESC
    ) AS previous_revenue,

    ROUND(
        LAG(revenue) OVER(
            ORDER BY revenue DESC
        ) - revenue,
        2
    ) AS revenue_difference

FROM Customer_Revenue
ORDER BY revenue DESC;