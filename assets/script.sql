--top 5 stadiums by capacity --
SELECT top 5 rank, stadium, capacity
FROM stadiums
ORDER BY capacity DESC

-- average capacity by region --
SELECT region, AVG(capacity) as avg_capacity
FROM stadiums
GROUP BY region
ORDER BY avg_capacity DESC;

--count of stadiums in each country--
SELECT country, count(country) stadium_count
FROM stadiums
GROUP BY country
ORDER BY stadium_count desc, country asc

--stadium ranking within each region--
SELECT rank, stadium, region,
    RANK() OVER(PARTITION BY region ORDER BY capacity DESC) as region_rank
FROM stadiums;

--top 3 stadium ranking within each region--
SELECT rank, stadium, region, capacity, region_rank
FROM (
    SELECT rank, stadium, region, capacity,
           RANK() OVER (PARTITION BY region ORDER BY capacity DESC) as region_rank
    FROM stadiums
) ranked_stadiums
WHERE region_rank <= 3;

-- stadiums with capacity above average --
SELECT stadium, t2.region, capacity, avg_capacity
FROM stadiums, (SELECT region, AVG(capacity) avg_capacity FROM stadiums GROUP BY region) t2
WHERE t2.region = stadiums.region
and capacity > avg_capacity
ORDER BY region

--stadiums with the closest capacity to regional median--
WITH MedianCTE AS (
    SELECT
        region, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY capacity) OVER (PARTITION BY region) AS median_capacity
    FROM stadiums
)
SELECT rank, stadium, region, capacity, ranked_stadiums.median_rank
FROM (
    SELECT
        s.rank, s.stadium, s.region, s.capacity,
        ROW_NUMBER() OVER (PARTITION BY s.region ORDER BY ABS(s.capacity - m.median_capacity)) AS median_rank
    FROM stadiums s JOIN MedianCTE m ON s.region = m.region
) ranked_stadiums
WHERE median_rank = 1;


--Queries added by Rafael Vera-Maranon 


--standard deviation of capacity by region
SELECT region, STDEV(capacity) AS std_dev_capacity
FROM stadiums
GROUP BY region
ORDER BY std_dev_capacity DESC;

--Max/Min capacity comparison by Country
SELECT country, MAX(capacity) AS max_capacity, MIN(capacity) AS min_capacity, (MAX(capacity) - MIN(capacity)) AS capacity_range
FROM stadiums
GROUP BY country
ORDER BY capacity_range DESC;

-stadiums above percentile 75 of capacity
WITH CapacityPercentiles AS (
    SELECT 
        stadium, 
        capacity,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY capacity) OVER () AS P75Capacity
    FROM stadiums
)
SELECT 
    stadium, 
    capacity,
    P75Capacity,
    capacity - P75Capacity AS AboveP75
FROM CapacityPercentiles
WHERE capacity > P75Capacity;

--correlation between stadiums capacity and attendance number to a certain event. (aditional information needed)(not able to be used wiht our current data)
SELECT stadiums.stadium, capacity, AVG(attendance) AS avg_attendance, COUNT(event_id) AS event_count
FROM stadiums
JOIN events ON stadiums.stadium = events.stadium_name
GROUP BY stadiums.stadium, capacity
ORDER BY capacity DESC;