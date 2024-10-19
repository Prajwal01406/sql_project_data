/*
Question-
     what is the most optimal skill for data analyst job? 
*/

SELECT 
    
    ROUND(AVG(salary_year_avg), 0) AS salary_avg,
    COUNT(J.job_id) AS job_demand_count,
    SD.skills,
    SD.skill_id 

FROM 
    job_postings_fact J INNER JOIN skills_job_dim SJD
    ON J.job_id = SJD.job_id
    INNER JOIN skills_dim SD
    ON SD.skill_id = SJD.skill_id

WHERE 
    job_title_short = 'Data Analyst'
    AND job_work_from_home = true 
    AND salary_year_avg IS NOT NULL

GROUP BY SD.skill_id

HAVING COUNT(J.job_id) > 25

ORDER BY 
    salary_avg DESC,
    job_demand_count DESC

LIMIT 25;
         



-- Detailed Querry --

WITH pay_size AS 
(SELECT 
    SD.skills,
    ROUND(AVG(salary_year_avg), 0) AS salary_avg,
    SD.skill_id

FROM 
    job_postings_fact J INNER JOIN skills_job_dim SJD
    ON J.job_id = SJD.job_id 
    INNER JOIN skills_dim SD
    ON SD.skill_id = SJD.skill_id

WHERE 
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = true
    -- ,AND job_work_from_home = true --
    -- use this for remote jobs--
GROUP BY 
    SD.skill_id),

Demand AS 
(SELECT 
    COUNT(J.job_id) AS job_demand_count,
    SD.skills,
    SD.skill_id 

FROM 
    job_postings_fact J
    INNER JOIN skills_job_dim SJD ON j.job_id = SJD.job_id 
    INNER JOIN skills_dim SD ON SJD.skill_id = SD.skill_id

WHERE 
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = true

GROUP BY
    SD.skill_id)

SELECT
    job_demand_count AS Demand,
    pay_size.skills,
    salary_avg

FROM 
    pay_size INNER JOIN Demand  
    ON pay_size.skill_id = Demand.skill_id

WHERE job_demand_count > 25

ORDER BY 
     salary_avg DESC,
     Demand DESC; 

