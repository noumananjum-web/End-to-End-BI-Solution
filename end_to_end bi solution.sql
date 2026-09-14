CREATE DATABASE olist_bi;
USE olist_bi;

SHOW TABLES;

DESCRIBE fact_sales;

DESCRIBE dim_customer;

DESCRIBE dim_product;

DESCRIBE dim_date;

-- Total Revenue--
SELECT SUM(sales_amount) AS Total_revenue
FROM fact_sales;

-- Monthly revenue trend
SELECT `year`,`month`, SUM(sales_amount) AS Monthly_revenue
FROM fact_sales
GROUP BY `year`,`month`;

-- Top 10 products by revenue
SELECT product_id,product_category_name,SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY product_id,product_category_name
ORDER BY SUM(sales_amount) DESC LIMIT 10 ;

-- Revenue by Product Category--
SELECT product_category_name,SUM(sales_amount) AS Total_Revenue
FROM fact_sales
GROUP BY product_category_name
order by SUM(sales_amount) desc;

--  Total Orders--
SELECT COUNT(DISTINCT order_id) AS total_orders
from fact_sales;

-- Average order value--
SELECT AVG(sales_amount)/COUNT(DISTINCT order_id) AS Average_order_value
from fact_sales;

--  Total Freight Cost--
SELECT SUM(freight_value) AS total_freight_cost
from fact_sales;

-- Revenue by year--
SELECT `year`,SUM(sales_amount) AS Revenue_by_year
FROM fact_sales
GROUP BY `year`;

-- Orders by Product_category--
SELECT product_category_name,COUNT(order_id) AS total_orders
from fact_sales
GROUP BY product_category_name;

-- Top 10 customers by revenue--
SELECT customer_id,SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY customer_id
ORDER BY SUM(sales_amount) DESC LIMIT 10 ;

-- Revenue by customer state
SELECT customer_state, SUM(sales_amount) AS Total_revenue
FROM fact_sales AS fac
JOIN dim_customer AS dim
ON fac.customer_id=dim.customer_id
GROUP BY customer_state;

-- Customer state-wise total orders--
SELECT customer_state, COUNT(order_id) AS Total_orders
FROM fact_sales AS fac
JOIN dim_customer AS dim
ON fac.customer_id=dim.customer_id
GROUP BY customer_state;

-- product category-wise revenue
SELECT dim.product_category_name, SUM(sales_amount) AS Total_revenue
FROM fact_sales AS fac
JOIN dim_product AS dim
ON fac.product_id=dim.product_id
GROUP BY product_category_name;

-- Sales Value Segmentation--
SELECT SUM(sales_amount) AS Total_revenue,
CASE
	WHEN sales_amount>=500 THEN 'HIGH VALUE'
    WHEN sales_amount < 500 THEN 'LOW VALUE'
END AS Sales_values
FROM fact_sales
GROUP BY Sales_values;


-- Freight Cost Segmentation
SELECT SUM(freight_value) AS Total_freight_cost,
CASE
	WHEN freight_value >= 50 THEN 'HIGH FREIGHT'
    WHEN freight_value < 50 THEN 'LOW FREIGHT'
END AS Freight_values
FROM fact_sales
GROUP BY Freight_values;

-- Price segmentation
SELECT SUM(price) AS Total_price,
CASE
	WHEN price >= 1000 THEN 'EXPENSIVE'
    WHEN price < 1000 THEN 'AFFORDABLE'
END AS Price_values
FROM fact_sales
GROUP BY Price_values;

-- Customers Above Average Revenue
SELECT customer_id, SUM(sales_amount) AS total_revenue
FROM fact_sales
GROUP BY customer_id
HAVING SUM(sales_amount) > (
    SELECT AVG(total_revenue)
    FROM (
        SELECT customer_id, SUM(sales_amount) AS total_revenue
        FROM fact_sales
        GROUP BY customer_id
    ) AS customer_totals
);

-- Above-average product revenue--
SELECT product_id, SUM(sales_amount) AS total_revenue
FROM fact_sales
GROUP BY product_id
HAVING SUM(sales_amount) > (
    SELECT AVG(total_revenue)
    FROM (
        SELECT product_id, SUM(sales_amount) AS total_revenue
        FROM fact_sales
        GROUP BY product_id
    ) AS product_totals
);

-- Monthly Revenue--
WITH monthly_revenue AS (
    SELECT `year`, `month`, SUM(sales_amount) AS total_revenue
    FROM fact_sales
    GROUP BY `year`, `month`
)
SELECT *
FROM monthly_revenue;

-- Customer Revenue Ranking--
WITH customer_revenue AS (
	SELECT customer_id,SUM(sales_amount) AS total_revenue
    FROM fact_sales
    GROUP BY customer_id
)
SELECT customer_id,total_revenue,
RANK() OVER(ORDER BY total_revenue desc) AS Revenue_ranking
FROM customer_revenue;

-- Monthly Revenue Comparison
WITH Monthly_revenue AS (
SELECT `year`,`month`,SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY `year`,`month`
)
SELECT `year`,`month`,Total_revenue,
LAG(Total_revenue) OVER(ORDER BY `year`,`month` ) AS Previuos_month_revenue
from Monthly_revenue;


-- Month-over-Month Revenue Difference
WITH Monthly_revenue AS (
SELECT `year`,`month`,SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY `year`,`month`
)
SELECT `year`,`month`,Total_revenue,
LAG(Total_revenue) OVER(ORDER BY `year`,`month` ) AS Previuos_month_revenue,
Total_revenue-LAG(Total_revenue) OVER(ORDER BY `year`,`month` ) AS Revenue_Difference
from Monthly_revenue;

-- Product Ranking Within Category--
WITH product_ranking AS (
SELECT product_category_name,product_id,SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY product_category_name,product_id
)
SELECT product_category_name,product_id,Total_revenue,
RANK() OVER(PARTITION BY Product_category_name ORDER BY Total_revenue desc) AS Product_ranking
from product_ranking;

-- Monthly Revenue Growth %--
WITH Monthly_revenue AS (
SELECT `year`,`month`,SUM(sales_amount) AS Total_revenue
FROM fact_sales
GROUP BY `year`,`month`
)
SELECT `year`,`month`,Total_revenue,
LAG(Total_revenue) OVER(ORDER BY `year`,`month` ) AS Previuos_month_revenue,
(Total_revenue - LAG(Total_revenue) OVER(ORDER BY `year`,`month`))
/
LAG(Total_revenue) OVER(ORDER BY `year`,`month`) * 100 AS Revenue_Growth
from Monthly_revenue;

-- =====================================================
-- KEY BUSINESS INSIGHTS
-- =====================================================

-- 1. Identified top-performing products and categories
--    contributing the highest revenue.

-- 2. Analyzed monthly and yearly revenue trends
--    to evaluate sales performance and growth patterns.

-- 3. Identified high-value customers by comparing
--    customer revenue with average customer revenue.

-- 4. Analyzed customer revenue by state to identify
--    geographically strong markets.

-- 5. Segmented sales into High Value and Low Value
--    transactions to understand sales value distribution.

-- 6. Segmented freight costs into High Freight and
--    Low Freight categories to evaluate shipping costs.

-- 7. Identified above-average revenue products and
--    ranked products within each category.

-- 8. Compared monthly revenue with the previous month
--    to identify revenue increases and declines.

-- 9. Calculated month-over-month revenue growth to
--    support business performance monitoring.
