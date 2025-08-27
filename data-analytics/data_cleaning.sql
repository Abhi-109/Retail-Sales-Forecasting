USE retailSales;
DESCRIBE Orders;
DESCRIBE People;
DESCRIBE returns;

-- DATA CLEANING
SELECT * FROM returns;
SELECT * FROM Orders;
SELECT * FROM people;

-- DATA TYPE CONVERTION
ALTER TABLE returns
MODIFY `Order ID` VARCHAR(50);
 
SELECT *
FROM People;
ALTER TABLE Orders
MODIFY order_id VARCHAR(50),
MODIFY order_date DATE,
MODIFY ship_date DATE,
MODIFY product_id VARCHAR(50),
MODIFY year INT;

-- DUPLICATE VALUES
SELECT COUNT(*) AS count,order_id
FROM Orders
GROUP BY order_id
HAVING count >1;

-- NULL VALUES 
SET SQL_SAFE_UPDATES =0;

SELECT * FROM Orders
WHERE region IS NULL;
-- As per as we can see all the null values from region is from market canada so we are considering region as canada

UPDATE Orders SET region = 'Canada'
WHERE region IS NULL;

SELECT SUBSTRING_INDEX(product_name,',' ,1) AS product,
	    TRIM(SUBSTRING_INDEX(product_name,',',-1)) AS product_features
FROM Orders; -- product name column have features combine it


ALTER TABLE Orders
ADD COLUMN product_features VARCHAR(150) AFTER product_name,
ADD COLUMN products VARCHAR(150) AFTER product_name;

UPDATE Orders
SET products=SUBSTRING_INDEX(product_name,',' ,1),
    product_features=TRIM(SUBSTRING_INDEX(product_name,',',-1)) ;

ALTER TABLE Orders
DROP COLUMN product_name;

ALTER TABLE Orders
RENAME COLUMN products TO product_name;

-- we had a column called product name which had both name of the product  and feature of  that product so we split it that column into two parts as product name and product feature 
SELECT ROUND(((sales/quantity)-shipping_cost),3) AS price ,sales,quantity
FROM Orders;

SELECT ROUND((sales-profit),3) AS product_cost,sales,profit
FROM Orders;

ALTER TABLE Orders
	ADD COLUMN price decimal(10,3) AFTER product_features,
	ADD COLUMN product_cost decimal(10,3) AFTER sales;
    
UPDATE Orders
	SET price=ROUND(((sales/quantity)-shipping_cost),3),
    product_cost =ROUND((sales-profit),3);
    
SELECT (ship_date-order_date) 
FROM Orders;

ALTER TABLE Orders
ADD COLUMN days_delayed INT;

UPDATE Orders
	SET days_delayed=ship_date-order_date;
    
SELECT ((sales-product_cost)/sales) * 100
FROM Orders;

ALTER TABLE Orders
ADD COLUMN gross_margin DECIMAL(10,3);

UPDATE Orders
SET gross_margin =ROUND(((sales-product_cost)/sales) * 100,3)
