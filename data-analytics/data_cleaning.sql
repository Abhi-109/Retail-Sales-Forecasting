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
