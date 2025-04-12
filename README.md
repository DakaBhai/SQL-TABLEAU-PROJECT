# COVID-19 Data Analysis Project: India

## Overview

This project showcases my skills in data analysis using SQL for data cleaning and preparation, and Tableau for data visualization and insight generation. The analysis focuses specifically on the COVID-19 pandemic data for India.

The project involved the following key steps:

1.  **Data Acquisition:** Downloading two publicly available datasets related to COVID-19 deaths and vaccinations. https://www.kaggle.com/datasets/franklinposso/covid-dataset-sql
2.  **Data Import and Cleaning (MySQL):** Importing the downloaded datasets into a MySQL database and performing initial data cleaning.
3.  **Checking Duplicates:** Checked for duplicates, found none.
4.  **Data Type Conversion:** Ensuring the 'date' column in both datasets was in the correct 'date' format.
5.  **Data Filtering:** Subsetting both datasets to include only records where the location was 'India'.
6.  **Column Removal:** Removing unnecessary columns from both the deaths and vaccination datasets.
7.  **Data Joining (MySQL):** Joining the filtered and cleaned deaths and vaccination datasets into a new table named `joint_table`.
8.  **Data Export (MySQL):** Exporting the resulting `joint_table` from MySQL.
9.  **Dashboard Creation (Tableau):** Developing an interactive dashboard in Tableau to visualize key trends, insights, and patterns related to COVID-19 in India.

## Datasets

* **COVID-19 Deaths Dataset:**
* **COVID-19 Vaccination Dataset:**

## SQL Operations (Performed in MySQL)

1.  **Table Creation:**
    ```sql
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
    ```

2.  **Data Import:**
    ```sql
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
    ```

3.  **Checking Duplicates:**
    ```sql
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
    ```

4.  **Data Type Conversion:**
    ```sql
    UPDATE covid_deaths
    SET `date` = str_to_date(`date`, '%d-%m-%Y');
    
    ALTER TABLE covid_deaths
    MODIFY `date` DATE;
    
    UPDATE covid_vaccination
    SET `date` = str_to_date(`date`, '%d-%m-%Y');
    
    ALTER TABLE covid_vaccination
    MODIFY `date` DATE;
    ```

5.  **Data Filtering (India):**
    ```sql
    CREATE TABLE covid_deaths_india LIKE covid_deaths;

    INSERT INTO covid_deaths_india
    SELECT * FROM covid_deaths
    WHERE location = 'india';

    CREATE TABLE covid_vaccination_india LIKE covid_vaccination;

    INSERT INTO covid_vaccination_india
    SELECT * FROM covid_vaccination
    WHERE location = 'india';
    ```

6.  **Column Removal:**
    ```sql
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
    ```

7.  **Data Joining:**
    ```sql
    CREATE TABLE joint_table AS
    SELECT *
    FROM covid_deaths_india cdi
    JOIN covid_vaccination_india cvi
    USING(`date`);
    ```

8.  **Data Export:**
    ```sql
    SELECT 'date', 'population', 'total_cases', 'new_cases', 'total_deaths', 'new_deaths', 'new_tests', 'total_tests', 'total_vaccinations', 'people_vaccinated', 'people_fully_vaccinated', 'new_vaccinations'
    UNION ALL
    SELECT * FROM joint_table
    INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/joint_table.csv'
    FIELDS TERMINATED BY ','  
    ENCLOSED BY '"'  
    LINES TERMINATED BY '\n';
    ```

## Tableau Dashboard

The Tableau dashboard provides visual insights into the COVID-19 situation in India, potentially including:

* Trends in daily and total cases and deaths.
* Vaccination progress over time (e.g., total vaccinations, daily vaccinations, percentage of population vaccinated).
* Relationship between cases, deaths, and vaccination rates.
* Other relevant visualizations and interactive elements to explore the data.

*(A screenshot or link to the Tableau Public dashboard can be added here if applicable.)*

## Technologies Used

* **SQL:** For data import, cleaning, filtering, joining, and export (specifically MySQL).
* **Tableau:** For data visualization and dashboard creation.

## Learning Outcomes

Through this project, I gained practical experience in:

* Extracting and loading data from CSV files into a SQL database.
* Performing data cleaning tasks using SQL.
* Filtering and manipulating data based on specific criteria.
* Joining multiple tables based on common keys.
* Exporting data from a SQL database for further analysis.
* Creating insightful and interactive dashboards using Tableau.
* Analyzing and visualizing trends in COVID-19 data for India.

## Next Steps (Optional)

* Further exploration of specific trends or demographics within the data.
* Incorporating additional datasets for a more comprehensive analysis.
* Deploying the Tableau dashboard for wider accessibility.
* Applying time series analysis techniques.

## Author

[Your Name/Handle]

## License

[Add your preferred license here, e.g., MIT License]
