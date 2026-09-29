-- =========================================================================
-- schema.sql - the tables your database is made of
--
-- Project 1 | SQL: From Data to Insight
-- Team: Zoé Doucet
-- Dataset: Invasive Alien Species
--
-- This is a DELIVERABLE: it is how someone rebuilds your database from
-- nothing, and the tables here must match the ERD you drew.
--
-- Written for SQLite. On MySQL, add a CREATE DATABASE / USE at the top and
-- swap the types (TEXT -> VARCHAR(n), REAL -> DECIMAL, INTEGER PRIMARY KEY
-- -> INT PRIMARY KEY AUTO_INCREMENT).
-- =========================================================================

-- SQLite does not enforce foreign keys unless you ask it to, once per
-- connection. Without this line a broken key is accepted in silence.
PRAGMA foreign_keys = ON;


-- --- Lookup tables -------------------------------------------------------
-- The species table contains infomation about the species.
-- The primary key is the species_id.
CREATE TABLE species (
	species_id INTEGER PRIMARY KEY,
	ias_species_name TEXT, 
	verified_name_gbif_taxon TEXT,
    gbif_scientificname_with_author TEXT, 
	genus TEXT, 
	family TEXT,
	"order" TEXT,
	"class" TEXT,
    phylum TEXT,
	kingdom TEXT, 
	ias_taxon TEXT
	);

-- The loaction table contains infomation about the location of the species impact.
-- The primary key is the location_id.
CREATE TABLE location(
	location_id INTEGER PRIMARY KEY,
	region TEXT,
	country_location TEXT, 
	island TEXT, 
	island_k  TEXT
	);



-- --- main table -----------------------------------------------------
-- The main table is the impact tables with unique_id as the primary key 
-- and species_id as well as location_id as foreign keys. 

CREATE TABLE impact(
	unique_id TEXT PRIMARY KEY,
	species_id INTEGER,
	location_id INTEGER,
	reference TEXT, 
	doi TEXT, 
	assessor TEXT,
    year INTEGER, 
	year_of_impact INTEGER, 
	year_probability INTEGER,
	type_of_source TEXT, 
	units_of_analysis_clean TEXT,
    spatial_scale TEXT, 
	affected_native_species_taxon TEXT,
    mechanism_nature_clean TEXT, 
	direction_nature TEXT,
    direct_or_indirect_nature TEXT, 
	global_extinction INTEGER, 
	magnitude_nature TEXT,
    affected_ncp_clean TEXT, 
	direction_ncp TEXT, 
	affected_cwb_clean TEXT,
    direction_cwb TEXT, 
	magnitude_cwb TEXT, 
	language TEXT, 
	protected_area TEXT,
    protected_area_k INTEGER, 
	realm TEXT,
	FOREIGN KEY (species_id) REFERENCES species(species_id),
	FOREIGN KEY (location_id) REFERENCES location(location_id)
	);
