# SQL_Project_Data_Job_Analysis

# Introduction
Dive into the data job market!Focusing on Data Analyst roles, this project contains top paying jobs, in-demand skills, and where high demand meets high salary in data analytics.
#Background
Driven by a desire to navigate the data analyst job market more efficiently, this project was born from the passion to pinpoint top-paid and indemand skills, streamlining others to find optional jobs.
The data is packed with insights on job titles, salaries, locations and essential skills.

### The questions i answered through my SQLqueries were:

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
 
### 2. Skills for top Paying Jobs
To understand what skills are required for the top-paying jobs, i joined the job postings with the skills data, providinginsights into what employers value for high- compensation roles. 
```sql
WITH top_paying_jobs AS (
	SELECT 
		job_id,
		job_title,
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
	LIMIT 10
	)
SELECT 
	top_paying_jobs.*,
	skills
FROM 
	top_paying_jobs
INNER JOIN	
	skills_job_dim
ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
	skills_dim
ON	skills_job_dim.skill_id= skills_dim.skill_id	
ORDER BY 
	salary_year_avg DESC;
 ```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

-**SQL** is leading with a count of 7 postings
-**Python** follows closely with a bold count of 6 postings
-**R** and **Excel** are also highly sought after with a bold count of 5 postings Excel
-**SAS** and **Tableau** with 4 postings

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high  demand 
```sql
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
```
Here's the breakdown of the most demanded skills for data analysis in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation
- **Programming** and **Visualization Tools** like **Phython**, **Tableeau** and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

  | Skills       |   Demand Count |
  |--------------|----------------|
  | SQL          |  7291          |
  | Excel        |  4611          |
  | python       |  4330          |
  | Tableau      |  3745          |
  | Power BI     |  2609          |

*Table of the demand for the Top 5 skills in data analyst job postings*
### 3. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT 
	skills,
	ROUND(AVG(salary_year_avg),0) AS average_salary
FROM 
	job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
	job_title_short = "Data Analyst" AND
	salary_year_avg	IS NOT NULL
	AND job_work_from_home ="True"
GROUP BY 
	skills
ORDER BY 
	average_salary DESC
LIMIT 25	;
```
Here's a breakdown of the results for top paying skills for Data Analysts

-**Big Data & Cloud Skills Lead –** High salaries for PySpark ($208K), Databricks ($141K), Airflow ($126K),GCP ($122K) show the demand for large-scale data processing and cloud analytics.

-**AI & Machine Learning Pay Well –** Tools like DataRobot ($155K), Watson ($160K), Scikit-learn ($125K),Pandas ($151K), Numpy ($143K) highlight the value of predictive analytics expertise.

-**DevOps & Programming Add Value –** Skills in GitLab ($154K), Bitbucket ($189K), Jenkins ($125K), Scala ($124K), Golang ($145K), PostgreSQL ($123K) indicate strong demand for automation and efficient data management.

   | Skills       | Average Salary ($) |
   |--------------|--------------------|
   | Pyspark      |  208,172           |
   | bitbucket    |  189,155           |
   | couchbase    |  160,515           |
   | watson       |  160,515           |
   | datarobot    |  155,486           |
   | gitlab       |  154,500           |
   | jupyter      |  152,777           |
   | pandas       |  151,821           |
   | elasticsearch|  145,000           |
   
   *Table of the average salary for the top 10 paying skills for data analysts

   ### 5. Most Optimal Skill to Learn
   Combining insights from demand and salary data, this query aimed topinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
   WITH skills_demand AS (
	SELECT 
		skills_dim.skill_id,
		skills_dim.skills,
		COUNT(skills) AS demand_count
	FROM 
		job_postings_fact
	INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
	INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
	WHERE 
		job_title_short = "Data Analyst" AND
		salary_year_avg	IS NOT NULL AND
		job_work_from_home ="True"
	GROUP BY 
		skills_dim.skill_id
), avg_salary AS(
	SELECT 
		skills_job_dim.skill_id,
		ROUND(AVG(salary_year_avg),0) AS average_salary
	FROM 
		job_postings_fact
	INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
	INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
	WHERE 
		job_title_short = "Data Analyst" AND
		salary_year_avg	IS NOT NULL
		AND job_work_from_home ="True"
	GROUP BY 
		skills_job_dim.skill_id
)
SELECT
	skills_demand.skill_id,
	skills_demand.skills,
	demand_count,
	average_salary
FROM skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id= avg_salary.skill_id
WHERE
	demand_count > 10
ORDER BY
	average_salary DESC,
	demand_count	
LIMIT 25;
```
   | Skill ID     | Skills     | Demand Count | Average Salary ($)|
   |--------------|--------    |--------------|-------------------|
   | 8            |  go        | 27           | 115,320           |
   | 234          | confluence | 11           | 114,210           |
   | 97           | hadoop     | 22           | 113,193           |
   | 80           | snowflake  | 37           | 112,948           |
   | 74           | azure      | 34           | 111,225           |
   | 77           | bigquery   | 13           | 109,654           |
   | 76           | aws        | 32           | 108,317           |
   | 4            | java       | java         | 106,906           |
   | 194          | ssis       | ssis         | 106,683           |
   | 233          | jira       | jira         | 104,918           |
   
   *Table of the most optimal skills for data analysts sorted by salary
   
   Here's a breakdown of the most optimal skills for Data Analysts in 2023:
- **High-Demand Programmin Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake,Azure,AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis
- **Business intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle,SQL Server, NoSQl) with average salaries ranging from 97,786 to $104,534 reflects the enduring need for data storage, retrieval and management expertise.

  # What i Learned
  Throughout this process, I've improved greatly using SQL toolkit:
- **Complex Query Crafting:** Mastered the art of advanced SQL , merging tables like a pro and wielding WITH clauses for high-level temp table maneuvers.
- **Data Aggregation:** Got so good with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data summarizing strength.
- **Analytical Wizardry:** I leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQl queries.

  # Conclusions
  
  ### Insights
  1. **Top-Paying Data Analysts Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $99,746!
  2. **Skills for Top-Paying Jobs:** High-paying data analyts jobs require advanced proficiancy in SQL, suggesting it's a critical skill for earning a top salary.
  3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
  4. **Skills With Higher Salaries:** Specializes skills, such as SVN and solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
  5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for high average salary, positioning it as one of the most opimal skills for data analysts to learn to 
     maximise their market value.
     
  ### Closing Thoughts
  This projeect enhanced my SQL skills,making me pretty confident in the skils and provided valuable insights into the data analyst job market. The findings from this analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills, This exploration highlights the importance of continous learning and adaptation to emerging trends in the field of data analytics.   
