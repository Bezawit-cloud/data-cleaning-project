SELECT *FROM
employment;
CREATE TABLE employment_staging
LIKE employment;
INSERT employment_staging
SELECT *FROM
employment;
SELECT *FROM
employment_staging;

WITH ranked_cte AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY `Full Name`, `Age`, `Email`, `Date Applied`, `Desired Salary (ETB)`, `Education Level`
      ORDER BY `ID`
    ) AS row_num
  FROM employment_staging
)
SELECT *
FROM ranked_cte
WHERE row_num > 1;
CREATE TABLE `employment_staging2` (
  `ID` int DEFAULT NULL,
  `Full Name` text,
  `Age` double DEFAULT NULL,
  `Email` text,
  `Date Applied` text,
  `Desired Salary (ETB)` double DEFAULT NULL,
  `Education Level` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
SELECT *FROM
employment_staging2;
INSERT INTO employment_staging2
SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY `Full Name`, `Age`, `Email`, `Date Applied`, `Desired Salary (ETB)`, `Education Level`
      ORDER BY `ID`
    ) AS row_num
  FROM employment_staging;
  DELETE FROM
employment_staging2
WHERE row_num>1;
SELECT *FROM
employment_staging2;










SELECT DISTINCT `Full Name` FROM
employment_staging2;
SELECT `Full Name`, TRIM(`Full Name`)
 FROM employment_staging2;
 UPDATE employment_staging2
 SET `Full Name` = TRIM(`Full Name`);
 
 
 SELECT `Full Name`,
       CONCAT(
         UPPER(LEFT(TRIM(`Full Name`), 1)),
         LOWER(SUBSTRING(TRIM(`Full Name`), 2))
       ) AS cleaned_name
FROM employment_staging2;
UPDATE employment_staging2
SET `Full Name` = CONCAT(
  UPPER(LEFT(TRIM(`Full Name`), 1)),
  LOWER(SUBSTRING(TRIM(`Full Name`), 2))
);
 SELECT `Full Name`FROM
 employment_staging2;
 SELECT *FROM
 employment_staging2;
 ALTER TABLE employment_staging2
MODIFY COLUMN `Age` INT;


SELECT*
FROM employment_staging2
WHERE Email IS NULL OR TRIM(Email) = '';
UPDATE employment_staging2
SET Email = NULLIF(TRIM(Email), '');
-- Find emails not matching a basic email pattern
SELECT Email
FROM employment_staging2
WHERE Email IS NOT NULL
  AND Email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';
  UPDATE employment_staging2
SET Email = REPLACE(Email, '[at]', '@')
WHERE Email LIKE '%[at]%';
UPDATE employment_staging2
SET Email = NULL
WHERE Email IS NOT NULL
  AND Email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';
  
SELECT  DISTINCT `Date Applied`, LENGTH(`Date Applied`) AS length
FROM employment_staging2
ORDER BY 1;
UPDATE employment_staging2
SET `Date Applied` = NULL
WHERE `Date Applied` REGEXP '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$';
SELECT `Date Applied`
FROM employment_staging2;
# WHERE `Date Applied` REGEXP '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$';
UPDATE employment_staging2
SET `Date Applied` = NULL
WHERE `Date Applied` REGEXP '^[0-9]{1,2} [A-Za-z]+, [0-9]{4}$';
SELECT `Date Applied`
FROM employment_staging2;
SELECT `Date Applied`
FROM employment_staging2
WHERE `Date Applied` REGEXP '^[0-9]{1,2} [A-Za-z]+, [0-9]{4}$';
UPDATE employment_staging2
SET `Date Applied` = NULL
WHERE LOWER(TRIM(`Date Applied`)) REGEXP '^[0-9]{1,2} [a-z]+,? [0-9]{4}$';
SELECT `Date Applied`
FROM employment_staging2
WHERE LOWER(TRIM(`Date Applied`)) REGEXP '^[0-9]{1,2} [a-z]+,? [0-9]{4}$';
SELECT COUNT(*) AS null_dates
FROM employment_staging2
WHERE `Date Applied` IS NULL;
SELECT `Date Applied`
FROM employment_staging2;
SELECT DISTINCT `Date Applied`
FROM employment_staging2
WHERE `Date Applied` IS NOT NULL;
UPDATE employment_staging2
SET `Date Applied` = STR_TO_DATE(`Date Applied`, '%m/%d/%Y')
WHERE `Date Applied` LIKE '__/__/____';
UPDATE employment_staging2
SET `Date Applied` = STR_TO_DATE(`Date Applied`, '%d-%m-%Y')
WHERE `Date Applied` LIKE '__-__-____';
UPDATE employment_staging2
SET `Date Applied` = STR_TO_DATE(`Date Applied`, '%Y/%m/%d')
WHERE `Date Applied` LIKE '____/__/__';
SELECT DISTINCT `Date Applied`
FROM employment_staging2
WHERE `Date Applied` IS NOT NULL;
UPDATE employment_staging2
SET `Date Applied` = STR_TO_DATE(`Date Applied`, '%d/%m/%Y')
WHERE `Date Applied` LIKE '__/__/____';
SELECT DISTINCT `Date Applied`
FROM employment_staging2
WHERE `Date Applied` IS NOT NULL;

SELECT `Date Applied`
FROM employment_staging2
WHERE `Date Applied` LIKE '____.__.__';
UPDATE employment_staging2
SET `Date Applied` = STR_TO_DATE(`Date Applied`, '%Y.%m.%d')
WHERE `Date Applied` LIKE '____.__.__';
SELECT `Date Applied`
FROM employment_staging2;
ALTER TABLE employment_staging2
MODIFY COLUMN `Date Applied` DATE;
DESCRIBE employment_staging2;
SELECT `Desired Salary (ETB)`
FROM employment_staging2;
UPDATE employment_staging2
SET `Desired Salary (ETB)` = TRIM(`Desired Salary (ETB)`);
SELECT `Desired Salary (ETB)`
FROM employment_staging2;
SELECT *
FROM employment_staging2;
SELECT DISTINCT `Education Level`
FROM employment_staging2;
UPDATE employment_staging2
SET `Education Level` = TRIM(`Education Level`);
UPDATE employment_staging2
SET `Education Level` = LOWER(`Education Level`);
UPDATE employment_staging2
SET `Education Level` = 'bachelor'
WHERE LOWER(`Education Level` ) LIKE 'b%';
UPDATE employment_staging2
SET `Education Level` = 'master degree'
WHERE LOWER(`Education Level` ) LIKE 'm%';
UPDATE employment_staging2
SET `Education Level` = 'certificate'
WHERE LOWER(`Education Level` ) LIKE 'c%';
UPDATE employment_staging2
SET `Education Level` = 'diploma'
WHERE LOWER(`Education Level` ) LIKE 'd%';
UPDATE employment_staging2
SET `Education Level` = 'high school'
WHERE LOWER(`Education Level` ) LIKE 'h%';
UPDATE employment_staging2
SET `Education Level` = 'master degree'
WHERE LOWER(`Education Level` ) LIKE 'am%';
UPDATE employment_staging2
SET `Education Level` = 'high school'
WHERE LOWER(`Education Level` ) LIKE 'ih%';
UPDATE employment_staging2
SET `Education Level` = 'diploma'
WHERE LOWER(`Education Level` ) LIKE 'id%';
UPDATE employment_staging2
SET `Education Level` = 'certificate'
WHERE LOWER(`Education Level` ) LIKE 'ec%';
UPDATE employment_staging2
SET `Education Level` = 'bachelor'
WHERE LOWER(`Education Level` ) LIKE 'abc%';
SELECT *FROM
employment_staging2;
SELECT *
FROM employment_staging2
WHERE `Age` < 21
  AND (`Education Level` = 'Bachelor' OR `Education Level` = 'Master');
  ALTER TABLE employment_staging2
DROP COLUMN `row_num`;
# Exploatary data analysis
SELECT `Education Level`, COUNT(*) AS total_applications
FROM employment_staging2
GROUP BY `Education Level`
ORDER BY total_applications DESC;
SELECT 
  YEAR(`Date Applied`) AS application_year,
  COUNT(*) AS total_applications,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS year_rank
FROM employment_staging2
WHERE `Date Applied` IS NOT NULL
GROUP BY application_year;
SELECT 
  MONTH(`Date Applied`) AS application_month,
  COUNT(*) AS total_applications,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS month_rank
FROM employment_staging2
WHERE `Date Applied` IS NOT NULL
GROUP BY application_month;
SELECT `Desired Salary (ETB)` 
FROM employment_staging2;
SELECT 
  `Education Level`,
  AVG(`Desired Salary (ETB)`) AS average_salary
FROM employment_staging2
WHERE `Desired Salary (ETB)` IS NOT NULL
GROUP BY `Education Level`
ORDER BY average_salary DESC;
SELECT Age,
  COUNT(*) AS total_applicants
FROM employment_staging2
WHERE Age IS NOT NULL
GROUP BY Age
ORDER BY total_applicants DESC;
















































































 

 
 

  













