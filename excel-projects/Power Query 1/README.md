# Job Posting Analysis and Data Transformation (ETL)

This project involves the analysis of a job postings dataset to extract insights regarding market trends, salary distributions, and job demand. The primary focus of the work is the data transformation (ETL) process, converting raw data into a structured format suitable for detailed reporting.

All data manipulation, cleaning, and modeling were performed using Microsoft Power Query within Excel.


## Project Overview

The original dataset contained unstructured information regarding various job listings. The goal of this project was to clean this data and generate summary statistics to understand how different factors influence salary and hiring volume.

Key analyses performed in this project include:

#### Location Analysis: Examining the geographical distribution of job postings.

#### Company Size Analysis: Understanding hiring trends based on the scale of the organizations.

#### Job Title Analysis: Identifying the most in-demand job roles.

#### Salary & Demand Aggregation: A detailed breakdown calculating the average salary and total job counts.


## Query Dependencies
The image below illustrates the data flow and the relationships between the queries used in this project:


## Repository Contents
This repository is organized into raw data, analysis scripts, and the final output:


## 1. Data Files
AnalyzedDataset.xlsx: The final Excel file containing the cleaned data model and the summary tables.

**RawDataset.xlsx**: The original raw dataset used as the source.

**states.xlsx**: Supplementary data used for location mapping and normalization.


## 2. ETL Scripts (M Language)

The Power Query logic has been exported into separate .m files for transparency:

#### data_cleaning_codes.m: The main script for cleaning inconsistencies and standardizing data types.

#### salary_by_location_codes.m: Logic for aggregating salary data based on geographical location.

#### salary_by_role_codes.m: Logic for grouping data by job titles.

#### salary_by_size_codes.m: Logic for analyzing trends based on company size.

#### salary_by_size_and_role_codes.m: Advanced grouping script that combines both company size and job role for detailed insights.


## Tools Used
Microsoft Excel: Used for final data visualization and storage.

Power Query (M Language): Used for the ETL process (Extract, Transform, Load).


## How to View
Download the repository to your local machine.

Open AnalyzedDataset.xlsx in Microsoft Excel.

To view the data transformation steps within Excel, navigate to the Data tab and select Queries & Connections.

Alternatively, you can open the .m files in any text editor to review the raw code logic used for the transformations.

![Query Dependencies Diagram](QueryDependencies.png)


