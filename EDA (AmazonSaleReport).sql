-- Total Count Per Category
SELECT Category, COUNT(Category) AS TotalPerCategory
FROM amazonsalereport1
GROUP BY Category;

-- Calculate Overall Total per Category using Subquery
WITH Sum_Size AS 
(
SELECT Category, COUNT(Category) AS TotalPerCategory
FROM amazonsalereport1
GROUP BY Category
)
SELECT SUM(TotalPerCategory) AS Total_All_Category
FROM Sum_Size;

SELECT *
FROM amazonsalereport1;

-- Count and Sort Total per Status
SELECT `Status`, COUNT(*) AS Total_Status
FROM amazonsalereport1
GROUP BY `Status`
ORDER BY Total_Status DESC;

-- Count and Sort Total by Size
SELECT Size, COUNT(*) AS Total_Size
FROM amazonsalereport1
GROUP BY Size
ORDER BY Total_Size DESC;

-- Count and Sort Total by Style
SELECT Style, COUNT(*) AS Total_Style
FROM amazonsalereport1
GROUP BY Style
ORDER BY Total_Style DESC;

-- Calculate Total Sales per Category
SELECT Category, SUM(Amount) AS Total_Sales
FROM amazonsalereport1
GROUP BY Category;

-- Calculate Sum of Total and Average Sales per Category 
WITH Avg_Total_Sales AS
(
SELECT Category, SUM(Amount) AS Total_Sales
FROM amazonsalereport1
GROUP BY Category
)
SELECT Category, Total_Sales,
 SUM(Total_Sales) OVER() AS Sum_of_Total_Sales,
 AVG(Total_Sales) OVER () AS Avg_of_Total_Sales
FROM Avg_Total_Sales;

SELECT `ship-city`, COUNT(`ship-city`) AS The_Most_City
FROM amazonsalereport1
GROUP BY `ship-city`
ORDER BY  The_Most_City DESC;

SELECT `ship-state`, COUNT(`ship-state`) AS The_Most_State
FROM amazonsalereport1
GROUP BY `ship-state`
ORDER BY  The_Most_State DESC;


