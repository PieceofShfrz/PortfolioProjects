SELECT *
FROM amazonsalereport;

CREATE TABLE amazonsalereport1
LIKE amazonsalereport;

INSERT amazonsalereport1
SELECT *
FROM amazonsalereport;

-- Remove Duplicate
SELECT *,
ROW_NUMBER () OVER (PARTITION BY 
 `Order ID`, `Date`, `Status`, `Fulfilment`, `Sales Channel`,
 `ship-service-level`, `Style`, `SKU`, `Category`, `Size`, `ASIN`,
 `Courier Status`, `Qty`, `currency`, `Amount`, `ship-city`, `ship-state`, 
 `ship-postal-code`, `ship-country`, `promotion-ids`, `B2B`, `fulfilled-by`)
 AS row_num
 FROM amazonsalereport1;
 
 with duplicate_cte AS 
 (
 SELECT *,
ROW_NUMBER () OVER (PARTITION BY `index`,
 `Order ID`, `Date`, `Status`, `Fulfilment`, `Sales Channel`,
 `ship-service-level`, `Style`, `SKU`, `Category`, `Size`, `ASIN`,
 `Courier Status`, `Qty`, `currency`, `Amount`, `ship-city`, `ship-state`, 
 `ship-postal-code`, `ship-country`, `promotion-ids`, `B2B`, `fulfilled-by`, `Unnamed: 22`)
 AS row_num
 FROM amazonsalereport1
 )
 SELECT *
 FROM duplicate_cte
 WHERE row_num > 1;
 

 -- Standardize The Data
 SELECT `Date`,
  str_to_date(`Date`, '%m-%d-%Y')
 FROM amazonsalereport1;
 
 UPDATE amazonsalereport1
 SET `Date` = str_to_date(`Date`, '%m-%d-%Y');
 
 SELECT *
 FROM amazonsalereport1;

SELECT DISTINCT `ship-city`, TRIM(TRAILING '.' FROM `ship-city`)
FROM amazonsalereport1
WHERE `ship-city` LIKE 'Amravati%';

UPDATE amazonsalereport1
SET `ship-city` = TRIM(TRAILING '.' FROM `ship-city`)
WHERE `ship-city` LIKE 'Amravati%';

-- null values or blank values
SELECT  DISTINCT `currency`
FROM amazonsalereport1
WHERE `Qty` IS NULL OR 
 `Qty` = '';
 
 UPDATE amazonsalereport1
 SET `Courier Status` = null
 WHERE `Courier Status` = '';
 
 SELECT DISTINCT *
FROM amazonsalereport1
WHERE `ship-city` LIKE 'GUWA%';

UPDATE amazonsalereport1
SET `ship-city` = 'GUWAHATI'
WHERE `ship-city` = 'GUWAHATI, KAMRUP (M)';

 SELECT DISTINCT `ship-city` 
FROM amazonsalereport1
ORDER BY 1;

 SELECT *
FROM amazonsalereport1
WHERE `ship-city` LIKE 'KOLKATA 700034%';

UPDATE amazonsalereport1
SET `ship-city` = 'KOLKATA'
WHERE `ship-city` LIKE 'KOLKATA 700034';

SELECT `ship-city`, UPPER(`ship-city`)
FROM amazonsalereport1;

UPDATE amazonsalereport1
SET `ship-city` = UPPER(`ship-city`);

SELECT *
FROM  amazonsalereport1;

SELECT DISTINCT `ship-state`, UPPER(`ship-state`)
FROM  amazonsalereport1;

UPDATE amazonsalereport1
SET `ship-state` = UPPER(`ship-state`);

 SELECT `B2B`
 FROM amazonsalereport1
 WHERE `B2B` IS NULL OR
 `B2B` = '';
 
 SELECT DISTINCT `promotion-ids`
FROM amazonsalereport1;

UPDATE amazonsalereport1
SET `promotion-ids` =  NULL 
WHERE `promotion-ids` = '';

SELECT *
FROM  amazonsalereport1;

SELECT DISTINCT `fulfilled-by`
FROM amazonsalereport1;

UPDATE amazonsalereport1
SET `fulfilled-by` = NULL
WHERE `fulfilled-by` = '';

SELECT `Amount`, ROUND(`Amount`, 0)
FROM amazonsalereport1;

UPDATE amazonsalereport1
SET `Amount` = ROUND(`Amount`, 0);


-- Delete Unused Columns
ALTER TABLE amazonsalereport1
DROP COLUMN `Unnamed: 22`;

ALTER TABLE amazonsalereport1
DROP COLUMN `fulfilled-by`;

ALTER TABLE amazonsalereport1
DROP COLUMN B2B;

ALTER TABLE amazonsalereport1
DROP COLUMN `promotion-ids`;

ALTER TABLE amazonsalereport1
DROP COLUMN `ship-country`;

 ALTER TABLE amazonsalereport1
 DROP COLUMN `index`;
 
SELECT *
FROM amazonsalereport1;

