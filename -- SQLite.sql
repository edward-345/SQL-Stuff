-- SQLite
SELECT * FROM iris LIMIT 10;

-- Creating a new table
CREATE TABLE Test
(
ID      char(10)        PRIMARY KEY,
S_LEN   decimal(4,4)    NOT NULL,
S_WID   decimal(4,4)    NOT NULL,
P_LEN   decimal(4,4)    NOT NULL,
P_WID   decimal(4,4)    NOT NULL);

-- Selecting certain entities(rows) based on chars
SELECT * FROM iris
WHERE sepal_length >= 7.9

-- Adding data into table, upon creation tables are empty
INSERT INTO Test (ID, S_LEN, S_WID, P_LEN, P_WID)
VALUES ("biggest", 7.9, 3.8, 6.4, 2);

SELECT * FROM Test

-- Creating temp table, need to run all at once
CREATE TEMPORARY TABLE temp_test AS 
SELECT * FROM iris
WHERE petal_length >= 1.2;

SELECT * FROM temp_test;

-- Comment out chunks, the line below is a comment and wont run
/*
SELECT * FROM iris LIMIT 20;
*/