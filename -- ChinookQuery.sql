-- Check tables within Chinook DB
SELECT name 
FROM sqlite_master 
WHERE type='table'

-- Albums with 12 or more tracks
SELECT AlbumID,
COUNT(TrackID) AS nTracks
FROM Track
GROUP BY AlbumID
HAVING nTracks >= 12

----------------------------------------------------------------------
-- SUBQUERIES
----------------------------------------------------------------------
-- Subqueries are queries embedded inside other queries
-- Will always start with innermost query
SELECT * FROM Invoice
SELECT * FROM Customer

-- Return the names and id of customers who ordered from U countries
SELECT CustomerId, FirstName, LastName, Country
FROM Customer
WHERE Country IN (SELECT BillingCountry
                  FROM Invoice
                  WHERE BillingCountry LIKE 'U%')

-- Inner queries can only select one column
SELECT * FROM Playlist 
-- PlaylistId, Name
SELECT * FROM PlaylistTrack
-- PlaylistId, TrackID
SELECT * FROM Track
-- TrackId, UnitPrice

-- All playlists containg a track that starts with letter B
SELECT PlaylistId, Name 
FROM Playlist
WHERE PlaylistId IN (SELECT PlaylistId 
                     FROM PlaylistTrack
                     WHERE (TrackId in (SELECT TrackId
                                        FROM Track
                                        WHERE Name LIKE 'B%')))

-- Name and region and total number of orders for each
-- Subqueries involving calculations are different

-- Return total amount spent with customer info
SELECT 
CustomerId,
FirstName,
LastName,
(SELECT SUM(Total) AS TotalSpent
                     FROM Invoice
                     GROUP BY CustomerId) AS TotalSpent, 
Country 
FROM Customer

----------------------------------------------------------------------
-- JOINS
----------------------------------------------------------------------
/*Cartesian/Cross JOINS joins each row from the first table with
all the other rows of another. Does not match, only does said 
operation so only good for matrix math and finding combinations*/

SELECT EmployeeId, CustomerId
FROM Employee CROSS JOIN Customer

-- INNER JOIN selects records that have matching values in both tables
SELECT Playlist.PlaylistId,
Playlist.Name, PlaylistTrack.TrackId
FROM Playlist INNER JOIN PlaylistTrack
ON Playlist.PlaylistId = PlaylistTrack.PlaylistId

-- Can do the same thing but with aliases
SELECT pl.PlaylistId,
Name, TrackId
FROM Playlist AS pl, PlaylistTrack AS pt
WHERE pl.PlaylistId = pt.PlaylistId

-- SELF JOINs self explanatory
-- The || ' ' || used to concatenate strings with a space in between
SELECT 
e1.FirstName || ' ' || e1.LastName AS EmployeeName,
e2.FirstName || ' ' || e2.LastName AS ManagerName
FROM Employee e1
LEFT JOIN Employee e2
ON e1.ReportsTo = e2.EmployeeId
ORDER BY EmployeeName

-- sqlite is only capable of left joins..
-- LEFT JOIN