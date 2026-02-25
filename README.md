# Global Layoffs Data Cleaning (MySQL)

## Project Overview
This project focuses on cleaning a global layoffs dataset using MySQL in order to prepare raw data for analysis.
The original dataset contained duplicate records, missing values, inconsistent text formatting, and incorrect data types that could distort analytical results.
The objective was to transform the raw dataset into a structured, reliable, and analysis-ready format.

## Dataset Description

The dataset contains information on company layoffs, including:

- Company name
- Location
- Industry
- Total laid off
- Percentage laid off
- Date
- Company stage
- Country
- Funds raised

## Tools Used
- MySQL
- SQL (Window Functions, Joins, Data Type Conversion, String Functions)

## Cleaning Steps
- Created a working copy of the raw dataset to preserve data integrity.
- Removed duplicate records using ROW_NUMBER() with PARTITION BY.
- Standardised text fields (e.g., industry labels, country formatting).
- Converted date column from TEXT format to DATE format using STR_TO_DATE().
- Handled missing values, including filling industry values using self-joins.
- Removed irrelevant records where key layoff metrics were missing.

## Key Learning
This project strengthened my understanding of:

- The importance of structured data before analysis
- Controlled deduplication using window functions
- The impact of inconsistent data on business insights
- Preparing datasets for reliable exploratory analysis
