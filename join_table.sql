-- creating table
CREATE TABLE `covid_deaths` (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` text,
  `population` bigint,
  `total_cases` bigint,
  `new_cases` bigint,
  `total_deaths` bigint,
  `new_deaths` bigint,
  `reproduction_rate` bigint,
  `icu_patients` bigint,
  `hosp_patients` bigint
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `covid_vaccination` (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` text,
  `new_tests` double DEFAULT NULL,
  `total_tests` double DEFAULT NULL,
  `tests_per_case` double DEFAULT NULL,
  `total_vaccinations` double DEFAULT NULL,
  `people_vaccinated` double DEFAULT NULL,
  `people_fully_vaccinated` double DEFAULT NULL,
  `new_vaccinations` double DEFAULT NULL,
  `stringency_index` double DEFAULT NULL,
  `population_density` double DEFAULT NULL,
  `median_age` double DEFAULT NULL,
  `aged_65_older` double DEFAULT NULL,
  `aged_70_older` double DEFAULT NULL,
  `gdp_per_capita` double DEFAULT NULL,
  `cardiovasc_death_rate` double DEFAULT NULL,
  `diabetes_prevalence` double DEFAULT NULL,
  `female_smokers` double DEFAULT NULL,
  `male_smokers` double DEFAULT NULL,
  `handwashing_facilities` double DEFAULT NULL,
  `hospital_beds_per_thousand` double DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL,
  `human_development_index` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- importing data
LOAD DATA INFILE "covid_deaths.csv"
INTO TABLE covid_deaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE "covid_vaccination.csv"
INTO TABLE covid_vaccination
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- checking for duplicates
SELECT date, continent, location,
COUNT(*) as Checking_Dup
FROM covid_db.covid_deaths
GROUP BY date, continent, location
HAVING Checking_Dup > 1;

SELECT date, continent, location,
COUNT(*) as Checking_Dup
FROM covid_db.covid_vaccination
GROUP BY date, continent, location
HAVING Checking_Dup > 1;


SELECT * FROM covid_deaths;
SELECT * FROM covid_vaccination;


-- data type conversion
UPDATE covid_deaths
SET `date` = str_to_date(`date`, '%d-%m-%Y');

ALTER TABLE covid_deaths
MODIFY `date` DATE;

UPDATE covid_vaccination
SET `date` = str_to_date(`date`, '%d-%m-%Y');

ALTER TABLE covid_vaccination
MODIFY `date` DATE;


-- data filtering
CREATE TABLE covid_deaths_india LIKE covid_deaths;

INSERT INTO covid_deaths_india
SELECT * FROM covid_deaths
WHERE location = 'india';

CREATE TABLE covid_vaccination_india LIKE covid_vaccination;

INSERT INTO covid_vaccination_india
SELECT * FROM covid_vaccination
WHERE location = 'india';

SELECT * FROM covid_deaths_india;
SELECT * FROM covid_vaccination_india;

-- column removal
ALTER TABLE covid_deaths_india
DROP reproduction_rate,
DROP icu_patients,
DROP hosp_patients,
DROP iso_code,
DROP continent,
DROP location;

ALTER TABLE covid_vaccination_india
DROP iso_code,
DROP continent,
DROP location,
DROP tests_per_case,
DROP stringency_index,
DROP population_density,
DROP median_age,
DROP aged_65_older,
DROP aged_70_older,
DROP gdp_per_capita,
DROP cardiovasc_death_rate,
DROP diabetes_prevalence,
DROP female_smokers,
DROP male_smokers,
DROP handwashing_facilities,
DROP hospital_beds_per_thousand,
DROP life_expectancy,
DROP human_development_index;

SELECT * FROM covid_deaths_india;
SELECT * FROM covid_vaccination_india;


-- data joining
CREATE TABLE joint_table AS
SELECT *
FROM covid_deaths_india cdi
JOIN covid_vaccination_india cvi
USING(`date`);

SELECT * FROM joint_table;

SELECT 'date', 'population', 'total_cases', 'new_cases', 'total_deaths', 'new_deaths', 'new_tests', 'total_tests', 'total_vaccinations', 'people_vaccinated', 'people_fully_vaccinated', 'new_vaccinations'
UNION ALL
SELECT * FROM joint_table
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/joint_table.csv'
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n';