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
-- The categorical columns you pulled out: an id and the value it stands for.
-- These have no foreign keys of their own, so they are created and loaded
-- FIRST.
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

CREATE TABLE location(
	region TEXT PRIMARY KEY,
	country_location TEXT, 
	island TEXT, 
	island_k  TEXT
	);



-- --- Your main table -----------------------------------------------------
-- The rows you are actually analysing: the numbers you care about, plus one
-- foreign key pointing at each lookup table above. Created and loaded LAST,
-- because every key it carries has to already exist somewhere else.

CREATE TABLE impact(
	unique_id TEXT PRIMARY KEY,
	species_id INTEGER,
	region TEXT,
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
	FOREIGN KEY (region) REFERENCES location(region)
	);


-- --- Indexes (optional) --------------------------------------------------
-- Worth adding on your foreign keys if a query starts to feel slow.
