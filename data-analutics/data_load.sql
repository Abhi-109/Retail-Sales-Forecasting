CREATE TABLE Returns(
     Returns TEXT,
    `Order ID` VARCHAR(50) PRIMARY KEY,
    Market VARCHAR(50));

SELECT * FROM Returns;
DESCRIBE Returns;

CREATE TABLE Orders (
    order_id VARCHAR(50) ,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50)PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    order_priority VARCHAR(50),
    year INT
);
DESCRIBE Orders;
