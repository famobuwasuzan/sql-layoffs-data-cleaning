-- Exploratoty Data Analysis

SELECT *
FROM layoffs_2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_2;

SELECT *
FROM layoffs_2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT *
FROM layoffs_2
WHERE country = 'Nigeria'
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(date), MAX(date)
FROM layoffs_2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_2
GROUP BY YEAR(date)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_2
GROUP BY stage
ORDER BY 2 DESC;

SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_2
WHERE date IS NOT NULL
GROUP BY month
ORDER BY month ASC;

WITH Rolling_Total AS
(
SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_2
WHERE date IS NOT NULL
GROUP BY month
ORDER BY month ASC
)
SELECT month, total_layoffs, SUM(total_layoffs) OVER(ORDER BY MONTH) AS rolling_total
FROM Rolling_Total;

SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_2
GROUP BY company, YEAR(date)
ORDER BY company ASC;

SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_2
GROUP BY company, YEAR(date)
ORDER BY 3 DESC;

WITH Company_Year (company, year, total_layoffs) AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_2
GROUP BY company, YEAR(date)
)
SELECT *, 
DENSE_RANK() OVER (PARTITION BY year ORDER BY total_layoffs DESC) AS Ranking
FROM Company_Year
WHERE year IS NOT NULL
ORDER BY Ranking ASC;

WITH Company_Year (company, year, total_layoffs) AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_2
GROUP BY company, YEAR(date)
), Company_Year_Rank AS
(
SELECT *, 
DENSE_RANK() OVER (PARTITION BY year ORDER BY total_layoffs DESC) AS Ranking
FROM Company_Year
WHERE year IS NOT NULL
)
SELECT * 
FROM Company_Year_Rank
WHERE Ranking <=5
;