-- Trend Analysis

SELECT *
FROM layoffs_2;

WITH yearly_totals AS 
(
    SELECT YEAR(date) AS year,
           SUM(total_laid_off) AS total_layoffs
    FROM layoffs_2
    WHERE date IS NOT NULL
    GROUP BY YEAR(date)
)
SELECT year,
       total_layoffs,
       LAG(total_layoffs) OVER (ORDER BY year) AS previous_year,
       total_layoffs - LAG(total_layoffs) OVER (ORDER BY year) AS yoy_change
FROM yearly_totals;

WITH industry_totals AS 
(
    SELECT industry,
           SUM(total_laid_off) AS total_layoffs
    FROM layoffs_2
    GROUP BY industry
)
SELECT industry,
       total_layoffs,
       ROUND(total_layoffs * 100.0 /
            SUM(total_layoffs) OVER(), 2) AS percentage_of_total
FROM industry_totals
ORDER BY total_layoffs DESC;

SELECT stage, AVG(total_laid_off) AS avg_layoffs, AVG(funds_raised_millions) AS avg_funding
FROM layoffs_2
GROUP BY stage
ORDER BY avg_layoffs DESC;
    
SELECT company,
       COUNT(*) AS layoff_events
FROM layoffs_2
GROUP BY company
HAVING COUNT(*) > 1
ORDER BY layoff_events DESC;

SELECT industry,
       COUNT(*) AS layoff_events
FROM layoffs_2
GROUP BY industry
HAVING COUNT(*) > 1
ORDER BY layoff_events DESC;

SELECT company,
       industry,
       country,
       percentage_laid_off,
       total_laid_off,
       date
FROM layoffs_2
WHERE percentage_laid_off >= 0.5
ORDER BY percentage_laid_off DESC;

SELECT industry,
       COUNT(*) AS severe_layoff_events
FROM layoffs_2
WHERE percentage_laid_off >= 0.5
GROUP BY industry
ORDER BY severe_layoff_events DESC;

SELECT country,
       COUNT(*) AS severe_layoff_events
FROM layoffs_2
WHERE percentage_laid_off >= 0.5
GROUP BY country
ORDER BY severe_layoff_events DESC;

SELECT 
    COUNT(CASE WHEN percentage_laid_off >= 0.5 THEN 1 END) AS severe_events,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(CASE WHEN percentage_laid_off >= 0.5 THEN 1 END) * 100.0 
        / COUNT(*), 2
    ) AS severe_percentage
FROM layoffs_2;