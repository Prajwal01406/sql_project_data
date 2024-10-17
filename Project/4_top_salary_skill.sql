/*
Question - 
        What are the top skills for Data Analyst based on salary?
*/
                

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS salary_avg

FROM 
    job_postings_fact INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim 
    ON skills_dim.skill_id = skills_job_dim.skill_id

WHERE 
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    -- ,AND job_work_from_home = true --
    -- use this for remote jobs--
GROUP BY 
    skills

ORDER BY 
    salary_avg DESC

LIMIT 10;

/*
Here's a quick insight into the top skills and their average salaries:

*SVN - $400,000

*Solidity - $179,000

*Couchbase - $160,515

*DataRobot - $155,486

*Golang - $155,000

*Mxnet - $149,000

*Dplyr - $147,633

*VMware - $147,500

*Terraform - $146,734

*Twilio - $138,500

SVN tops the chart, potentially due to its critical role in version control 
and collaborative work, making it highly valuable. Skills like Solidity, 
essential for blockchain development, also command high salaries due to 
the rising demand in the crypto space. Advanced analytics and data 
manipulation tools like DataRobot and dplyr reflect the significant value
of data-driven insights. Technologies like Couchbase and VMware, which  
underpin modern IT infrastructure, continue to be vital and highly compensated. */
