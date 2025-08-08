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

-- Subqueries are queries embedded inside other queries