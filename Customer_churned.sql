 -- Pulling all customers that churned 
 WITH churned_customers AS (
    SELECT DISTINCT accountnum, `description` AS service
    FROM Project.sprays
    WHERE Date BETWEEN "2021-01-01" AND "2022-01-01" 
    AND description <> "Re-spray" 
    AND accountnum NOT IN (
        SELECT DISTINCT accountnum
        FROM Project.sprays
        WHERE Date BETWEEN "2022-01-01" AND "2023-01-01" AND description <> "Re-spray"
    )
), 
-- Given that we offer two services being natural and synthetic I will now find the % of churned based on service type
churn_count AS (
    SELECT service, COUNT(service) AS num_of_churned  
    FROM churned_customers
    GROUP BY service
)
SELECT 
    service, 
    num_of_churned, 
    num_of_churned / total_churned AS churn_rate
FROM churn_count
CROSS JOIN (
    SELECT COUNT(DISTINCT accountnum) AS total_churned
    FROM churned_customers
) AS t;
