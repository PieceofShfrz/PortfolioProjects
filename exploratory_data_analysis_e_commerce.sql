/* ===============================
   DATA SUMMARY & VALIDATION
   =============================== */

-- Total records
SELECT COUNT(*) FROM e_commerce;

-- Check null values per column
SELECT 
  SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS null_invoice,
  SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS null_stock,
  SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS null_description,
  SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS null_invoice_date,
  SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS null_unitprice,
  SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customerid,
  SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS null_country
FROM e_commerce;


/* ===============================
   EXPLORATORY DATA ANALYSIS (EDA)
   =============================== */

-- 1. Sales trend by month
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
       ROUND(SUM(Quantity * UnitPrice), 2) AS MonthlyRevenue
FROM e_commerce
WHERE Quantity > 0
GROUP BY Month
ORDER BY Month;

-- 2. Sales trend by day
SELECT DATE(InvoiceDate) AS Date,
       ROUND(SUM(Quantity * UnitPrice), 2) AS DailyRevenue
FROM e_commerce
WHERE Quantity > 0
GROUP BY Date
ORDER BY Date;

-- 3. Best customers by total spending
SELECT CustomerID, ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSpendingCustomer
FROM e_commerce
WHERE CustomerID IS NOT NULL AND Quantity > 0
GROUP BY CustomerID
ORDER BY TotalSpendingCustomer DESC
LIMIT 5;

-- 4. Best customers by average transaction value
SELECT CustomerID, ROUND(AVG(Quantity * UnitPrice), 2) AS AvgSpendingTransaction
FROM e_commerce
WHERE CustomerID IS NOT NULL AND Quantity > 0
GROUP BY CustomerID
ORDER BY AvgSpendingTransaction DESC
LIMIT 5;

-- 5. Best selling products by total quantity sold
SELECT Description, SUM(Quantity) AS TotalSold
FROM e_commerce
WHERE Quantity > 0
GROUP BY Description
ORDER BY TotalSold DESC
LIMIT 5;

-- 6. Best selling products by revenue generated
SELECT Description, ROUND(SUM(Quantity * UnitPrice), 3) AS TotalRevenue
FROM e_commerce
WHERE Quantity > 0
GROUP BY Description
ORDER BY TotalRevenue DESC
LIMIT 5;

-- 7. Top 5 returned/refunded products
SELECT Description, ABS(SUM(Quantity)) AS TotalReturned
FROM e_commerce
WHERE Quantity < 0
GROUP BY Description
ORDER BY TotalReturned DESC
LIMIT 5;

-- 8. Top 5 customers with refunds
SELECT CustomerID, ABS(SUM(Quantity)) AS TotalReturned
FROM e_commerce
WHERE Quantity < 0 AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalReturned DESC
LIMIT 5;

-- 9. Return rate per product
SELECT Description,
       SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END) AS TotalSold,
       ABS(SUM(CASE WHEN Quantity < 0 THEN Quantity ELSE 0 END)) AS TotalReturned,
       ROUND((ABS(SUM(CASE WHEN Quantity < 0 THEN Quantity ELSE 0 END)) / NULLIF(SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END), 0)) * 100, 2) AS ReturnRatePercent
FROM e_commerce
WHERE Description IS NOT NULL
GROUP BY Description
HAVING TotalReturned > 0
ORDER BY ReturnRatePercent DESC
LIMIT 10;

-- 10. Return rate per customer
SELECT CustomerID,
       SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END) AS TotalPurchased,
       ABS(SUM(CASE WHEN Quantity < 0 THEN Quantity ELSE 0 END)) AS TotalReturned,
       ROUND((ABS(SUM(CASE WHEN Quantity < 0 THEN Quantity ELSE 0 END)) / NULLIF(SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END), 0)) * 100, 2) AS ReturnRatePercent
FROM e_commerce
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
HAVING TotalReturned > 0
ORDER BY ReturnRatePercent DESC
LIMIT 10;

-- 11. Distribution of product prices (per product)
SELECT Description,
       MIN(UnitPrice) AS MinPrice,
       MAX(UnitPrice) AS MaxPrice,
       AVG(UnitPrice) AS AvgPrice
FROM e_commerce
GROUP BY Description
ORDER BY AvgPrice DESC
LIMIT 5;

-- 12. Overall distribution of product prices
SELECT MIN(UnitPrice) AS MinPrice,
       MAX(UnitPrice) AS MaxPrice,
       AVG(UnitPrice) AS AvgPrice,
       COUNT(*) AS TotalItems
FROM e_commerce;

-- 13. Countries with most transactions
SELECT Country, COUNT(DISTINCT InvoiceNo) AS TotalTransactions
FROM e_commerce
GROUP BY Country
ORDER BY TotalTransactions DESC;

-- 14. Total customers per country
SELECT Country, COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM e_commerce
WHERE CustomerID IS NOT NULL
GROUP BY Country
ORDER BY TotalCustomers DESC;
