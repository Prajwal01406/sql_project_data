CREATE TABLE Job_Applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(100),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(150),
    status VARCHAR(50)

);
SELECT * 
FROM job_applied;

INSERT INTO job_applied 
    (job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status)
VALUES (1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true, 
        'coverletter_01.pdf',
        'submitted'),
        (2,
        '2024-02-02',
        false,
        'resume_02.pdf',
        false,
        NULL,
        'interview scheduled'
            ),
        (3,
        '2024-02-03',
        true,
        'resume_03.pdf',
        true,
        'cover_leter_03.pdf',
        'ghosted'),
        (4,
        '2024-02-04',
        false,
        'resume_04.pdf',
        NULL,
        'cover_letter_04.pdf',
        'submitted'),
        (5,
        '2024-02-05',
        false,
        'resume_05.pdf',
        true,
        'coverletter_05.pdf',
        'rejected');

SELECT *
FROM job_applied;

ALTER TABLE job_applied 
ADD contact VARCHAR(50);

UPDATE job_applied SET contact = 'Erlich Bachman' WHERE job_id = 1;
UPDATE job_applied SET contact = 'Dinesh Chugtai' WHERE  job_id =2;
UPDATE job_applied SET contact = 'Bertram Golfoyle' WHERE  job_id =3;
UPDATE job_applied SET contact = 'Jian Yang' WHERE  job_id =4;
UPDATE job_applied SET contact = 'Big Head' WHERE  job_id =5;

ALTER TABLE job_applied 
RENAME COLUMN contact TO contact_name;

 ALTER TABLE job_applied
 ALTER COLUMN contact_name TYPE TEXT;
  ALTER TABLE job_applied 
  DROP COLUMN contact_name;

  DROP TABLE job_applied;

-- DATABASE LOADING


CREATE TABLE public.company_dim
(Company_id INT PRIMARY KEY,
Name TEXT,
Link TEXT,
Link_Google TEXT,
Thumbnail TEXT
);

CREATE TABLE public.skills_dim
(Skill_id INT PRIMARY KEY,
Skill TEXT,
Type TEXT );

CREATE TABLE public.Job_postings_facts
(Job_id INT PRIMARY KEY,
company_id INT,
Job_title_short VARCHAR(255),
Job_title TEXT,
Job_locaton TEXT,
 Job_via TEXT,
 Job_schedule_type TEXT,
job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
     FOREIGN KEY (Company_id) REFERENCES public.company_dim (company_id));

CREATE TABLE public.skills_job_dim
(job_id INT,
SKill_id INT ,
PRIMARY KEY (Job_id,SKill_id),
FOREIGN KEY (Job_id) REFERENCES public.Job_postings_facts (Job_id),
FOREIGN KEY (skill_id)REFERENCES public.skills_dim (Skill_id));

DROP TABLE job_applied;

SELECT job_title AS  Name,
       job_location AS Location,
       job_posted_date AT TIME ZONE 'UTC' 
       AT TIME ZONE 'EST' AS Date_time,
       EXTRACT (DAY FROM job_posted_date) AS DAY
       FROM job_postings_facts
       ORDER BY DAY
       LIMIT 5;
      
    ALTER TABLE job_postings_facts 
    RENAME COLUMN job_locaton TO job_location;


    SELECT 
    count(job_id) AS Job_id_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_facts
WHERE job_title_short = 'Data Engineer'
GROUP BY month
ORDER BY Job_id_count DESC;


 SELECT Job_schedule_type,
        
        SUM(salary_year_avg)/count(salary_year_avg) AS Yearly_avg,
        SUM(salary_hour_avg)/count(salary_hour_avg) AS Hourly_avg
               
        
      FROM 
      job_postings_facts
      WHERE job_posted_date > '01-06-2023'
      GROUP BY job_schedule_type
      ORDER BY job_schedule_type;



      CREATE TABLE Jan_2023_jobs AS
        SELECT  *
        FROM job_postings_facts
        WHERE EXTRACT(MONTH FROM job_posted_date) = '1' 
       
    CREATE TABLE Feb_2023_jobs AS
        SELECT  *
        FROM job_postings_facts
        WHERE EXTRACT(MONTH FROM job_posted_date) = 2 

     CREATE TABLE Mar_2023_jobs AS
        SELECT  *
        FROM job_postings_facts
        WHERE EXTRACT(MONTH FROM job_posted_date) = 3

SELECT 
     COUNT(job_id) AS number_of_jobs,
     CASE When salary_year_avg <100000 THEN 'Low'
     WHEN salary_year_avg >=100000 AND salary_year_avg <= 200000 THEN ' standard'
     WHEN salary_year_avg > 200000 THEN 'High'
     END AS Salary_Discreption_yearly
FROM job_postings_facts
WHERE job_title_short = 'Data Analyst'
GROUP BY Salary_Discreption
ORDER BY number_of_jobs DESC;
        
 

SELECT job_title_short
FROM job_postings_facts
LIMIT 100;


SELECT 
     job_title_short,
     job_location,
     CASE 
         WHEN job_location = 'Anywhere' THEN 'Remote'
         WHEN job_location = 'New York, NY' THEN 'Local'
         ELSE 'Onsite'
         END AS Location_catgory

FROM job_postings_facts;


-- SUBQUERIES AND CTE'S--

SELECT * 
FROM (
    SELECT *
    FROM job_postings_facts
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
    ) AS January_jobs
    LIMIT 200;


--Common Table  Expressions--

WITH January_jobs
AS ( SELECT * 
     FROM job_postings_facts
     WHERE EXTRACT(MONTH FROM job_posted_date)=1)

SELECT *
FROM January_jobs;

-- Problem on Subquerry --

SELECT  name,
        COUNT(name) AS job_count
FROM (SELECT * 
      FROM company_dim C JOIN job_postings_facts J
      ON J.company_id = C.company_id 
      ) 
 GROUP BY name
 ORDER BY job_count DESC
 LIMIT 10;

 SELECT skill ,
        COUNT (skill) AS skill_count
FROM (SELECT * 
      FROM Skills_dim c JOIN skills_job_dim d
      ON d.skill_id = c.skill_id) 
GROUP BY skill
ORDER BY skill_count DESC 
LIMIT 5;

-- Problem on CTE --


WITH job_count AS (SELECT name,
       COUNT(job_title) AS Job_postings_count
FROM company_dim C JOIN Job_postings_facts J 
ON J.company_id = C.company_id
GROUP BY name ) 

SELECT name,
       CASE WHEN Job_postings_count < 10 THEN 'Small'
       WHEN Job_postings_count BETWEEN 10 AND 50 THEN 'Medium'
       WHEN Job_postings_count > 50 THEN 'Large'
       END AS company_size
FROM job_count
ORDER BY Job_postings_count DESC;

/* 
Find the count of the number of remote job postings per skill
-display the top 5 skills by their demand in remote jobs
-Include skill id, name, and count of postings requiring the skill
*/


WITH skill_id_dim AS (
    
SELECT
    skill_id,
    COUNT(job_title) AS Job_count    

FROM 
    skills_job_dim SJD JOIN job_postings_facts JPF
    ON JPF.job_id = SJD.job_id

WHERE 
    job_location = 'Anywhere' AND
    job_title_short = 'Data Analyst'
GROUP BY 
    skill_id
)

SELECT 
    SD.skill_id,
    skill,
    type,
    Job_count
   
FROM 
    skill_id_dim AS SI INNER JOIN skills_dim AS SD
    ON SD.skill_id = SI.skill_id
ORDER BY
    Job_count DESC
LIMIT 5;

--Quarter_01--

CREATE TABLE January_jobs AS (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
);

CREATE TABLE February_jobs AS (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=2
);

CREATE TABLE March_jobs AS (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=3
);

-- Union Operations --

SELECT 
    job_title_short,
    company_id,
    job_location,
    job_posted_date
FROM January_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location,
    job_posted_date
FROM February_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location,
    job_posted_date
FROM March_jobs;

WITH quarter_01 AS 


SELECT 
    Job_title,
    job_location,
    job_posted_date
FROM 
    (SELECT 
    *
FROM January_jobs

UNION ALL

SELECT 
   *
FROM February_jobs

UNION ALL

SELECT 
    *
FROM March_jobs) 
WHERE 
    salary_year_avg > 70000;


--q1--

/* Skill and type for each job for q1 that pay >70000*/

WITH quarter_01 AS ( SELECT 
    *
FROM January_jobs

UNION ALL

SELECT 
   *
FROM February_jobs

UNION ALL

SELECT 
    *
FROM March_jobs
     
),
job_skill_dim AS(
    SELECT
    *
    FROM 
        skills_job_dim SJD JOIN quarter_01 Q1
        ON SJD.job_id = Q1.job_id
    WHERE 
        salary_year_avg > 70000 
        AND job_title_short = 'Data Analyst'
)
SELECT 
    JSD.job_title_short,
    SD.skills,
    SD.type
FROM job_skill_dim JSD JOIN skills_dim SD
ON JSD.skill_id = SD.skill_id;



