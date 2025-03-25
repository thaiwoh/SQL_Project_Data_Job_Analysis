/*
What are the most in demand skills for data analysts?
- identify the top 5 in-demand skills for data analyst
--focus on all job postings
--why? retrieves the top 5 skills with the highest demand in the job market, providing
insights into the most valuable skills for job seekers
*/

SELECT 
	skills,
	COUNT(skills) AS demand_count
FROM 
	job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
	job_title_short = "Data Analyst" AND
	job_work_from_home ="True"
GROUP BY 
	skills
ORDER BY 
	demand_count DESC
LIMIT 5	;

/*
Trends in Top-Demanded Data Analyst Skills (2023)
SQL Leads the Market – With 7,291 job postings, SQL remains the most critical skill for data analysts,
 essential for querying and managing structured data.

Excel & Python Are Core Tools – Excel (4,611) is still widely used for reporting,
 while Python (4,330) is rising due to automation, data analysis, and machine learning capabilities.

Data Visualization is Key – Tableau (3,745) and Power BI (2,609) 
show that businesses highly value skills in presenting insights through interactive dashboards.

[
    {
        "demand_count": 7291,
        "skills": "sql"
    },
    {
        "demand_count": 4611,
        "skills": "excel"
    },
    {
        "demand_count": 4330,
        "skills": "python"
    },
    {
        "demand_count": 3745,
        "skills": "tableau"
    },
    {
        "demand_count": 2609,
        "skills": "power bi"
    }
]

*/