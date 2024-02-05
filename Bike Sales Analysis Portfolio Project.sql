SELECT *
FROM BikeStoreSales..BikeSalesInEurope

--Arrange the time of sales from beginning
SELECT Date, Day, Month, Year
FROM BikeStoreSales..BikeSalesInEurope
ORDER BY Date 

--Arranging of gender and age from the customers
SELECT Customer_Gender, Customer_Age, Age_Group
FROM BikeStoreSales..BikeSalesInEurope
ORDER BY Customer_Age

--Total of young customers
SELECT Customer_Gender, Age_Group, COUNT(Customer_Age) AS YoungCustomers
FROM BikeStoreSales..BikeSalesInEurope
WHERE Customer_Age < 25
GROUP BY Customer_Gender, Age_Group
ORDER BY YoungCustomers

--Total of young adults
SELECT Customer_Gender, Age_Group, COUNT(Customer_Age) AS YoungAdultCustomers
FROM BikeStoreSales..BikeSalesInEurope
WHERE Customer_Age > 24 and Customer_Age < 35
GROUP BY Customer_Gender, Age_Group
ORDER BY YoungAdultCustomers

--Total of adult customers
SELECT Customer_Gender, Age_Group, COUNT(Customer_Age) AS AdultCustomers
FROM BikeStoreSales..BikeSalesInEurope
WHERE Customer_Age > 34 and Customer_Age < 65
GROUP BY Customer_Gender, Age_Group
ORDER BY AdultCustomers

--Total of senior customers
SELECT Customer_Gender, Age_Group, COUNT(Customer_Age) AS SeniorCustomers
FROM BikeStoreSales..BikeSalesInEurope
WHERE Customer_Age > 64
GROUP BY Customer_Gender, Age_Group
ORDER BY SeniorCustomers

--total product in sub category
SELECT product, Sub_Category,
	COUNT (product)OVER (PARTITION BY sub_category) AS Total_Sub_Product
FROM BikeStoreSales..BikeSalesInEurope

--total product in product category
SELECT product, Product_Category,
	COUNT (product)OVER (PARTITION BY Product_category) AS Total_Category_product
FROM BikeStoreSales..BikeSalesInEurope

--total order of each products
SELECT Product, SUM(Order_Quantity) AS Total_Order,AVG(Unit_Cost) AS Avg_Unit_Cost,
AVG(Unit_price) AS Avg_Unit_Price
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Product
ORDER BY Total_Order DESC

--average profit product of each state
SELECT State, Product, Profit, Cost, Revenue,
CAST(FORMAT(AVG(Profit) OVER (PARTITION BY State), '0') AS bigint) AS Avg_Profit_Product
FROM BikeStoreSales..BikeSalesInEurope 
ORDER BY Avg_Profit_Product DESC

--average cost product of each state
SELECT State, Product, Profit, Cost, Revenue,
CAST(FORMAT(AVG(Cost) OVER (PARTITION BY State), '0') AS bigint) AS Avg_Cost_Product
FROM BikeStoreSales..BikeSalesInEurope
ORDER BY Avg_Cost_Product DESC

--average revenue product of each state
SELECT State, Product, Profit, Cost, Revenue,
CAST(FORMAT(AVG(Revenue) OVER (PARTITION BY State), '0') AS bigint) AS Avg_Revenue_Product 
FROM BikeStoreSales..BikeSalesInEurope
ORDER BY Avg_Revenue_Product DESC

--maximum for order, unit cost, price, profit, cost, and revenue in Product category
SELECT MAX(Order_Quantity) AS Max_order, MAX(Unit_Cost) AS Max_unit_Cost, 
MAX(Unit_Price) AS Max_price, MAX(Profit) AS Max_profit, MAX(Cost) AS Max_cost,
MAX(Revenue) AS Max_revenue
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Product_Category

--minimum for order, unit cost price, profit, cost, and revenue in product category
SELECT MIN(Order_Quantity) AS Min_order, MIN(Unit_Cost) AS Min_unit_Cost, 
MIN(Unit_Price) AS Min_price, MIN(Profit) AS Min_profit, MIN(Cost) AS Min_cost,
MIN(Revenue) AS Min_revenue
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Product_Category

--average for order, unit cost price, profit, cost, and revenue in product category
SELECT CAST(AVG(Order_Quantity) AS int) AS Avg_order,
CAST(AVG(Unit_Cost) AS int) AS Avg_unit_Cost, 
CAST(AVG(Unit_Price) AS int) AS Avg_price,
CAST(AVG(Profit) AS int) AS Avg_profit, 
CAST(AVG(Cost) AS int) AS Avg_cost,
CAST(AVG(Revenue) AS int) AS Avg_revenue
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Product_Category

--highest profit for each country
SELECT Country, MAX(Profit) AS Highest_Profit_In_Country
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Country
ORDER BY Highest_Profit_In_Country DESC

--highest revenue for each country
SELECT Country, MAX(Revenue) AS Highest_Revenue_In_Country
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Country
ORDER BY Highest_Revenue_In_Country DESC

--lowest profit for each country
SELECT Country, MIN(Profit) AS Lowest_Profit_In_Country
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Country
ORDER BY Lowest_Profit_In_Country DESC

--lowest revenue for each country
SELECT Country, MIN(Revenue) AS Lowest_Revenue_In_Country
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Country
ORDER BY Lowest_Revenue_In_Country DESC

--Average profit for each country
SELECT Country, Format(AVG(Profit), '0.00') AS Avg_Profit_In_Country
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Country
ORDER BY Avg_Profit_In_Country DESC

--average revenue for each country
SELECT Country, Format(AVG(Revenue), '0.00') AS Highest_Revenue_In_Country
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Country
ORDER BY Highest_Revenue_In_Country DESC

--highest profit in each year
SELECT Year, MAX(Profit) AS Highest_Profit_In_years
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Year
ORDER BY Highest_Profit_In_years DESC

--lowest profit in each year
SELECT Year, MIN(Profit) AS Lowest_Profit_In_Years
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Year
ORDER BY Lowest_Profit_In_years DESC

--highest revenue in each year
SELECT Year, MAX(Revenue) AS Highest_Revenue_In_years
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Year
ORDER BY Highest_Revenue_In_years DESC

--lowest revenue in each year
SELECT Year, MIN(Revenue) AS Lowest_Revenue_In_years
FROM BikeStoreSales..BikeSalesInEurope
GROUP BY Year
ORDER BY Lowest_Revenue_In_years 






