# Project 1 - Invasive Alien Species and Their Impacts
---

## Overview
This project explores the Global Impacts Dataset of Invasive Alien Species (GIDIAS), in which the impacts of invasive alien species is documented. The goal of the project is to understand the dataset, identify data-quality issues, develop research questions, and prepare the data for a analysis in SQL.
---

## Project Structure
The project follows an exploratory data analysis (EDA) approach before cleaning the data and moving into database design and SQL analysis. In the final part the results are visualised and the hypothesis are confirmed or rejected. 
---

## Requirements
The project uses:

* **Python**
* **Pandas** for data manipulation
* **Matplotlib** and **Seaborn** for visualisation
* **Seaborn** for statistical visualisations 
* **Jupyter Notebook** for exploratory analysis
* **SQL** for querying the final relational database
* **Git/GitHub** for version control
---
## How to Run

### 1. Clone the repository
Fork and clone the project directory.

### 2. Dowload the data
Dowload the data as well as the metadata from https://doi.org/10.6084/m9.figshare.27908838 and place the files in the data/raw folder.

### 3. Run the notebooks 1 and 2
Run the notebook 01_eda.ipynb to get an insight on the eda.
Than run the notbook 02_processing to clean the data, create the tables and as well als the DB database.

### 4. Run the queries in sl
Move to SQL to run the queries.

### 5. Run the third notebook
Run the third notbeook 03_hypothesis_and_visualisation.
First the queries will be loaded from the SQL file and than the visualisatons will be created.
---

## Dataset
For this project the Global Impacts Dataset of Invasive Alien Species (GIDIAS) was used. It has first been published on the 21. of Mai 2025 in Springer Natur and authored by S. Bacher et al.  (https://doi.org/10.6084/m9.figshare.27908838).

The dataset contains information about invasive alien species and their documented impacts.
Each row represents a record of an invasive alien species at a specific location, including its impact on the environment and human activities, as well as the year in which the impact was recorded or published.

The raw dataset contains:

* **22,865 observations**
* **90 columns**
* Information about species taxonomy
* Geographic information
* Introduction and impact years
* Impact mechanisms
* Impact magnitude
* Affected species, ecosystem services and human well-being
* References and source information

A separate metadata file provides descriptions and information about the variables in the dataset.
---

## Research Questions

The analysis focuses on the following three questions:

1. **When were invasive species introduced most frequently?**
2. **Which countries have the highest number of documented invasive species impacts?**
3. **Which invasive species have the greatest documented impact?**
---

## Data Exploration (notebook 01_eda.ipynb)

The first stage of the project focuses on understanding the structure and quality of the data.

The following aspects are investigated:

* Number of rows and columns
* Data types
* Missing values
* Unique identifiers
* Categorical and numerical variables

One important finding is that some variables contain multiple values in a single cell. For example, `Country.Location` and `Island` can contain several countries or islands separated by semicolons.

These fields therefore require special treatment before being used in a relational database.

The dataset contains both `rowID` and `UniqueID`.

`UniqueID` is unique for each record and is used to identify an individual impact record.

The species name is **not unique**, because one invasive species can occur in many different records.

For this reason, a separate `species_id` is created for each unique species when creating the tables.
---

## Data processing (notebook 02-processing.ipynb)

### Data cleaning

To achieve a clean data unnecessary columns are being discarded, than the names of the columns are standardised.
Furthermore the data types of a few columns are changed for the analysis.

The clean data is saved in the data/clean folder.

### Building the tables

The dataset will be split into three tables:

- an **impact** table with infomation regarding the impact a species has such as the magnitude of the impact, the realm it has an impact on and the language the impact was first described in
    - the primary key will be `unique_id`, which identifies the impact each species has in a distinct country and region
    - `species_id` will be one foreign key, wich will be created for each species
    - `location_id` will be an other foreign key, wich will be created for each region and country combination

- a **species** table with information regading the species such as family, class, kingdomm...
    - the primary key will be `species_id`

- the third table will be a table named **location**, which contains infomation on the location the species has an impact on, such as region and country
    - the primary key will be `location_id`


![Invasive Species ERD](../images/ERD_invasiv_species_1.png)

The new tables were saved in project_inv_sp.db
---

## Data analysis (queries.sql)

The data anlysis was done with SQLite. For each hypothesis one or two queries were written. 
---

## Data Visualisation and hypothesis confirmation (notebook 03-hypothesis_and_visualization.ipynb)

After loading the results of the queries from the sql file, visualisations were created for each question.

Different visualisation techniques were used to make the results easier to interpret and to highlight relevant patterns and differences in the data. Bar charts and stacked bar charts were created using Matplotlib and Seaborn, while other visualisation types were used where they were more appropriate for the data.

The visualisations were then used to evaluate the hypotheses by comparing the observed patterns with the expectations defined in the research questions. 

In the final part the hypothesis are rjected or confirmed acording to the results showed by the visualisation.
---


