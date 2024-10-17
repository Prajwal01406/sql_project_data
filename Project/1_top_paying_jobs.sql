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

/*
Here are the top-paying remote data analyst jobs

*Mantys - Data Analyst, $6,50,000

*Meta - Director of Analytics, $3,36,500

*AT&T - Associate Director- Data Insights, $2,55,829.50

*Pinterest - Data Analyst, Marketing, $2,32,423

*UCLA Healthcare - Data Analyst, $2,17,000

*SmartAsset - Principal Data Analyst, $2,05,000

*Inclusively - Director, Data Analyst, $1,89,309

*Motional - Principal Data Analyst, $1,89,000

*SmartAsset - Principal Data Analyst, $1,86,000

*Get It Recruit - ERM Data Analyst, $1,84,000
*/