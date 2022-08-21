--1. Write projection queries for your domain. ✅
--2. Write filtering queries (use is null logic, use like for nvarchar, combine predicates). ✅
--3. Use joining queries – inner join, outer joins. ✅
--4. Join more than two tables. ✅
--5. Use order by to get ordered result ✅



---------- 1 ----------

-- Projection, Where, Order By, Alias, Astericks, Top

SELECT TOP 3 * FROM cd_disks
WHERE Disk_price > 350

SELECT ID_disk, Disk_name, Disk_price FROM cd_disks
WHERE Disk_price < 130
ORDER BY Disk_price

SELECT e.ID_disk as IDs
FROM [cd_disks] as e

---------- 2 ----------

-- Not Null, Multiple Joins
SELECT tracks.Author_ID, Tracks_names, tracks.Genre_code, Genre_name FROM author_info
INNER JOIN tracks ON tracks.Author_ID = author_info.Author_ID
INNER JOIN genre ON genre.Genre_code = tracks.Genre_code
WHERE Genre_name IS NOT NULL

-- Like & Combine Predicates --

SELECT tracks.Genre_code, tracks.Track_name, genre.Genre_name FROM tracks
INNER JOIN genre ON genre.Genre_code = tracks.Genre_code
WHERE tracks.Track_name LIKE '[A-I]%' AND genre.Genre_code > 4
ORDER BY Genre_name

---------- 3 ----------

-- Inner Join

SELECT DISTINCT tracks.Track_ID, tracks.Track_name, tracks.Author_ID, tracks.Genre_code
FROM tracks
INNER JOIN author_info ON author_info.Author_ID = tracks.Author_ID
INNER JOIN genre ON genre.Genre_code = tracks.Genre_code
WHERE Genre_name = 'Jazz'

-- Outer Join


--LEFT JOIN--
SELECT tracks.Track_name, author_info.Author_full_name,author_info.Author_info
FROM tracks
LEFT JOIN author_info ON author_info.Author_ID = tracks.Author_ID
LEFT JOIN genre ON genre.Genre_code = tracks.Genre_code


--RIGHT JOIN--
SELECT genre.Genre_name, genre.Genre_description, tracks.Track_ID, author_info.Author_full_name
FROM genre
RIGHT OUTER JOIN tracks ON tracks.Genre_code = genre.Genre_code
RIGHT OUTER JOIN author_info ON author_info.Author_ID = tracks.Author_ID
ORDER BY Track_ID ASC



--FULL JOIN--
SELECT cd_disks.Disk_name, cd_disks.Disk_price, cd_collection.Track_number, (SELECT CAST(ROUND(100*Disk_price/(SELECT SUM(Disk_price) FROM cd_disks ), 2) AS NUMERIC(36,2))) AS Part
FROM cd_disks
FULL OUTER JOIN cd_collection ON cd_collection.ID_disk = cd_disks.ID_disk
ORDER BY Part DESC

---------- 4 (above) ----------
---------- 5 (above) ----------



