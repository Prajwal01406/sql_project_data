# Introduction 

Dive into  the data job market! Focusing on **data analyst roles**, this project explores top - paying jobs, in-demand skills and where high demand meets high salary in data analystics.

The **SQL querries** are specified here [sql_project_folder](/Project/).


# Background 
This project was started due to the curiosity to find navigate the data analyst job market and find the best and **optimal job** that a person can get and learning the **skills** for the same.

The details for this course hails from [Luke Barousse](https://www.linkedin.com/in/luke-b/) and I am grateful to him for providing such knowledge.

## Questions I wanted to answer to -
1. What are the top-paying **data analyst** jobs?
2. What skills are required for these **top-paying** jobs?
3. What skills are most **in demand** for data analysts?

4. Which skills are associated with **higher salaries** ?
5. What are the most **Optimal** skills to learn?


# Tools I Used
For finding the answers to the above queations I used the following tools-

1. **SQL** - The backbone of my analysis, allowing me to query the database and bringout critical insights.
2. **PostgreSQL** - The chosen and in demand database management system.
3. **Visual Studio Code** - My go-to for database management and executing SQL querries.
4. **Git & Github** - For sharing my insights with other curious souls and for ensuring project tracking. 

# The Analysis 

1. ## What are the top 10 highest paying Data Analyst jobs(remote)?

To Identify the top paying jobs I wrote the following querry -
```sql
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
```
## Here are the top-paying remote data analyst jobs
| Company                          | Job Title                                    | Amount (USD) |
|----------------------------------|----------------------------------------------|--------------|
| Mantys                           | Data Analyst                                 | $650,000     |
| Meta                             | Director of Analytics                        | $336,500     |
| AT&T                             | Associate Director- Data Insights            | $255,829.50  |
| Pinterest Job Advertisements     | Data Analyst, Marketing                      | $232,423     |
| UCLA Healthcare                  | Data Analyst (Hybrid/Remote)                 | $217,000     |
| SmartAsset                       | Principal Data Analyst (Remote)              | $205,000     |
| Inclusively                      | Director, Data Analyst - HYBRID              | $189,309     |
| Motional                         | Principal Data Analyst, AV Performance Analysis | $189,000  |
| SmartAsset                       | Principal Data Analyst                       | $186,000     |
| Get It Recruit - Information Technology | ERM Data Analyst                    | $184,000     |

2. ## What skills are required for top paying Data Anayst jobs?

To identify the skills that are required for a top paying Data analyst Job the following querry was used -
```sql 
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
``` 

Here are the insights that we get from the above querry 

| Tool        | Frequency |
|-------------|--------|
| SQL         | 8      |
| Python      | 7      |
| Tableau     | 6      |
| R           | 4      |
| Snowflake   | 3      |
| Pandas      | 3      |
| Excel       | 3      |
| Azure       | 2      |
| Bitbucket   | 2      |
| Go          | 2      |


AS we can see **SQL** and **Python** are the top paying skills for a Data Analyst Job.

3. ## What are the most in-demand skills for data analysts (remote job)?

Here we focus on finding how much **demand**(job_postings)  does a skill have and what are the skills that have the **highest demand**, for this we use the following querry 
```sql
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
```

Here are the insights for the above querry
| Skill   | Job Demand Count |
|---------|------------------|
| SQL     | 7,291            |
| Excel   | 4,611            |
| Python  | 4,330            |
| Tableau | 3,745            |
| Power BI| 2,609            |
| R       | 2,142            |
| SAS     | 933              |
| Looker  | 868              |
| Azure   | 821              |

As we can clearly see that **SQL**, **Excel** and **Python** have the most demand in the Data Analyst job market.

4. ##What are the top skills for Data Analyst based on salary?

For this question we focus on skills that pay the highest salary for a data analyst, the following querry was used-
```sql
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
```

Here are the insights in to the results of the above querry

| Skill       | Salary (USD) |
|-------------|--------------|
| SVN         | $400,000     |
| Solidity    | $179,000     |
| Couchbase   | $160,515     |
| DataRobot   | $155,486     |
| Golang      | $155,000     |
| Mxnet       | $149,000     |
| Dplyr       | $147,633     |
| VMware      | $147,500     |
| Terraform   | $146,734     |
| Twilio      | $138,500     |


We see that **SVN** and **Solidity** rank top among the top paying skills for Data Analyst.

5. ## what is the most optimal skill for data analyst job? 

This question focuses on the skills that are In - Demand as well as High Paying and for bringing out such skill the following querry was used-

```sql
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
``` 

Here are the insights into the results of the above querry
| Skill       | Salary (USD) | Job Demand Count |
|-------------|--------------|------------------|
| Go          | $115,320     | 27               |
| Snowflake   | $112,948     | 37               |
| Azure       | $111,225     | 34               |
| AWS         | $108,317     | 32               |
| Oracle      | $104,534     | 37               |
| Looker      | $103,795     | 49               |
| Python      | $101,397     | 236              |
| R           | $100,499     | 148              |
| Tableau     | $99,288      | 230              |
| SAS         | $98,902      | 63               |
| SQL Server  | $97,786      | 35               |
| Power BI    | $97,431      | 110              |
| SQL         | $97,237      | 398              |
| Flow        | $97,200      | 28               |
| PowerPoint  | $88,701      | 58               |
| Excel       | $87,288      | 256              |
| Sheets      | $86,088      | 32              

**Go** and **Snowflake** ranks top the lead in this final round.

# What I learned 

Throughout this adventure, I have gained a lot of experience and knowledge regarding SQL and Databases, I was able to do-

- **Complex Query Crafting** - Mastered advanced SQL I was able to **merge tables** like a pro and get all the data that I was searching for with minimal errors in the process.

- **Data Aggregation** - got familier with **GROUP BY** and **HAVING** clause and successfully applied functions such and **COUNT(),AVG()** and **ROUND()** 

- **Analytical Wizardary** - leveled up my real-world puzzle-solving skills and was able to find answers to all the questions and found insights for the same with the help of SQL.

# Conclusion

### From the analysis several general insights emerged-

1. **Top Paying Jobs** - We find out that the top paying jobs for data analyst range from $500,000 to wooping $650,000.

2. **Top paying Job Skill** - We find out that the skills that pays the highest for a Data analyst job is SQL.

3. **Top Demanded Skills** - We find out that the data analyst job market has a high demand for SQl, EXCEL and PYTHON.

4. **Top Salary Skill** - We find out that specialized skills such as SVN and SOLIDITY have the highest average salary.

5. **Most Optimal Skill** - For a data analyst in 2023 the most optimal skill was GO.

### Closing thoughts 

This project enhanced my Data analysis skills and increased my proficiency in various tools such as SQL, PostgreSQl, Visual Studio Code and Git. I was able to analysis all the different in demand skills for a data analyst in 2023 and these valuable insights will help many in finding the best career path and learning skills that actually matter.
