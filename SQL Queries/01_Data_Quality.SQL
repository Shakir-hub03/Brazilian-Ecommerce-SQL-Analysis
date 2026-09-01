-- ============================================
-- 01_DATA_QUALITY.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================


-- ============================================
-- 1. TABLE ROW COUNTS
-- ============================================

SELECT COUNT(*) AS Total_Customers
FROM customers;


SELECT COUNT(*) AS Total_Orders
FROM orders;


SELECT COUNT(*) AS Total_Order_Items
FROM order_items;


SELECT COUNT(*) AS Total_Order_Payments
FROM order_payments;


SELECT COUNT(*) AS Total_Products
FROM products;



-- ============================================
-- 2. CHECK UNIQUE / DUPLICATE IDs
-- ============================================

-- Customers
SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM customers;


-- Orders
SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT order_id) AS Unique_Orders
FROM orders;


-- Products
SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT product_id) AS Unique_Products
FROM products;


-- Order Items
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT order_id) AS Unique_Orders_In_Items,
    COUNT(DISTINCT product_id) AS Unique_Products_In_Items
FROM order_items;



-- ============================================
-- 3. CHECK NULL VALUES IN KEY COLUMNS
-- ============================================

-- Customer ID
SELECT *
FROM customers
WHERE customer_id IS NULL;


-- Order ID
SELECT *
FROM orders
WHERE order_id IS NULL;


-- Product ID
SELECT *
FROM products
WHERE product_id IS NULL;


-- Order Item Order ID
SELECT *
FROM order_items
WHERE order_id IS NULL;


-- Order Item Product ID
SELECT *
FROM order_items
WHERE product_id IS NULL;



-- ============================================
-- 4. ORDER STATUS DISTRIBUTION
-- ============================================

SELECT
    order_status,
    COUNT(*) AS Orders
FROM orders
GROUP BY order_status
ORDER BY Orders DESC;



-- ============================================
-- 5. CHECK DATA DATE RANGE
-- ============================================

SELECT
    MIN(order_purchase_timestamp) AS First_Order,
    MAX(order_purchase_timestamp) AS Last_Order
FROM orders;



-- ============================================
-- 6. CHECK MISSING CUSTOMER RELATIONSHIPS
-- Orders without matching Customers
-- ============================================

SELECT COUNT(*) AS Orders_Without_Customers
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;



-- ============================================
-- 7. CHECK MISSING PRODUCT RELATIONSHIPS
-- Order Items without matching Products
-- ============================================

SELECT COUNT(*) AS Order_Items_Without_Products
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;



-- ============================================
-- 8. CHECK MISSING ORDER RELATIONSHIPS
-- Order Items without matching Orders
-- ============================================

SELECT COUNT(*) AS Order_Items_Without_Orders
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;



-- ============================================
-- 9. CUSTOMER ID VS UNIQUE CUSTOMER ID
-- ============================================

SELECT
    COUNT(DISTINCT customer_id) AS Unique_Customer_IDs,
    COUNT(DISTINCT customer_unique_id) AS Unique_Real_Customers
FROM customers;