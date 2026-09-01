-- ============================================
-- 02_KPI_Analysis.sql
-- E-COMMERCE SQL ANALYSIS PROJECT
-- ============================================


-- ============================================================
-- KPI 1: TOTAL REVENUE
-- Revenue = Sum of product prices from order_items
-- ============================================================ 
SELECT
    ROUND(COALESCE(SUM(price), 0), 2) AS Total_Revenue
FROM order_items;


-- ============================================================
-- KPI 2: TOTAL ORDERS
-- Count distinct orders
-- ============================================================ 

SELECT
    COUNT(DISTINCT order_id) AS Total_Orders
FROM orders;


-- ============================================================
-- KPI 3: TOTAL CUSTOMERS
-- Count distinct customers
-- ============================================================ 

SELECT
    COUNT(DISTINCT customer_id) AS Total_Customers
FROM customers;


-- ============================================================
-- KPI 4: AVERAGE ORDER VALUE (AOV) 
-- AOV = Total Revenue / Total Orders
-- ============================================================

SELECT
    ROUND(
        (SELECT COALESCE(SUM(price), 0)
         FROM order_items)
        /
        (SELECT COUNT(DISTINCT order_id)
         FROM orders),
        2
    ) AS AOV;


-- ============================================================
-- KPI 5: REVENUE PER CUSTOMER 
-- Revenue Per Customer = Total Revenue / Total Customers
-- ============================================================

SELECT
    ROUND(
        (SELECT COALESCE(SUM(price), 0)
         FROM order_items)
        /
        (SELECT COUNT(DISTINCT customer_id)
         FROM customers),
        2
    ) AS Revenue_Per_Customer;


-- ============================================================
-- KPI 6: PURCHASE FREQUENCY 
-- Purchase Frequency = Total Orders / Total Customers 
-- Shows the average number of orders per customer.
-- ============================================================

SELECT
    ROUND(
        (SELECT COUNT(DISTINCT order_id)
         FROM orders)
        /
        (SELECT COUNT(DISTINCT customer_id)
         FROM customers),
        2
    ) AS Purchase_Frequency;


-- ============================================================
-- KPI 7: ALL EXECUTIVE KPIs IN ONE RESULT 
-- This query produces a single KPI summary table.
-- ============================================================

SELECT

-- Total Revenue 
    ROUND(
        (SELECT COALESCE(SUM(price), 0)
         FROM order_items),
        2
    ) AS Total_Revenue,

-- Total Orders 
    (
        SELECT COUNT(DISTINCT order_id)
        FROM orders
    ) AS Total_Orders,

-- Total Customers 
    (
        SELECT COUNT(DISTINCT customer_id)
        FROM customers
    ) AS Total_Customers,

-- Average Order Value 
    ROUND(
        (SELECT COALESCE(SUM(price), 0)
         FROM order_items)
        /
        (SELECT COUNT(DISTINCT order_id)
         FROM orders),
        2
    ) AS AOV,

-- Revenue Per Customer
    ROUND(
        (SELECT COALESCE(SUM(price), 0)
         FROM order_items)
        /
        (SELECT COUNT(DISTINCT customer_id)
         FROM customers),
        2
    ) AS Revenue_Per_Customer,

-- Purchase Frequency 
    ROUND(
        (SELECT COUNT(DISTINCT order_id)
         FROM orders)
        /
        (SELECT COUNT(DISTINCT customer_id)
         FROM customers),
        2
    ) AS Purchase_Frequency;