-- Moses Permaul
-- CUNY School of Professional Studies, 
-- IS 362 - Assignment 1
-- Professor Pak

-- 1a). How many airplanes have listed speeds? 
-- 1b). What is the minimum listed speed and the maximum listed speed?

-- There are 23 airplanes that have a listed speed in the planes table.
SELECT COUNT(*) FROM planes where speed > 0;

-- The minimum listed speed is 90 and the maximum is 432.
SELECT MIN(speed) FROM planes;
SELECT MAX(speed) FROM planes;

-- 2a. What is the total distance flown by all of the planes in January 2013?
-- 2b. What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

-- The total distance flown by all planes in January 2013 is 27,188,805.
SELECT SUM(distance) FROM flights where year = 2013 and month = 1;

-- The total distance flown by all planes in January 2013 where the tailnum was missing is 81,763.
SELECT SUM(distance) FROM flights WHERE year = 2013 AND month = 1 AND (tailnum IS NULL OR tailnum = '');

-- 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?
-- Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?

-- The following query uses an INNER JOIN on the flights and planes table.
-- The manufacturer from the planes table and the sum of the distances of their planes flown on July 5, 2013 is displayed.
-- The query specifically uses the data for flights on July 5, 2013 and orders the display by manufacturer.

SELECT 
	p.manufacturer, 
    SUM(f.distance)
FROM flights f
INNER JOIN planes p ON f.tailnum = p.tailnum
WHERE 
	f.month = 7 
    AND f.day = 5 
    AND f.year = 2013
GROUP BY p.manufacturer
ORDER BY p.manufacturer;

-- The following query uses an LEFT OUTER JOIN on the flights and planes table.

SELECT 
	p.manufacturer, 
    SUM(f.distance)
FROM flights f
LEFT OUTER JOIN planes p ON f.tailnum = p.tailnum
WHERE 
	f.month = 7 
    AND f.day = 5 
    AND f.year = 2013
GROUP BY p.manufacturer
ORDER BY p.manufacturer;

-- The results are very similar, however, the query using the LEFT OUTER JOIN also takes into consideration flights
-- that did not have a manufacturer listed. This is seen in the first row where manufacturer is NULL/blank.

-- 4. Write and answer at least one question of your own choosing that joins information from at least 
-- three of the tables in the flights database. 

-- Question: 
	-- How many flights did each manufacturer make on July 5, 2013 out of each airport?

-- Answer: 
	-- Using the flights, airports, and planes table, I'm selecting the manufacturer's name, the airport name, and a count of the flights.
    -- Using INNER JOINS, since I only want actual manufacturers, I make the connection between the flights origin field and the airports faa code.alter  
	-- Using a sencond INNER JOIN, I make the connection between the flights and planes tailnum in order to link the manufacturer to each flight.
	-- The data is then grouped and ordered by manufacturer and airport 

SELECT
	b.manufacturer,
	a.name AS 'airport name',
    COUNT(*) AS 'number of flights'
FROM flights f
INNER JOIN airports a ON f.origin = a.faa
INNER JOIN planes b ON b.tailnum = f.tailnum
WHERE
	f.year = 2013
	AND f.month = 7
    AND f.day = 5
GROUP BY b.manufacturer, a.name
ORDER BY b.manufacturer, a.name;

