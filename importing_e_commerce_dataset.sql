/* 
importing e-commerce_dataset using load data local infile to make it fast because data import
wizard is slow and usually cause an error
*/

-- Creating another table using CREATE TABLE LIKE
CREATE TABLE e_commerce_dataset_4
LIKE e_commerce_dataset_3;

-- Check if the table has been made with the same columns
SELECT *
FROM e_commerce_dataset_4;

-- Loading e-commerce data using local infile (541.909)
show variables like "local_infile";

set global local_infile = 1;

LOAD DATA LOCAL INFILE 'D:/Knowledge/Programming/Data analysis/Files/project 1 e-commerce/e_commerce_dataset_3.csv'
INTO TABLE e_commerce_dataset_4
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SHOW WARNINGS;


