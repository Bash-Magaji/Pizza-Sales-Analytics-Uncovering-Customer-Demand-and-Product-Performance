**1. Introduction**

This report presents an end-to-end SQL-PowerBi based analysis of pizza sales performance using the pizza_sales dataset. The analysis was designed to evaluate business performance through key performance indicators (KPIs), customer ordering patterns, product performance, pizza category contribution, size preferences, and the performance of top- and bottom-selling pizzas. The analysis uses PostgreSQL-style SQL queries to calculate Total Revenue, Average Order Value (AOV), Total Pizzas Sold, Total Orders, and Average Pizzas per Order. Additional analysis evaluates daily and monthly order trends, revenue contribution by pizza category and size, quantity sold by category, and the top and bottom five pizzas by revenue, quantity, and order frequency.
The findings indicate clear differences in customer demand across days, months, pizza categories, sizes, and individual products and were visualized using PowerBi. Friday recorded the highest daily order volume at 3,538 orders, while Sunday recorded the lowest among the observed days at 2,624 orders. Monthly demand fluctuated considerably, with July recording the highest monthly order volume at 1,935 orders and October recording the lowest at 1,646 orders.
The Classic category generated the highest share of sales at 26.91%, followed by Supreme at 25.46%. Large pizzas dominated sales by size with 45.89%, while XXL pizzas accounted for only 0.12%. Classic pizzas also led category-level quantity sold with 14,888 units.
At product level, Thai Chicken, Barbecue Chicken, and California Chicken were among the strongest revenue performers, while pizzas such as Brie Carre, Spicy Italian, and several specialty vegetable pizzas appeared among the weaker performers. However, the rankings based on revenue, quantity, and orders are not identical, demonstrating the importance of evaluating product performance using multiple KPIs rather than relying on sales volume alone.
The analysis further provides a basis for improving demand forecasting, menu optimization, pricing, promotional planning, inventory management, and product portfolio decisions.
The pizza sales analysis was undertaken to transform transactional sales data into actionable business insights. The dataset contains information relating to pizza orders, including order identifiers, dates, times, quantities, prices, sizes, categories, ingredients, and pizza names and was obtained from kaggle.

The analysis focuses on answering key business questions such as:

•	How much revenue is generated?

•	How frequently do customers place orders?

•	How many pizzas are sold?

•	How does demand vary by day and month?

•	Which pizza categories generate the greatest revenue?

•	Which sizes are most preferred by customers?

•	Which individual pizzas perform best?

•	Which products require further investigation or intervention?

The objective is not only to report sales figures but also to identify patterns that can support data-driven decision-making.
 
<img width="795" height="870" alt="Pizza Sales Report Dashboard" src="https://github.com/user-attachments/assets/67b2d964-e0ad-4dff-93e8-3cbce84d7106" />

Pizza Sales Performance Dashboard

**2. Dataset Structure**

The analysis is based on a table named pizza_sales containing the following fields:

**Field**  	**Description**

pizza_id	Unique pizza record identifier

order_id	Customer order identifier

pizza_name_id	Pizza product code

quantity	Number of pizzas sold

order_date	Date of order

order_time	Time of order

unit_price	Price per pizza

total_price	Total value of the pizza line

pizza_size	Size of pizza

pizza_category	Pizza category

pizza_ingredients	Ingredients used

pizza_name	Name of pizza

The dataset is transactional in nature, meaning individual rows represent pizza sales records associated with customer orders.

**3. Analytical Approach and SQL Methodology**

The analysis was conducted using SQL queries to aggregate transactional records into business-level KPIs.

**3.1. KPI Analysis**

The analysis was designed around five primary business KPIs:

1.	Total Revenue

2.	Average Order Value

3.	Total Pizzas Sold

4.	Total Orders

5.	Average Pizzas per Order

These KPIs provide complementary perspectives. Revenue measures financial performance, orders measure transaction activity, quantity measures product volume, while AOV and average pizzas per order provide insight into customer basket behavior.

**3.2 Total Revenue**

Total revenue was calculated as the sum of the total_price field:

SELECT SUM(total_price) AS Total_Revenue

FROM pizza_sales;

Result => $817,860.05

This KPI measures the overall monetary value generated from pizza sales.

**3.3 Average Order Value**

Average Order Value was calculated by dividing total revenue by the number of distinct orders:

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value

FROM pizza_sales;

Result => 38.31

This metric indicates the average amount spent per customer order and is useful for evaluating basket value.

**3.4 Total Pizzas Sold**

Total quantity sold was calculated using:

SELECT SUM(quantity) AS Total_Pizzas_Sold

FROM pizza_sales;

Result => 49,574

This measures the overall volume of pizzas sold.

**3.5 Total Orders**

Distinct order IDs were counted to prevent multiple pizza records within the same order from being counted as separate orders:

SELECT COUNT(DISTINCT order_id) AS Total_Order

FROM pizza_sales;

Result => 21,350

This is particularly important because a single order may contain multiple pizza products.

**3.6 Average Pizzas per Order**

Average pizzas per order was calculated as:

SELECT 

CAST(
   
    CAST(SUM(quantity) AS DECIMAL(10,2)) /
    
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
   
    AS DECIMAL(10,2)
)

AS Average_Pizzas_Per_Order

FROM pizza_sales;

**Result** => 2.32

This provides an indication of the average number of pizzas purchased in a transaction.

**4. Chart and Visualizations**

**4.1 Daily Order Trend Analysis**

The daily order analysis showed a clear weekly pattern.

Orders increased progressively from:

•	Sunday: 2,624

•	Friday: 3,538

•	Saturday: 3,158

Friday recorded the highest order volume, while Sunday recorded the lowest among the observed days.

**Key Observation**

The pattern suggests that customer demand increases throughout the working week and reaches its highest level on Friday before declining over the weekend.

**Recommended Investigations**

The following areas should be investigated:

•	What factors drive the Friday peak?

•	Are Friday promotions or discounts contributing to the increase?

•	Are customers placing larger orders on Fridays?

•	Are workplace, social, or family occasions contributing to increased demand?

•	Why does order volume decline after Friday?

•	Does the business have sufficient operational capacity to handle Friday demand?

•	Are there differences in pizza categories and sizes ordered across the week?

**Business Implication**

The Friday peak provides an opportunity to optimize staffing, ingredient inventory, production capacity, delivery resources, and promotional campaigns around periods of high demand.

**4.2. Monthly Order Trend Analysis**

Monthly orders displayed considerable fluctuation rather than a stable upward or downward trend.

Month	Orders

January	1,845

February	1,685

March	1,840

April	1,799

May	1,853

June	1,773

July	1,935

August	1,841

September	1,661

October	1,646

November	1,792

December	1,680

July recorded the highest monthly volume at 1,935 orders, while October recorded the lowest at 1,646 orders.

**Key Observations**

The dataset shows:

•	A sharp decline between January and February.

•	Recovery between February and March.

•	Several fluctuations between March and June.

•	A peak in July.

•	A progressive decline from July through October.

•	Recovery in November.

•	Another decline in December.

**Recommended Investigations**

Further analysis should examine:

•	Seasonal demand patterns.

•	Marketing campaigns and promotions.

•	Holidays and special events.

•	Weather conditions.

•	Customer purchasing behavior.

•	Economic or income-cycle effects.

•	Customer acquisition and retention patterns.

•	Operational constraints.

•	Product-level changes across high- and low-performing months.

**Business Implication**

The monthly trend can support demand forecasting and help management plan promotional campaigns and inventory levels around predictable high- and low-demand periods.

**4.3 Revenue Contribution by Pizza Category**

The revenue distribution by pizza category was relatively balanced:

Category	Revenue Share

Classic	26.91%

Supreme	25.46%

Chicken	23.96%

Veggie	23.68%

Classic was the leading category, accounting for 26.91% of total sales revenue, while Veggie recorded the lowest share at 23.68%.

**Key Observations**

Although Classic leads the category ranking, the difference between the four categories is relatively small. This suggests that there is no extremely dominant category and that customers purchase across a broad range of product types.

**Recommended Investigations**

The analysis should investigate:

•	Why Classic performs slightly better than the other categories.

•	Whether category pricing influences revenue performance.

•	Whether the leading category also generates the highest profit margin.

•	Whether category performance changes over time.

•	Customer preferences by category.

•	The effect of promotions on individual categories.

•	Ingredient costs and category profitability.

•	Opportunities to increase Chicken and Veggie category performance.

**Business Implication**

Management should avoid focusing exclusively on revenue share. Category profitability, customer retention, production costs, and repeat purchase behavior should also be considered before making portfolio decisions.

**4.4 Pizza Size Sales Analysis**

Large pizzas represented the highest share of sales at 45.89%, followed by Medium at 30.49% and Regular at 21.77%.

XL and XXL recorded very low shares:

•	XL: 1.72%

•	XXL: 0.12%

**Key Observation**
Large, Medium, and Regular pizzas collectively account for almost all observed sales, while XL and XXL demand is extremely limited.

**Recommended Investigations**

Management should examine:

•	Whether Large pizzas offer better perceived value.

•	Price differences between sizes.

•	Customer preferences based on order occasion.

•	Whether XL and XXL prices discourage purchases.

•	Whether XL and XXL sizes are sufficiently promoted.

•	Whether these sizes should be repositioned as party or group products.

•	The profitability of each size.

•	Potential inventory and production waste associated with low-demand sizes.

**Business Implication**

The company should prioritize Large and Medium sizes in forecasting and inventory planning while evaluating whether XL and XXL should be redesigned, repositioned, bundled, or reduced.

**4.5 Quantity Sold by Pizza Category**

Classic pizzas recorded the highest quantity sold at 14,888 units, followed by:

•	Supreme: 11,987 units

•	Veggie: 11,649 units

•	Chicken: 11,050 units

**Key Observation**

Classic has a significant lead in quantity sold, while Supreme, Veggie, and Chicken are relatively close to one another.

**Recommended Investigations**

The following questions should be examined:

•	Is Classic's higher quantity caused by lower prices?

•	Does Classic have a wider selection of individual pizza products?

•	Are Classic pizzas more frequently included in promotions?

•	Do customers reorder Classic pizzas more frequently?

•	Is Classic consistently the top category across months?

•	Are other categories more profitable despite lower volume?

**Business Implication**

Category volume should be evaluated alongside revenue and gross margin to determine whether high-volume products are actually the most valuable products to the business.

**4.6 Top Pizzas by Revenue**

Among the reported leading products, the strongest revenue performers included:

**Pizza**	**Revenue**

Thai Chicken	43,434.25

Barbecue Chicken	42,768.00

California Chicken	41,409.50

The reported lower performers within this comparison included:

Pizza	Revenue

Classic Deluxe	38,180.50

Spicy Italian	34,831.25

**Recommended Investigations**

The performance differences should be investigated through:

•	Pricing analysis.

•	Ingredient and flavor analysis.

•	Customer preference patterns.

•	Promotional exposure.

•	Menu positioning.

•	Revenue per order.

•	Revenue versus quantity sold.

•	Profit margin per product.

An important finding is that revenue leadership does not necessarily correspond to quantity leadership. Therefore, product performance should be evaluated using revenue, quantity, order frequency, and profitability together.

**4.7 Top Pizzas by Quantity Sold**

The highest quantities reported were:

**Pizza	Quantity Sold**

Classic Deluxe	2,453

Barbecue Chicken	2,432

Hawaiian	2,422

Pepperoni	2,418

Thai Chicken	2,371

**Key Observation**

The differences between these five pizzas are relatively small. Classic Deluxe leads at 2,453 units, while Thai Chicken records 2,371 units.

This indicates that the top products have relatively similar demand volumes.

**Recommended Investigations**

The business should examine:

•	Whether differences in quantity are statistically or commercially significant.

•	Unit price differences.

•	Revenue generated per unit.

•	Customer repeat purchase rates.

•	Product availability.

•	Promotion participation.

•	Seasonal performance.

•	Customer preferences across different products.

**4.8 Top Pizzas by Number of Orders**

Classic Deluxe led the reported order ranking:

**Pizza	Orders**

Classic Deluxe	2,329

Hawaiian	2,280

Pepperoni	2,278

Barbecue Chicken	2,273

Thai Chicken	2,225

**Key Observation**

Order counts are closely clustered, indicating strong and relatively comparable demand among these pizzas.

**Recommended Investigations**

Analysis should determine:

•	Whether these pizzas generate similar average quantities per order.

•	Which products encourage repeat purchases.

•	Whether pricing affects order frequency.

•	Whether these products are commonly included in combos.

•	Whether product rankings remain consistent over time.

•	Whether particular customer segments favor individual pizzas.

**4.9 Bottom Five Pizzas by Revenue**

The reported bottom five pizzas by revenue were:

**Pizza	Revenue**

Spinach Pesto	15,596.00

Mediterranean	15,360.50

Spinach Supreme	15,277.75

Green Garden	13,955.75

Brie Carre	11,588.49

Brie Carre had the lowest revenue among the reported bottom five.

**Recommended Investigations**

The investigation should focus on:

•	Low product awareness.

•	Customer taste preferences.

•	Pricing and perceived value.

•	Menu positioning.

•	Promotional support.

•	Product availability.

•	Ingredient appeal.

•	Customer satisfaction.

•	Repeat purchase rates.

•	Profitability despite low revenue.

A low-revenue product should not automatically be removed because revenue alone does not establish profitability.


**4.10 Bottom Five Pizzas by Quantity**

The lowest quantities reported were:

**Pizza	Quantity Sold**

Soppressata	961

Spinach Supreme	950

Calabrese	937

Mediterranean	934

Brie Carre	490

Brie Carre recorded a substantially lower quantity than the other four products.

**Key Observation**

There is a notable gap between Brie Carre and the other bottom-performing products, which may indicate a more significant demand problem.

**Recommended Investigations**

The business should investigate:

•	Product appeal and taste.

•	Pricing.

•	Portion size.

•	Ingredient preferences.

•	Product visibility.

•	Customer ratings and feedback.

•	Product availability.

•	Promotion effectiveness.

•	Repeat purchase behavior.

•	Whether the product should be reformulated or repositioned.

**4.11 Bottom Five Pizzas by Order Frequency**

The bottom-five order analysis should be evaluated alongside the revenue and quantity rankings.

This comparison is important because a product may have:

•	Low revenue but reasonable order frequency.

•	Low quantity but high revenue per order.

•	High order frequency but low quantity per order.

Therefore, management should avoid treating a single ranking as a complete measure of product performance.

**5. Key Business Findings**

One of the most important findings from the analysis is that revenue, quantity, and order count produce different product rankings.
For example, Classic Deluxe leads quantity and order frequency among the reported top products, while Thai Chicken is among the strongest revenue performers.
This suggests that:  High-volume products are not necessarily high-value products.

The analysis produced the following major findings:

•	Strong Friday Demand
Friday recorded the highest observed daily order volume at 3,538 orders, indicating a strong weekly demand concentration.

•	Significant Monthly Volatility
Monthly orders fluctuate considerably, with July reaching 1,935 orders and October falling to 1,646 orders.

•	Classic Category Leadership
Classic generated the largest category revenue contribution at 26.91% and sold the largest quantity at 14,888 units.

•	Large Pizza Dominance
Large pizzas accounted for 45.89% of sales, demonstrating a strong customer preference for this size.

•	Extremely Low XXL Demand
XXL pizzas represented only 0.12% of sales, suggesting a significant mismatch between available size and customer demand.

•	Strong Chicken Product Performance
Thai Chicken, Barbecue Chicken, and California Chicken appeared among the strongest revenue-generating products.

•	Product Rankings Differ by KPI
The products leading quantity and order frequency are not always the same as those leading revenue, highlighting the importance of multi-dimensional performance analysis.

•	Brie Carre Requires Attention
Brie Carre consistently appears among the weakest products by revenue and quantity, making it a strong candidate for deeper product-level investigation.

**6. Business Recommendations**

Based on the analysis, the following actions are recommended:

•	Optimize Friday Operations
Increase staffing, production capacity, ingredient availability, and delivery resources during Friday periods to capture peak demand.

•	Develop Low-Season Promotions
Introduce targeted campaigns during weaker months, particularly around September and October, to stimulate demand.

•	Prioritize High-Performing Categories
Maintain strong availability and visibility for Classic and Supreme pizzas while developing targeted strategies for Chicken and Veggie categories.

•	Reassess Pizza Size Portfolio
Prioritize Large and Medium pizzas while testing alternative positioning for XL and XXL sizes.

•	Learn from High-Performing Products
Study the pricing, ingredients, customer appeal, and promotional exposure of Thai Chicken, Barbecue Chicken, and California Chicken to identify transferable success factors.

•	Review Underperforming Products
Conduct a structured review of products such as Brie Carre, Mediterranean, Spinach Supreme, and other weak performers to determine whether they require recipe improvement, repositioning, pricing changes, or removal.

•	Improve Demand Forecasting
Use historical daily and monthly trends to improve staffing, procurement, inventory, and production planning.

**7. Conclusion**

The SQL-based pizza sales analysis provides a comprehensive overview of business performance by examining revenue, orders, quantity sold, customer basket behavior, product categories, sizes, and individual pizza performance. The results reveal a strong weekly demand pattern, significant monthly fluctuations, strong customer preference for large pizzas, and a leading contribution from the Classic category. At product level, several chicken-based pizzas demonstrate strong revenue performance, while products such as Brie Carre appear consistently among the weaker performers.  The project demonstrates how SQL can transform transactional pizza sales data into actionable business intelligence and provide a strong foundation for data-driven commercial decision-making.

**8. References**

Data source: https://www.kaggle.com/datasets/nextmillionaire/pizza-sales-dataset

Replicated Concept: https://www.youtube.com/watch?v=V-s8c6jMRN0&list=PPSV
