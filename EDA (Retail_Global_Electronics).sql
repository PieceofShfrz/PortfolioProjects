SELECT
 pro.ProductKey, pro.`Product Name`, 
 pro.Brand, pro.Color, 
pro.Unit_Cost_USD,
pro.Unit_Price,
 pro.Subcategory, pro.Category, sal.Quantity
FROM productsnewupdated AS pro
INNER JOIN salesupdated AS sal
ON pro.ProductKey = sal.ProductKey;


-- 1. Finding the most sold product in all categories
-- 2. Calculating the profit
-- 3. Finding the Most Profitable Product Category
-- 4. Calculating Total Sales per Product

-- 1. Finding the most sold product in all categories

SELECT
 pro.ProductKey, pro.`Product Name`, 
 SUM(sal.quantity) AS Total_unit_sold
FROM productsnewupdated AS pro
INNER JOIN salesupdated AS sal
ON pro.ProductKey = sal.ProductKey
GROUP BY pro.ProductKey, pro.`Product Name`
ORDER BY Total_unit_sold DESC
LIMIT 5;

-- 2. Calculating the profit
SELECT
 pro.ProductKey, pro.`Product Name`, pro.Category, sal.quantity, 
ROUND((pro.Unit_Price - pro.Unit_Cost_USD), 2) AS profit_per_unit,
ROUND((pro.Unit_Price - pro.Unit_Cost_USD) * sal.quantity, 2) AS Total_Profit
FROM productsnewupdated AS pro
INNER JOIN salesupdated AS sal
ON pro.ProductKey = sal.ProductKey
ORDER BY Total_Profit DESC
limit 5;

-- 3. Finding the Most Profitable Product Category

WITH profit_cte AS 
(
SELECT
 pro.ProductKey, pro.`Product Name`, pro.Category, sal.quantity, 
ROUND((pro.Unit_Price - pro.Unit_Cost_USD), 3) AS profit_per_unit,
ROUND((pro.Unit_Price - pro.Unit_Cost_USD) * sal.quantity, 3) AS Total_Profit
FROM productsnewupdated AS pro
INNER JOIN salesupdated AS sal
ON pro.ProductKey = sal.ProductKey
)
SELECT Category, ROUND(Sum(Total_Profit), 3) AS Category_Profit
FROM profit_cte
GROUP BY Category
ORDER BY Category_Profit DESC; 

-- 4. Calculating Total Sales per Product
with total_sales_product AS
(
SELECT
 pro.ProductKey, pro.`Product Name`, pro.Category, sal.quantity, Unit_Cost_USD, Unit_Price,
ROUND((pro.Unit_Price - pro.Unit_Cost_USD), 3) AS profit_per_unit,
ROUND((pro.Unit_Price - pro.Unit_Cost_USD) * sal.quantity, 3) AS Total_Profit
FROM productsnewupdated AS pro
INNER JOIN salesupdated AS sal
ON pro.ProductKey = sal.ProductKey
)
SELECT ProductKey, `Product Name`,
SUM(Unit_Price * Quantity) AS Total_Sales
FROM total_sales_product
GROUP BY ProductKey, `Product Name`
order by Total_Sales DESC
LIMIT 5;

WITH deletedot_cte AS
(
SELECT
 pro.ProductKey, pro.`Product Name`, 
 pro.Brand, pro.Color, 
 pro.Unit_Cost_USD,
 REPLACE(CAST(pro.Unit_Cost_USD AS CHAR), '.', '') AS Unit_Cost_Without_Dot,
pro.Unit_Price,
REPLACE(CAST(pro.Unit_Price AS CHAR), '.', '') AS Unit_Price_Without_Dot,
 pro.Subcategory, pro.Category, sal.Quantity
FROM productsnewupdated AS pro
INNER JOIN salesupdated AS sal
ON pro.ProductKey = sal.ProductKey
)
SELECT *
FROM deletedot_cte





