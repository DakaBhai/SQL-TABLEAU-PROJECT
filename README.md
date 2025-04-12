# MySQL + Tableau COVID-19 Data Analysis Project 📊


📌 Overview

As an aspiring data analyst, I created this end-to-end project using SQL and Tableau. The goal was to analyze COVID-19 data specifically for India, uncover trends, and present insights through a visual dashboard.


🔍 Project Workflow

1. Dataset Sourcing:

Downloaded two datasets: covid_deaths and covid_vaccination https://www.kaggle.com/datasets/franklinposso/covid-dataset-sql.

2. Data Import & Cleaning (MySQL):

  - Imported data using LOAD DATA INFILE.

3. Data Preparation:

  - Checked for duplicates, found none.

  - Changed the date column data type to DATE.

  - Filtered both datasets for rows where location = 'India'.

  - Dropped unnecessary columns (names will be mentioned in the code).

4. Table join between deaths and vaccination datasets

  - Created a new combined table called joint_table.

5. Data Export & Visualization:

  - Exported the cleaned and joined data using SELECT INTO OUTFILE.

  - Imported this data into Tableau.

  - Built an interactive dashboard to showcase trends and insights from the COVID-19 situation in India.


📜 SQL Snippets
