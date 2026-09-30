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
-- Q4 |Which are the 5 countries most affected by invasive species?
-- =========================================================================
-- Hypothesis: I think the 5 most affected countrys are Spain, Kenya, Brazil, the USA and Indonesia.
-- Finding: The five most affected countries are the USA, Japan, Ecuador, Spain and South Africa.

SELECT l.country_location as country,  count(DISTINCT i.species_id) AS "species recorded"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
WHERE country is not NULL
GROUP BY country
ORDER BY "species recorded" DESC;

SELECT CASE
        WHEN l.country_location LIKE '%USA%' THEN 'USA'
        WHEN l.country_location LIKE '%Japan%' THEN 'Japan'
        WHEN l.country_location LIKE '%Ecuador%' THEN 'Ecuador'
        WHEN l.country_location LIKE '%South Africa%' THEN 'South Africa'
        WHEN l.country_location LIKE '%Spain%' THEN 'Spain'
    END AS country,
    COUNT(DISTINCT i.species_id) AS "species recorded"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
WHERE country LIKE '%USA%'
 OR country LIKE '%Japan%'
  OR country LIKE '%Ecuador%'
   OR country LIKE '%South Africa%'
    OR country LIKE '%Spain%'
GROUP BY country
ORDER BY "species recorded" DESC;



-- =========================================================================
-- Research question 3 | Which invasive species has the greater impact?
-- =========================================================================


-- =========================================================================
-- Q5 | Which kingdom has the greater impact on nature? 
-- =========================================================================
-- Hypothesis: I think the species from the kingdom Plantea have the greatest impact on nature.
-- Finding: The species from the kingdom animalia have the greatest impact on nature.

SELECT s.kingdom, 
		count(DISTINCT 
				CASE WHEN i.magnitude_nature = 3 THEN i.species_id END) AS "magnitude 3",
		count(DISTINCT 
				CASE WHEN i.magnitude_nature = 2 THEN i.species_id END) AS "magnitude 2",
		count(DISTINCT 
				CASE WHEN i.magnitude_nature = 1 THEN i.species_id END) AS "magnitude 1",
		count(DISTINCT 
				CASE WHEN i.magnitude_nature = 0 THEN i.species_id END) AS "magnitude 0"
FROM impact as i
	INNER JOIN species as s
	on i.species_id = s.species_id
WHERE s.kingdom is not NULL AND i.magnitude_nature is not NULL
GROUP BY s.kingdom
ORDER BY "magnitude 3" DESC,
		"magnitude 2" DESC,
		"magnitude 1" DESC;
				

-- =========================================================================
-- Q6 | Which kingdom has the greater impact on peoples activities? 
-- =========================================================================
-- Hypothesis: I think the species from the kingdom animalia have the greatest impact on peoples activities.
-- Finding: The species from the kingdom animalia have the greatest impact on peoples activities.

SELECT s.kingdom, 
		count(DISTINCT 
				CASE WHEN i.magnitude_cwb = 3 THEN i.species_id END) AS "magnitude 3",
		count(DISTINCT 
				CASE WHEN i.magnitude_cwb = 2 THEN i.species_id END) AS "magnitude 2",
		count(DISTINCT 
				CASE WHEN i.magnitude_cwb = 1 THEN i.species_id END) AS "magnitude 1",
		count(DISTINCT 
				CASE WHEN i.magnitude_cwb = 0 THEN i.species_id END) AS "magnitude 0",
		count(DISTINCT 
				CASE WHEN i.magnitude_cwb = "positive" THEN i.species_id END) AS "positive impact"
FROM impact as i
	INNER JOIN species as s
	on i.species_id = s.species_id
WHERE s.kingdom is not NULL AND i.magnitude_cwb is not NULL
GROUP BY s.kingdom
ORDER BY "magnitude 3" DESC,
		"magnitude 2" DESC,
		"magnitude 1" DESC;

-- =========================================================================
-- Q7 | Which are the 3 species family from the animalia kingdom that have the greatest impact on nature
--		in the five most affected countries? 
-- =========================================================================
-- Hypothesis: The species with the most impact on nature will be for all countries formicidae, muridae and salmonidae.
-- Finding: The most impactinct species familie for Ecuador are formicidae, muridae and bovidae
-- for Japan fomicidae, suidae and serpulidae
-- for South Africa salmonidae, mytilidae and centrarchidae
-- for Spain it is formidae, colubridae and muridae
-- for the USA it is fomicidae spiraxidae and scorpaenidae.

SELECT 
	CASE
        WHEN l.country_location LIKE '%USA%' THEN 'USA'
        WHEN l.country_location LIKE '%Japan%' THEN 'Japan'
        WHEN l.country_location LIKE '%Ecuador%' THEN 'Ecuador'
        WHEN l.country_location LIKE '%South Africa%' THEN 'South Africa'
        WHEN l.country_location LIKE '%Spain%' THEN 'Spain'
    END AS country,
	s.family,
		count(DISTINCT i.species_id) as  "magnitude 3"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
	INNER JOIN species as s
		ON i.species_id = s.species_id
WHERE s.kingdom = "Animalia"
	and i.magnitude_nature = "3"
	and (l.country_location LIKE '%USA%'
		 OR l.country_location LIKE '%Japan%'
		  OR l.country_location LIKE '%Ecuador%'
		   OR l.country_location LIKE '%South Africa%'
			OR l.country_location LIKE '%Spain%')
GROUP BY country, s.family
ORDER BY country, "magnitude 3" DESC;


-- =========================================================================
-- Q8 | Which are the 3 species family from the animalia kingdom that have the greatest impact on peoples activities
--		in the five most affected countries?  
-- =========================================================================
-- Hypothesis:  The species with the most impact on nature will be for all countries formicidae, muridae and salmonidae.
-- Finding: Only the USA and South Africa reported species from the animal Kingdom impacting peoples activities.
-- For South Africa it is on species from the  corvidae family, for the USA it in one species from the fomicidaeand one from the buprestidae family.

SELECT 
	CASE
        WHEN l.country_location LIKE '%USA%' THEN 'USA'
        WHEN l.country_location LIKE '%Japan%' THEN 'Japan'
        WHEN l.country_location LIKE '%Ecuador%' THEN 'Ecuador'
        WHEN l.country_location LIKE '%South Africa%' THEN 'South Africa'
        WHEN l.country_location LIKE '%Spain%' THEN 'Spain'
    END AS country,
	s.family,
		count(DISTINCT i.species_id) as  "magnitude 3"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
	INNER JOIN species as s
		ON i.species_id = s.species_id
WHERE s.kingdom = "Animalia"
	and i.magnitude_cwb = "3"
	and (l.country_location LIKE '%USA%'
		 OR l.country_location LIKE '%Japan%'
		  OR l.country_location LIKE '%Ecuador%'
		   OR l.country_location LIKE '%South Africa%'
			OR l.country_location LIKE '%Spain%')
GROUP BY country, s.family
ORDER BY country, "magnitude 3" DESC;

-- =========================================================================
-- Q9 | Which are the 3 species family from the plantea kingdom that have the greatest impact on nature
--		in the five most affected countries? 
-- =========================================================================
-- Hypothesis: The species with the most impact on nature will be for all countries solanacea, aracea and fabacea.
-- Finding: The most impactinct species familie for Ecuador are solanacea and meliacea
-- for Japan Pontederiaceae, Moraceae and Hydrocharitaceae
-- for South Africa Salviniaceae, Pontederiaceae and Pinaceae
-- for Spain it is Rhodomelaceae and Poaceae
-- for the USA it is Poaceae, Hydrocharitaceae and Typhaceae.

SELECT 
	CASE
        WHEN l.country_location LIKE '%USA%' THEN 'USA'
        WHEN l.country_location LIKE '%Japan%' THEN 'Japan'
        WHEN l.country_location LIKE '%Ecuador%' THEN 'Ecuador'
        WHEN l.country_location LIKE '%South Africa%' THEN 'South Africa'
        WHEN l.country_location LIKE '%Spain%' THEN 'Spain'
    END AS country,
	s.family,
		count(DISTINCT i.species_id) as  "magnitude 3"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
	INNER JOIN species as s
		ON i.species_id = s.species_id
WHERE s.kingdom = "Plantae"
	and i.magnitude_nature = "3"
	and (l.country_location LIKE '%USA%'
		 OR l.country_location LIKE '%Japan%'
		  OR l.country_location LIKE '%Ecuador%'
		   OR l.country_location LIKE '%South Africa%'
			OR l.country_location LIKE '%Spain%')
GROUP BY country, s.family
ORDER BY country, "magnitude 3" DESC;


-- =========================================================================
-- Q10 | Which are the 3 species family from the plantea kingdom that have the greatest impact on peoples activities
--		in the five most affected countries?  
-- =========================================================================
-- Hypothesis:  The species with the most impact on nature will be for all countries formicidae, muridae and salmonidae.
-- Finding: Only the USA and South Africa reported species from the animal Kingdom impacting peoples activities.
-- For South Africa it is on species from the  corvidae family, for the USA it in one species from the fomicidaeand one from the buprestidae family.

SELECT 
	CASE
        WHEN l.country_location LIKE '%USA%' THEN 'USA'
        WHEN l.country_location LIKE '%Japan%' THEN 'Japan'
        WHEN l.country_location LIKE '%Ecuador%' THEN 'Ecuador'
        WHEN l.country_location LIKE '%South Africa%' THEN 'South Africa'
        WHEN l.country_location LIKE '%Spain%' THEN 'Spain'
    END AS country,
	s.family,
		count(DISTINCT i.species_id) as  "magnitude 3"
FROM impact as i
	INNER JOIN location as l
		ON i.location_id = l.location_id
	INNER JOIN species as s
		ON i.species_id = s.species_id
WHERE s.kingdom = "Plantae"
	and i.magnitude_cwb = "3"
	and (l.country_location LIKE '%USA%'
		 OR l.country_location LIKE '%Japan%'
		  OR l.country_location LIKE '%Ecuador%'
		   OR l.country_location LIKE '%South Africa%'
			OR l.country_location LIKE '%Spain%')
GROUP BY country, s.family
ORDER BY country, "magnitude 3" DESC;

-- =========================================================================
-- Q11 | Which are the 10 species that have the greatest impact on nature?
-- =========================================================================
-- Hypothesis: The 10 species with the greatest impact on nature could be 
-- Sirex noctilio, Xanthogaleruca luteola, Ceratopteris thalictroides,Halotydeus destructor,
-- Sminthurus viridis, Brevicoryne brassicae, Lipaphis erysimi, Myzus persicae, Aphis craccivora and Bombus terrestris

-- Findings: The 10 species with the greatest impact on nature are
-- Felis catus, Rattus rattus, Vulpes vulpes, Linepithema humile, Rattus exulans,
-- Pterois volitans, Anoplolepis gracilipes, Solenopsis invicta, Capra hircus and Caulerpa taxifolia


SELECT s.ias_species_name as "species",
		count(
		CASE WHEN i.magnitude_nature = 3 THEN i.species_id END) AS "magnitude 3",
		count(
		CASE WHEN i.magnitude_nature = 2 THEN i.species_id END) AS "magnitude 2",
		count(
		CASE WHEN i.magnitude_nature = 1 THEN i.species_id END) AS "magnitude 1"
FROM impact as i
		INNER JOIN species as s
		on i.species_id = s.species_id
WHERE i.magnitude_nature is "3" or i.magnitude_nature is "2" or i.magnitude_nature is "1"
GROUP BY "species"
ORDER BY "magnitude 3" DESC,
	     "magnitude 2" DESC,
		 "magnitude 1" DESC
LIMIT 10;

-- =========================================================================
-- Q12 | Which are the 10 species that have the greatest impact on peoples activities?
-- =========================================================================
-- Hypothesis: The 10 species with the greatest impact on peoples cativities could be Gambusia affinis
-- Apiosoma piscicola, Schyzocotyle acheilognathi, Lernea cyprinacea, Ichthyophthirius multifiliis, Chilodonella piscicola,
-- Chilodonella hexasticha, Argulus japonicus, Cyprinus carpio and Coptodon rendalli.

-- Findings: The 10 species with the greatest impact on peoples activities are 
-- Eichhornia crassipes, Corvus splendens, Agrilus planipennis, Rhinella marina, Dengue virus,
-- Wasmannia auropunctata, Salvinia molesta, Mikania micrantha, Solenopsis invicta and Vespa velutina nigrithorax


SELECT s.ias_species_name as "species",
		count(
		CASE WHEN i.magnitude_cwb = 3 THEN i.species_id END) AS "magnitude 3",
		count(
		CASE WHEN i.magnitude_cwb = 2 THEN i.species_id END) AS "magnitude 2",
		count(
		CASE WHEN i.magnitude_cwb = 1 THEN i.species_id END) AS "magnitude 1"
FROM impact as i
		INNER JOIN species as s
		on i.species_id = s.species_id
WHERE i.magnitude_cwb is "3" or i.magnitude_cwb is "2" or i.magnitude_cwb is "1"
GROUP BY "species"
ORDER BY "magnitude 3" DESC,
	     "magnitude 2" DESC,
		 "magnitude 1" DESC
LIMIT 10;

SELECT species.ias_species_name
FROM species;
