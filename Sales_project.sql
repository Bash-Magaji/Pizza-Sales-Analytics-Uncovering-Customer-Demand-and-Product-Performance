CREATE TABLE pizza_sales (
			 pizza_id INT,
			 order_id INT,
			 pizza_name_id VARCHAR,
			 quantity INT,
			 order_date DATE,
			 order_time TIME WITHOUT TIME ZONE,
			 unit_price FLOAT,
			 total_price FLOAT,
			 pizza_size VARCHAR,
			 pizza_category TEXT,
			 pizza_ingredients TEXT,
			 pizza_name TEXT
);

select * from pizza_sales

/* PROBLEM STATEMENT

KPI Requirement

We need to analyze key indicators for our pizza sales to gain insights into our business performance. 
Specifically, we want to calculate the following metrics:
1.	Total Revenue: the sum of the total price of all pizza orders.
2.	Average order value: the average amount spent per order, calculated by dividing the 
    total revenue by the total number of orders.
3.	Total pizza sold: the sum of the quantity of all pizzas sold.
4.	Total orders: the total number of orders placed.
5.	Average pizza per order: the average number of pizzas sold per order, 
    calculated by dividing the total number of pizzas sold by the total number of orders. */

-- Total Revenue --

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

select * from pizza_sales;

-- Average order value --

SELECT SUM(total_price)/ COUNT (DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales;

select * from pizza_sales;

-- Total Pizza Sold --

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

select * from pizza_sales;

-- Total Order --

SELECT COUNT(DISTINCT Order_id) AS Total_Order 
FROM pizza_sales;

select * from pizza_sales;

-- Average Pizza Per Order --

SELECT CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / 
CAST(COUNT(DISTINCT Order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) Average_Pizzas_Per_Order
FROM pizza_sales;


/* KPI Requirements 

1.	Daily Trend for Total Orders
2.	Monthly Trend for Total Orders
3.	Percentage of Sales by Pizza Category
4.	Percentage of Sales by Pizza Size
5.	Total Pizzas Sold by Pizza Category
6.	Top Five Best Sellers by Revenue, Total Quantity and Total Order
7.	Bottom five worst sellers by Revenue, Total quantity and Total order */

-- Daily Trend for Total Orders --

select * from pizza_sales;

SELECT
    TO_CHAR(order_date, 'Day') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales
GROUP BY
    TO_CHAR(order_date, 'Day'),
    EXTRACT(DOW FROM order_date);

	
-- Monthly Trend for Total Orders --

select * from pizza_sales;

SELECT
    TO_CHAR(order_date, 'Month') AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales
GROUP BY
    TO_CHAR(order_date, 'Month');
   
-- Percentage of Sales by Pizza Category --

select * from pizza_sales;

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size --

select * from pizza_sales;

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Total Pizzas Sold by Pizza Category --

select * from pizza_sales;

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top Five Pizzas by Revenue -- 

select * from pizza_sales;

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Top Five Pizzas by Quantity -- 

select * from pizza_sales;

SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

-- Top Five Pizzas by Total Order -- 

select * from pizza_sales;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order DESC
LIMIT 5;

-- Bottom Five Pizzas by Revenue --

select * from pizza_sales;

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- Bottom Five Pizzas by Quantity --

select * from pizza_sales;

SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
LIMIT 5;

-- Bottom Five Pizzas by Total Order -- 

select * from pizza_sales;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order ASC
LIMIT 5;