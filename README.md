# SQL_Project_Data_Job_Analysis

# Introduction
Dive into the data job market!Focusing on Data Analyst roles, this project contains top paying jobs, in-demand skills, and where high demand meets high salary in data analytics.
SQL queries? Check them out here [SQL_Project_Data_Job_Analysis_folder]{/SQL_Project_Data_Job_Analysis_folder/}
#Background
Driven by a desire to navigate the data analyst job market more efficiently, this project was born from the passion to pinpoint top-paid and indemand skills, streamlining others to find optional jobs.
The data is packed with insights on job titles, salaries, locations and essential skills.

###The questions i answered through my SQLqueries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What are the most in-demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market,I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **DB Browser for SQLite:** The chosen database management system, ideal for handling the job posting data.
- **Git & GitHub:** Essential for version control and sharing my SQL scriptsband analysis, ensuring collaboration and project tracking

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.Here's how i approached each question:

### 1. Top Paying Data Analyst jobs
To identify the highest-paying roles , I filtered data analyst positions by average yearly salary and location, focusing on remote jobs.This query highlights the paying oppurtunities in the field
```sql
SELECT 
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	job_posted_date,
	salary_year_avg,
	name AS company_name
FROM 
	job_postings_fact 
LEFT JOIN company_dim 
	ON job_postings_fact.company_id = company_dim.company_id	
WHERE 
	job_title_short = "Data Analyst" AND
	job_location = "Anywhere" AND
	salary_year_avg IS NOT NULL
ORDER BY
		salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top 10 data analyst jobsin 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $97,000 to $99,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Calbright College,Ogletree Deakins,Get It Recruit - Information Technology are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Research Data Analyst to Senior Earth Observation Data Analyst, reflecting varied roles and specializations within data analytics.
![Top paying skills](https://files.oaiusercontent.com/file-L2PrvdPvVTRfZzB4Jj5TMp?se=2025-03-24T22%3A22%3A45Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D299%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D558aed03-a7aa-4233-9c41-d699938125f0&sig=dgqmsGGNpChqEe1oUQmchqC6z2k0QwlZyYCwh94srug%3D)
*Bar graph visualizing the saliries for the Top 10 salaries for Data Analyst;Chat Gpt generated this graph from my SQL query results*



