-- =========================================================================
-- queries.sql - my analysis
--
-- Project 1 | SQL: From Data to Insight
-- Team: Zoé Doucet
-- Dataset: The Global Impacts Dataset of Invasive Alien Species (GIDIAS)
--
-- This is a DELIVERABLE, graded on two things: the SQL, and what you wrote
-- underneath it. A query with no finding recorded is half an answer - in a
-- month you will not remember what it told you, and neither will whoever is
-- marking it.
--
-- Five queries minimum, each earning its place by answering a question you
-- wrote down in notebook 01. The aggregation should happen here, in SQL,
-- not in pandas after a SELECT *.
-- =========================================================================


-- =========================================================================
-- Research question 1 | When did invasive species introductions peak, 
--							and was there a period of rapid increase?
-- =========================================================================

-- =========================================================================
-- Q1 | How did the number of invasive species increase over time?
-- =========================================================================
-- Hypothesis: I think the number of invasive species is increasing rapidely,
--				with the rate of the increase becoming greater since the 2000s.
-- Finding:    The number of invasive species recorded increased steadily 
--				since 1600 to 2021. With more tahn 100 species recorded every year since 1998.

SELECT year_probability as "year", count(DISTINCT species_id) AS "species recorded"
FROM impact
WHERE year_probability is not NULL
GROUP BY year_probability
Order by year_probability ASC;

-- =========================================================================
-- Q2 | In which decade did the introduction of invasive species peak?
-- =========================================================================
-- Hypothesis: I think the introduction of invasive species peaked between 2010 and 2019.
-- Finding: The introduction of invasive species peaked between 2010 and 2019, with 1940 species recorded.

SELECT decade, max(number_species) as "species recorded"
FROM(
	SELECT(year_probability/10)*10 as decade, 
		   count(DISTINCT species_id) AS number_species
	FROM impact
WHERE year_probability is not NULL
GROUP BY decade);

-- =========================================================================
-- Research question 2 | Which region and countries are the most affected 
-- 							by invasive species?
-- =========================================================================

-- =========================================================================
-- Q3 | Which region is most affected by invasive species?
-- =========================================================================
-- Hypothesis: I think Africa is the most affected by invasive species.
-- Finding: The region most affected by invasive species is Europe and central Asia

SELECT l.region,  count(DISTINCT i.species_id) AS "species recorded"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
GROUP BY l.region
ORDER BY "species recorded" DESC;


-- =========================================================================
-- Q4 |Which are the 10 countries most affected by invasive species?
-- =========================================================================
-- Hypothesis: I think the 10 most affected countrys are Spain, Kenya, Brazil, the USA and Indonesia.
-- Finding:

SELECT l.country_location as country,  count(DISTINCT i.species_id) AS "species recorded"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
WHERE country is not NULL
WHERE country LIKE 
GROUP BY country
ORDER BY "species recorded" DESC;


SELECT l.country_location as country,  count(DISTINCT i.species_id) AS "species recorded"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
WHERE country LIKE '%USA%'
GROUP BY country;

-- =========================================================================
-- Research question 3 | Which invasive species has the greater impact?
-- =========================================================================


-- =========================================================================
-- Q5 | Which kingdom has the greater impact on nature? 
-- =========================================================================
-- Hypothesis: 
-- Finding:

-- =========================================================================
-- Q6 | Which kingdom has the greater impact on peoples activitys? 
-- =========================================================================
-- Hypothesis: 
-- Finding:

-- =========================================================================
-- Q7 | Which are the 10 species that have the greatest impact on nature? 
-- =========================================================================
-- Hypothesis: 
-- Finding:

-- =========================================================================
-- Q8 | Which are the 10 species that have the greatest impact on peoples activitys? 
-- =========================================================================
-- Hypothesis: 
-- Finding: