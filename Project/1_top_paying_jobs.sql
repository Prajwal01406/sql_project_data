/* QUESTION - 
            What are the top 10 highest paying Data Analyst jobs(remote)?*/

SELECT 
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

LIMIT 10;
