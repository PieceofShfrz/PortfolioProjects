-- Step 1: Initial View and Count
SELECT * FROM e_commerce_dataset_4;
SELECT COUNT(*) FROM e_commerce_dataset_4;

-- Step 2: Remove Duplicates
CREATE TABLE e_commerce_dataset_5 LIKE e_commerce_dataset_4;
INSERT INTO e_commerce_dataset_5
SELECT * FROM e_commerce_dataset_4;

-- Check for Duplicates
WITH duplicate_cte AS (
  SELECT *, 
         ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Description, Quantity, InvoiceDate, 
                                        UnitPrice, CustomerID, Country) AS row_num
  FROM e_commerce_dataset_5
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Create Clean Table and Remove Duplicates
CREATE TABLE e_commerce_dataset_cleaned (
  InvoiceNo TEXT,
  StockCode TEXT,
  Description TEXT,
  Quantity INT DEFAULT NULL,
  InvoiceDate TEXT,
  UnitPrice DOUBLE DEFAULT NULL,
  CustomerID TEXT,
  Country TEXT,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO e_commerce_dataset_cleaned
SELECT *, 
       ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Description, Quantity, InvoiceDate, 
                                  UnitPrice, CustomerID, Country) AS row_num
FROM e_commerce_dataset_5;

DELETE FROM e_commerce_dataset_cleaned WHERE row_num > 1;

-- Step 3: Standardize Data
-- Trim InvoiceNo
UPDATE e_commerce_dataset_cleaned SET InvoiceNo = TRIM(InvoiceNo);
-- Trim StockCode
UPDATE e_commerce_dataset_cleaned SET StockCode = TRIM(StockCode);

-- Identify Non-Product StockCodes
UPDATE e_commerce_dataset_cleaned SET IsProduct = 0 WHERE StockCode IN (
  'POST','M','B','D','BANK CHARGES','AMAZONFEE','S','CRUK','C2','DOT'
);
UPDATE e_commerce_dataset_cleaned SET IsProduct = 0 WHERE StockCode LIKE '%gift%';
UPDATE e_commerce_dataset_cleaned SET IsProduct = 0 
WHERE StockCode LIKE '%DCGS%' AND StockCode IN ('DCGS0073','DCGS0071','DCGS0070','DCGS0069','DCGS0068','DCGS0067','DCGS0066P','DCGS0003','DCGS0055','DCGS0072','DCGS0074','DCGS0057');
UPDATE e_commerce_dataset_cleaned SET IsProduct = 1 WHERE IsProduct IS NULL;

-- Standardize Description
UPDATE e_commerce_dataset_cleaned
SET Description = UPPER(TRIM(REPLACE(REPLACE(REPLACE(Description, '+', ' AND '), '�', ''), '.', '')));

-- Correct Specific Descriptions
UPDATE e_commerce_dataset_cleaned SET Description = 'FLOWER GLASS GARLAND NECKL.36" TURQUOISE' WHERE Description = 'FLOWER GLASS GARLD NECKL36"TURQUOIS';
UPDATE e_commerce_dataset_cleaned SET Description = 'FLOWER GLASS GARLAND NECKL.36" AMETHYST' WHERE Description = 'FLOWER GLASS GARLD NECKL36"AMETHYST';
UPDATE e_commerce_dataset_cleaned SET Description = 'FLOWER GLASS GARLAND NECKL.36" BLACK' WHERE Description = 'FLOWER GLASS GARLAND NECKL.36"BLACK';
UPDATE e_commerce_dataset_cleaned SET Description = 'FLOWER GLASS GARLAND NECKL.36" BLUE' WHERE Description = 'FLOWER GLASS GARLAND NECKL.36"BLUE';
UPDATE e_commerce_dataset_cleaned SET Description = 'FLOWER GLASS GARLAND NECKL.36" GREEN' WHERE Description = 'FLOWER GLASS GARLAND NECKL.36"GREEN';

-- Parse InvoiceDate
UPDATE e_commerce_dataset_cleaned SET InvoiceDate = TRIM(InvoiceDate);
UPDATE e_commerce_dataset_cleaned SET InvoiceDate = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');
ALTER TABLE e_commerce_dataset_cleaned MODIFY COLUMN InvoiceDate DATETIME;

-- Clean CustomerID
UPDATE e_commerce_dataset_cleaned SET CustomerID = TRIM(CustomerID);
UPDATE e_commerce_dataset_cleaned SET CustomerID = NULL WHERE CustomerID = '';

-- Clean Description if Blank
UPDATE e_commerce_dataset_cleaned SET Description = NULL WHERE Description = '';

-- Clean Country Column
UPDATE e_commerce_dataset_cleaned SET Country = TRIM(REPLACE(Country, CHAR(13), ''));
UPDATE e_commerce_dataset_cleaned SET Country = TRIM(Country);
UPDATE e_commerce_dataset_cleaned SET Country = 'Ireland' WHERE Country LIKE '%EIRE%';
UPDATE e_commerce_dataset_cleaned SET Country = 'European Union' WHERE Country = 'European Community';
UPDATE e_commerce_dataset_cleaned SET Country = 'South Africa' WHERE Country = 'RSA';
UPDATE e_commerce_dataset_cleaned SET Country = 'United States' WHERE Country = 'USA';

-- Step 4: Outlier Detection
ALTER TABLE e_commerce_dataset_cleaned ADD COLUMN Outlier_Flag VARCHAR(10);
UPDATE e_commerce_dataset_cleaned SET Outlier_Flag = CASE 
  WHEN ABS((Quantity - 9.62) / 219.13) > 3.95 THEN 'Outlier'
  ELSE 'Normal'
END;

-- Step 5: Create Final Filtered Table\CREATE TABLE e_commerce LIKE e_commerce_dataset_cleaned;
INSERT INTO e_commerce
SELECT * FROM e_commerce_dataset_cleaned
WHERE IsProduct = 1 AND Outlier_Flag = 'Normal' AND UnitPrice > 0;

-- Step 6: Remove Helper Columns
ALTER TABLE e_commerce
DROP COLUMN row_num,
DROP COLUMN IsProduct,
DROP COLUMN Outlier_Flag;
