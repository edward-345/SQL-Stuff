-- SQLite need comma after colnames
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
WHERE sepal_length >= 7.9;

-- Adding data into table, upon creation tables are empty
INSERT INTO Test (ID, S_LEN, S_WID, P_LEN, P_WID)
VALUES ("biggest", 7.9, 3.8, 6.4, 2);

SELECT * FROM Test;

-- Creating temp table, need to run all at once
CREATE TEMPORARY TABLE temp_test AS 
SELECT * FROM iris
WHERE petal_length >= 1.2;

SELECT * FROM temp_test;

-- Comment out chunks, the line below is a comment and wont run
/*
SELECT * FROM iris LIMIT 20;
*/

-- IN operator, specify a range of conditions, look for specific values
-- Returns sepal_length and sepal_width of rows in 'Iris-setosa'
-- More versatile, can select more conditions
-- NEED to include ()
SELECT sepal_length, sepal_width FROM iris
WHERE species IN ('Iris-setosa', 'Iris-versicolor');

-- OR operator, note if first cond is satisfied, will not check second
SELECT petal_length, petal_width FROM iris
WHERE petal_length > 5 OR petal_width > 5;

-- AND will always be processed first so () around OR 
SELECT * FROM iris
WHERE (petal_length > 5 OR petal_width > 5)
AND sepal_width >= 3.5;

-- Different from when using without ()
SELECT * FROM iris
WHERE petal_length > 5 OR petal_width > 5
AND sepal_width >= 3.5;

-- NOT operator
SELECT * FROM iris
WHERE species NOT IN ('Iris-Virginica');

-- Wildcard and LIKE operator
-- Selects all species that end with 'osa'
SELECT * FROM iris
WHERE species LIKE '%osa';

-- ORDER BY
-- sepal_length is sorted smallest to largest
SELECT * FROM iris
ORDER BY sepal_length;

-- sepal_length is sorted descending order
SELECT * FROM iris
ORDER BY sepal_length DESC;

-- Math operations, follows PEMDAS
-- Need to define a new column of result
SELECT sepal_length, sepal_width,
sepal_length * sepal_width AS sepal_dim
FROM iris;

-- AVG()
SELECT ROUND(AVG(sepal_length), 2) AS sepal_length_avg
FROM iris;

-- COUNT(*) Counts all rows in a table regardless of null
SELECT COUNT(*) FROM iris
AS total_flowers;

-- Counts nrows for a column ignores null
SELECT COUNT(petal_length) FROM iris
AS total_petals;

-- Can inculde DISTINCT
SELECT COUNT(DISTINCT petal_length) FROM iris
AS total_dist_petals;

-- MAX and MIN
SELECT MAX(petal_width) AS max_petal_width,
MIN(petal_width) AS min_petal_width
FROM iris;

-- SUM
SELECT SUM(petal_length) AS sum_petal_length
FROM iris;

-- GROUP BY
-- Gives the average of each grouped by species
SELECT species, 
AVG(sepal_length) AS avg_sepal_length
FROM iris
GROUP BY species;
-- if the SELECT species column is not defined, still runs but wont
-- give column showing what group it is from

-- HAVING does what WHERE does after 
-- GROUP BY within each group
-- Albums with 12 or more tracks
SELECT AlbumID,
COUNT(TrackID) AS nTracks
FROM Tracks
GROUP BY AlbumID
HAVING nTracks >= 12;
