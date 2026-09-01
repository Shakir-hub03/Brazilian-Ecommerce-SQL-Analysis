# Brazilian E-Commerce Sales Analysis Using SQL

An end-to-end SQL business analysis project using the **Olist Brazilian E-Commerce dataset** to analyze business performance, customer behavior, product performance, geographic performance, and revenue concentration.

---

## 📌 Project Overview

This project analyzes Brazilian e-commerce transaction data using SQL to identify important business trends, performance patterns, and revenue drivers.

The analysis covers:

* Overall business KPIs
* Customer revenue and purchasing behavior
* Product and category performance
* Geographic performance by city
* Customer and product revenue concentration
* Pareto (80/20) analysis

SQL was used for data validation, transformation, analysis, ranking, segmentation, and KPI calculations. Excel was used to present the results through an **Executive Dashboard** and detailed analytical reports.

The project follows a business-oriented approach:

**Raw Data → SQL Analysis → KPIs → Business Findings → Recommendations**

---

## 🎯 Business Objective

The main objective is to understand what drives e-commerce revenue and identify areas that may require further business investigation.

The project addresses questions such as:

* How much revenue and how many orders does the business generate?
* Who are the highest-value customers?
* How is customer revenue distributed?
* Which products and categories generate the most revenue?
* Which cities contribute the most revenue?
* How concentrated is revenue among customers and products?
* Which products, customer groups, and geographic markets may require further investigation?

---

## 📊 Dataset

The project uses the **Olist Brazilian E-Commerce dataset**, containing information about customers, orders, products, order items, and payments.

### Main Tables

| Table          | Records | Purpose                                                |
| -------------- | ------: | ------------------------------------------------------ |
| Customers      |  99,441 | Customer and location information                      |
| Orders         |  99,441 | Order and order-status information                     |
| Order Items    | 112,647 | Products, quantities and prices associated with orders |
| Order Payments | 103,886 | Payment information                                    |
| Products       |  32,340 | Product information and categories                     |

### Revenue Definition

For this project, **revenue is calculated using product price only**.

> Freight charges are excluded from the revenue calculation.

---

## 🛠️ Tools Used

* **SQL** — Data validation, joins, aggregations, subqueries, CTEs, CASE statements, window functions, ranking, segmentation and Pareto analysis
* **Microsoft Excel** — Executive dashboard, analytical reports and data presentation
* **GitHub** — Project documentation and portfolio presentation

---

## 🗂️ Database Structure

The analysis uses the following main relationships:

```text
Customers
    │
    │ customer_id
    ↓
Orders
    │
    │ order_id
    ↓
Order Items ───────── Products
    │
    │ order_id
    ↓
Order Payments
```

These relationships allow customer, order, product, payment and geographic information to be combined for business analysis.

---

# 🔎 Analysis Performed

## 1. Data Quality Analysis

The project began by validating the available data and checking:

* Table record counts
* Unique identifiers
* NULL values
* Data relationships
* Order statuses
* Data consistency

---

## 2. Business KPI Analysis

Overall business performance was analyzed using:

* Total Revenue
* Total Orders
* Unique Customers
* Average Order Value (AOV)
* Revenue per Customer
* Monthly Revenue

### Overall Results

| KPI              |       Result |
| ---------------- | -----------: |
| Total Revenue    | **R$13.59M** |
| Total Orders     |   **99,441** |
| Unique Customers |   **96,096** |
| AOV              | **R$137.75** |

---

## 3. Customer Analysis

Customer analysis examined:

* Customer-level revenue
* Orders per customer
* Average Order Value
* Revenue contribution
* Customer ranking
* Running revenue
* Cumulative revenue percentage
* Customer quartiles
* Previous-customer revenue comparison
* Customer segmentation
* Revenue concentration

---

## 4. Product Analysis

Product analysis examined:

* Product-level revenue
* Orders per product
* Product AOV
* Overall product ranking
* Revenue contribution
* Running revenue
* Category-wise ranking
* Category revenue
* Product contribution within category
* Difference from previous-ranked product
* Product segmentation

Products were categorized into:

* **Star Products**
* **Growth Products**
* **Weak Products**

---

## 5. City Analysis

Geographic analysis examined:

* Customers by city
* Orders by city
* Revenue by city
* Revenue per Customer (RPC)
* AOV by city
* City ranking
* Revenue contribution
* Running revenue
* City segmentation
* City order contribution

---

## 6. Pareto Analysis

Pareto analysis was used to understand how concentrated revenue is among customers and products.

The analysis calculated:

* Revenue contribution
* Running revenue
* Running revenue percentage
* Proportion of customers/products required to generate 80% of revenue

---

# 💡 Key Business Findings

## Overall Business Performance

* The business generated approximately **R$13.59 million** in product-price revenue.
* The dataset contains **99,441 orders** and **96,096 unique customers**.
* Average Order Value was approximately **R$137.75**.
* **São Paulo** was the highest revenue-generating city, generating approximately **R$1.91 million**.
* `beleza_saude` was the highest-revenue product category, generating approximately **R$1.26 million**.

---

## 👥 Customer Findings

* Customer revenue is distributed across a broad customer base, although customer value varies considerably.
* **44,499 customers, representing approximately 44.75% of customers, account for 80% of total revenue.**
* This indicates that the business is not dependent on an extremely small number of customers.
* Higher-ranked customers contribute more significantly to revenue, creating an opportunity for targeted customer retention and value-building strategies.

---

## 📦 Product Findings

* Product revenue is substantially concentrated among a smaller proportion of products.
* **8,408 products, representing approximately 26% of the product base, account for 80% of revenue.**
* Product segmentation identified:

  * **3 Star Products**
  * **26 Growth Products**
  * **32,312 Weak Products**
* The results indicate a large long-tail of lower-revenue products.
* `beleza_saude` generated approximately **R$1.26M**, followed by `relogios_presentes` at approximately **R$1.21M**.

---

## 🌎 Geographic Findings

* **São Paulo** ranked first in city-level revenue at approximately **R$1.91M**.
* **Rio de Janeiro** ranked second at approximately **R$0.99M**.
* Other major revenue-generating cities included Belo Horizonte, Brasília, Curitiba and Porto Alegre.
* Revenue and Revenue per Customer (RPC) provide different perspectives on city performance.
* A city with high total revenue may achieve that result through a large customer base, while a smaller city may have stronger revenue per customer.

---

# 📈 Revenue Concentration

One of the strongest findings from the project comes from comparing customer and product Pareto analysis.

| Analysis  | Share Generating 80% of Revenue |
| --------- | ------------------------------: |
| Customers |                      **44.75%** |
| Products  |                      **26.00%** |

### Key Insight

> **Revenue is more concentrated at the product level than at the customer level.**

Approximately **26% of products generate 80% of revenue**, while approximately **44.75% of customers generate 80% of revenue**.

This suggests that the business is more dependent on a relatively smaller group of products than on a very small group of customers.

---

# 💼 Business Recommendations

### 1. Monitor high-performing products

High-revenue products should be monitored for availability and continued performance because disruptions affecting these products could have a meaningful impact on revenue.

### 2. Review consistently weak products

Weak-performing products should be evaluated using factors such as demand, pricing, inventory costs, category importance and strategic relevance before making assortment decisions.

### 3. Strengthen customer retention

Higher-value and repeat customers can be analyzed further to identify opportunities to increase purchase frequency and customer lifetime value.

### 4. Investigate high-RPC cities

Smaller cities with relatively high revenue per customer may represent opportunities for targeted customer acquisition and market expansion.

### 5. Monitor product revenue concentration

Because a relatively small proportion of products generates a large share of revenue, product performance should be monitored regularly to identify potential concentration risks.

### 6. Evaluate cities using multiple metrics

Geographic decisions should consider total revenue, customer count, orders, AOV and RPC rather than relying on total revenue alone.

---

# 📁 Project Structure

```text
Brazilian-Ecommerce-SQL-Analysis/
│
├── SQL Queries/
│   ├── 01_Data_Quality.SQL
│   ├── 02_KPI_Analysis.sql
│   ├── 03_Customer_Analysis.sql
│   ├── 04_Product_Analysis.sql
│   ├── 05_City_Analysis.sql
│   ├── 06_Window_Functions.sql
│   └── 07_Pareto_Analysis.sql
│
├── Reports/
│   ├── 01_OLIST E-COMMERCE BUSINESS DASHBOARD.xlsx
│   ├── 02_Customer Report.xlsx
│   ├── 03_Products Report.xlsx
│   ├── 04_City Report.xlsx
│   └── 05_Pareto Report.xlsx
│
└── Readme.md
```

---

# 📊 Reports

The project includes an executive dashboard and four detailed analytical reports.

### Executive Dashboard

Provides a high-level view of:

* Revenue
* Orders
* Customers
* AOV
* Top city
* Monthly revenue
* Top cities
* Top product categories
* Customer segments
* Order status

### Customer Report

Contains detailed customer-level analysis, including:

* Customer revenue
* Customer ranking
* AOV
* Revenue contribution
* Customer segmentation
* Running revenue
* Quartile analysis
* Pareto analysis

### Product Report

Contains:

* Product performance
* Product ranking
* Category performance
* Category-wise ranking
* Product segmentation
* Revenue contribution
* Product-level Pareto analysis

### City Report

Contains:

* Customer distribution
* Orders
* Revenue
* RPC
* AOV
* City ranking
* Revenue contribution
* City segmentation

### Pareto Report

Contains:

* Customer revenue concentration
* Product revenue concentration
* Running revenue analysis
* 80/20 analysis

---

# 🧠 Skills Demonstrated

## Technical Skills

* SQL
* Data validation
* Data cleaning
* INNER JOIN
* LEFT JOIN
* GROUP BY
* Aggregate functions
* CASE statements
* Subqueries
* CTEs
* Window functions
* ROW_NUMBER
* RANK
* Running totals
* Revenue calculations
* Customer segmentation
* Product segmentation
* Pareto analysis

## Business Analysis Skills

* Translating business questions into SQL analysis
* KPI development
* Customer analysis
* Product performance analysis
* Geographic analysis
* Revenue concentration analysis
* Identifying business insights
* Developing data-driven recommendations
* Presenting findings through dashboards and reports

---

# 📌 Conclusion

This project demonstrates an end-to-end approach to analyzing e-commerce data using SQL and Excel.

The analysis moves beyond simply querying data by connecting SQL results to business questions, identifying revenue patterns, evaluating customers, products and cities, and translating findings into actionable areas for further investigation.
