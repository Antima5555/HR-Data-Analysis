SELECT * FROM cleaned_data;

--  1. What is the total number of employees in the organization? 
SELECT count(*) AS Total_Employees
FROM cleaned_data;


--  2. What is the overall attrition rate?
SELECT 
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(100 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) ,2) AS attrition_rate
FROM cleaned_data;


--  3. How many employees have left the company by department?
SELECT department, COUNT(*) AS employees,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS Number_of_employees_left
FROM cleaned_data
GROUP BY department;
 
 
 -- 4. Which job roles have the highest attrition?
SELECT JobRole, COUNT(*) AS employees,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS Number_of_employees_left
FROM cleaned_data
GROUP BY JobRole
ORDER BY Number_of_employees_left DESC;
 
 
-- 5. How does overtime impact employee attrition?
SELECT OverTime, COUNT(*) AS employees,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS Number_of_employees_left
FROM cleaned_data
GROUP BY OverTime;
 
 
 -- 6. What is the average monthly income of employees who left vs stayed?
 SELECT Attrition , ROUND(AVG(MonthlyIncome),2) AS average_salary
 FROM cleaned_data
 GROUP BY Attrition;
 
 
 -- 7. How does work–life balance affect attrition?
SELECT WorkLifeBalance,
       COUNT(*) AS employees,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM cleaned_data
GROUP BY WorkLifeBalance
ORDER BY attrition_count DESC;


-- 8.  What is the attrition rate across different tenure groups?
SELECT 
CASE  WHEN YearsAtCompany < 3 THEN '0-2 Years'
	  WHEN YearsAtCompany BETWEEN 3 AND 6 THEN '3-6 Years'
	  ELSE '7+ Years'
END AS tenure_group,
  COUNT(*) AS employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM cleaned_data
GROUP BY tenure_group;
 
 
-- 9. Which department–overtime combinations show the highest attrition risk?
 SELECT department, OverTime , 
 COUNT(*) AS employees,
 SUM( CASE WHEN Attrition= 'Yes' THEN 1 ELSE 0 END) AS attrition_count
 FROM cleaned_data
 GROUP BY department, OverTime
 ORDER BY attrition_count DESC;
 
 
 -- 10.  What are the top 5 job roles by attrition rate?
SELECT JobRole,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(100 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) ,2) AS attrition_rate
FROM cleaned_data
GROUP BY JobRole
ORDER BY attrition_rate DESC
LIMIT 5;
 
 
 
--  Views
  
CREATE VIEW v_tenure_group AS 
SELECT 
CASE  WHEN YearsAtCompany < 3 THEN '0-2 Years'
	  WHEN YearsAtCompany BETWEEN 3 AND 6 THEN '3-6 Years'
	  ELSE '7+ Years'
END AS tenure_group,
  COUNT(*) AS employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM cleaned_data
GROUP BY tenure_group;

 
 
 
 
 
 