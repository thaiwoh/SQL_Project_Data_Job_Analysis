/*
-What are the top skillls based on salary?
-Look at the average salary associated with each skill for data analyst position
-Focuses on roles with specific salaries, regardless of location
-Why? it reveals how different skills impact salary levels for Data Analyst AND
helps identify the most financially rewarding skills to acquire or improve
*/

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

/*
Key Trends in Top-Paying Data Analyst Skills (2023)
Big Data & Cloud Skills Lead – High salaries for PySpark ($208K), Databricks ($141K), Airflow ($126K),
 GCP ($122K) show the demand for large-scale data processing and cloud analytics.

AI & Machine Learning Pay Well – Tools like DataRobot ($155K), Watson ($160K), Scikit-learn ($125K),
 Pandas ($151K), Numpy ($143K) highlight the value of predictive analytics expertise.

DevOps & Programming Add Value – Skills in GitLab ($154K), Bitbucket ($189K), Jenkins ($125K),
 Scala ($124K), Golang ($145K), PostgreSQL ($123K) indicate strong demand for automation and efficient data management.

[
    {
        "average_salary": 208172.0,
        "skills": "pyspark"
    },
    {
        "average_salary": 189155.0,
        "skills": "bitbucket"
    },
    {
        "average_salary": 160515.0,
        "skills": "watson"
    },
    {
        "average_salary": 160515.0,
        "skills": "couchbase"
    },
    {
        "average_salary": 155486.0,
        "skills": "datarobot"
    },
    {
        "average_salary": 154500.0,
        "skills": "gitlab"
    },
    {
        "average_salary": 153750.0,
        "skills": "swift"
    },
    {
        "average_salary": 152777.0,
        "skills": "jupyter"
    },
    {
        "average_salary": 151821.0,
        "skills": "pandas"
    },
    {
        "average_salary": 145000.0,
        "skills": "golang"
    },
    {
        "average_salary": 145000.0,
        "skills": "elasticsearch"
    },
    {
        "average_salary": 143513.0,
        "skills": "numpy"
    },
    {
        "average_salary": 141907.0,
        "skills": "databricks"
    },
    {
        "average_salary": 136508.0,
        "skills": "linux"
    },
    {
        "average_salary": 132500.0,
        "skills": "kubernetes"
    },
    {
        "average_salary": 131162.0,
        "skills": "atlassian"
    },
    {
        "average_salary": 127000.0,
        "skills": "twilio"
    },
    {
        "average_salary": 126103.0,
        "skills": "airflow"
    },
    {
        "average_salary": 125781.0,
        "skills": "scikit-learn"
    },
    {
        "average_salary": 125436.0,
        "skills": "jenkins"
    },
    {
        "average_salary": 125000.0,
        "skills": "notion"
    },
    {
        "average_salary": 124903.0,
        "skills": "scala"
    },
    {
        "average_salary": 123879.0,
        "skills": "postgresql"
    },
    {
        "average_salary": 122500.0,
        "skills": "gcp"
    },
    {
        "average_salary": 121619.0,
        "skills": "microstrategy"
    }
]
*/