/* 
Question - 
         What are the most in-demand skills for data analysts (remote job)?
*/


SELECT 
    COUNT(J.job_id) AS job_demand_count,
    SD.skills AS skill_name,
    SD.skill_id 

FROM 
    job_postings_fact J
    INNER JOIN skills_job_dim SJD ON j.job_id = SJD.job_id 
    INNER JOIN skills_dim SD ON SJD.skill_id = SD.skill_id

WHERE 
    job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere'

GROUP BY
    SD.skill_id

ORDER BY 
    job_demand_count DESC

LIMIT 10;

/* 
With respect to the results of this querry we come to the conclusion 

*SQL has the highest demand with a bold job count of 7291 jobs
*Excel follows SQL with a bold job count of 4611 jobs
*Python is next with a job count of 3745 jobs
*Tableau, Power bi, R, sas are also some high demand skillls for Data Analyst

*/
