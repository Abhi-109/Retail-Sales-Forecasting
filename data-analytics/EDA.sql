USE sales;

SELECT * FROM Orders;
SELECT * FROM Returns;
SELECT * FROM People;
-- KPI ANALYSIS
-- Total Sales per category
SELECT *
FROM 
(
SELECT category,SUM(sales) AS Total_sales
FROM Orders
GROUP BY category
) AS t1
CROSS JOIN
(
SELECT sub_category,SUM(sales) AS Total_sales
FROM Orders
GROUP BY sub_category
) AS t2;

-- Total Orders
SELECT COUNT(order_id) AS Total_Order
FROM Orders;

-- Average product price
SELECT products,AVG(price) AS avg_price
FROM Orders
GROUP BY products
ORDER BY avg_price DESC;

-- Profit margin
SELECT *
FROM 
(
SELECT category,AVG(gross_margin) AS profit_margin
FROM Orders
GROUP BY category
) AS t1
CROSS JOIN
(
SELECT sub_category,AVG(gross_margin) AS profit_margin
FROM Orders
GROUP BY sub_category
) AS t2;

-- Return rate
SELECT Total_orders,Total_returns,(Total_returns/Total_orders)*100 AS Return_rate
FROM
(SELECT COUNT(*) AS Total_returns
FROM Orders AS o
JOIN Returns AS r
ON o.order_id=r.`Order ID`
WHERE r.Returned ="Yes") AS t2
CROSS JOIN
(
SELECT COUNT(order_id) AS Total_orders
FROM Orders
) AS t1;
-- EXPLORATORY DATA ANALYSIS
-- Find the total sales, profit, and quantity per region.
SELECT region,SUM(sales)AS Total_sales,SUM(profit) AS Total_profit,SUM(quantity) AS Total_quantity
FROM Orders
GROUP BY  region;

-- Calculate the monthly trend of sales and profit.
SELECT MONTH(order_date) AS Month,SUM(sales) AS Total_sales,SUM(profit) AS Total_profit
FROM Orders
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- Find the top 5 customers with the highest total sales.
SELECT customer_name,SUM(sales) AS total_sales FROM Orders 
GROUP BY customer_name
ORDER BY total_sales DESC LIMIT 5;

-- Identify the most profitable sub_category in each region.
SELECT o.region,o.sub_category,SUM(o.profit) AS highest_profit FROM Orders AS o
GROUP BY o.region,sub_category 
HAVING SUM(o.profit)=(SELECT MAX(sub_profit) FROM(SELECT region,sub_category,SUM(profit) AS sub_profit
					  FROM Orders 
                      WHERE region=o.region
                      GROUP BY region,sub_category) AS p);

-- Find the average shipping delay (days_delayed) per ship_mode.
SELECT ship_mode,AVG(days_delayed) AS avg_shipping_delay FROM Orders
GROUP BY ship_mode;

