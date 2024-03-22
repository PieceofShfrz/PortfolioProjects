SELECT *
FROM SalesReport

--Total per customer
Select  FixedCustomer, COUNT(FixedCustomer) AS TotalPerCustomer
FROM SalesReport
WHERE FixedCustomer is not null
GROUP BY  FixedCustomer
ORDER BY TotalPerCustomer DESC

--Total per style
Select FixedStyle, COUNT(FixedStyle) AS TotalPerStyle
FROM SalesReport
WHERE FixedStyle is not null
GROUP BY FixedStyle
ORDER BY TotalPerStyle DESC

--Total per skucode
Select SkuCode, COUNT(SkuCode) AS TotalPerSkuCode
FROM SalesReport
WHERE SkuCode is not null
GROUP BY SkuCode
ORDER BY TotalPerSkuCode DESC

--Total per skusize
Select SkuSize, COUNT(SkuSize) AS TotalPerSkuSize
FROM SalesReport
WHERE SkuSize is not null
GROUP BY SkuSize
ORDER BY TotalPerSkuSize DESC

--Total style by date
Select SaleDateConverted, COUNT(FixedStyle) AS TotalStyleDate
FROM SalesReport
WHERE SaleDateConverted is not null
GROUP BY SaleDateConverted
ORDER BY TotalStyleDate DESC

--Total size by date
Select SaleDateConverted, SkuSize, COUNT(SkuSize) AS TotalSizeDate
FROM SalesReport
WHERE SaleDateConverted is not null
GROUP BY SaleDateConverted, SkuSize
ORDER BY TotalSizeDate DESC

--changing numerical to descriptive months
SELECT SaleMonthsConverted
FROM SalesReport
GROUP BY SaleMonthsConverted

SELECT SaleMonthsConverted,
CASE
	WHEN SaleMonthsConverted = '01' THEN 'January'
	WHEN SaleMonthsConverted = '02' THEN 'February'
	WHEN SaleMonthsConverted = '03' THEN 'March'
	WHEN SaleMonthsConverted = '04' THEN 'April'
	WHEN SaleMonthsConverted = '05' THEN 'May'
	WHEN SaleMonthsConverted = '06' THEN 'June'
	WHEN SaleMonthsConverted = '07' THEN 'July'
	WHEN SaleMonthsConverted = '08' THEN 'August'
	WHEN SaleMonthsConverted = '09' THEN 'September'
	WHEN SaleMonthsConverted = '10' THEN 'October'
	WHEN SaleMonthsConverted = '11' THEN 'November'
	WHEN SaleMonthsConverted = '12' THEN 'December'
	ELSE SaleMonthsConverted
	END 
FROM SalesReport

UPDATE SalesReport
set SaleMonthsConverted = CASE
	WHEN SaleMonthsConverted = '01' THEN 'January'
	WHEN SaleMonthsConverted = '02' THEN 'February'
	WHEN SaleMonthsConverted = '03' THEN 'March'
	WHEN SaleMonthsConverted = '04' THEN 'April'
	WHEN SaleMonthsConverted = '05' THEN 'May'
	WHEN SaleMonthsConverted = '06' THEN 'June'
	WHEN SaleMonthsConverted = '07' THEN 'July'
	WHEN SaleMonthsConverted = '08' THEN 'August'
	WHEN SaleMonthsConverted = '09' THEN 'September'
	WHEN SaleMonthsConverted = '10' THEN 'October'
	WHEN SaleMonthsConverted = '11' THEN 'November'
	WHEN SaleMonthsConverted = '12' THEN 'December'
	ELSE SaleMonthsConverted
	END 

--Total style by Months
Select SaleMonthsConverted, SkuSize, COUNT(SkuSize) AS TotalSizeMonths
FROM SalesReport
WHERE SaleMonthsConverted is not null
GROUP BY SaleMonthsConverted, SkuSize
ORDER BY TotalSizeMonths DESC





