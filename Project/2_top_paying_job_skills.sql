/* Question 
            What skills are required for top paying Data Anayst jobs?
        */


WITH job_and_company AS (SELECT 
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date

FROM 
    job_postings_fact J JOIN company_dim C    
    ON j.company_id = c.company_id

WHERE 
    job_location = 'Anywhere' 
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC
), 
skills_job_and_dim AS (
SELECT * 

FROM 
    skills_dim SD JOIN skills_job_dim SJD 
    ON SD.skill_id = SJD.skill_id

)

SELECT 
    job_title,
    company_name,
    skills,
    salary_year_avg

FROM 
    job_and_company JC JOIN skills_job_and_dim SJAD 
    ON JC.job_id = SJAD.job_id;

/* Breakdown-

*SQL is leading with a count of 8
*Python follows closely with a bold count of 7
*Tableau is also highly sought after, with a count of 6
*Other skills like R, Snowflake, Pandas and Excel show varying degrees of demand*/
