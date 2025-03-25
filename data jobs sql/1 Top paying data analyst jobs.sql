/* 
What are the Top Paying Data Analyst Jobs?
- Identify the top 10 highest -paying Data Analyst jobs that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
--Why? Highlight the top paying oppurtunities for Data Analysts
*/

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