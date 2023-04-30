# SQL-Code
Examples of some work 

Code used to analyze company growth.

```` python

SELECT 
  YEAR(scheduledate) AS Year, 
  SUM(SumOfbillamount) AS TotalRevenue,
  100 * (SUM(SumOfbillamount) - LAG(SUM(SumOfbillamount)) OVER (ORDER BY YEAR(scheduledate))) / LAG(SUM(SumOfbillamount)) OVER (ORDER BY YEAR(scheduledate)) AS company_growth
FROM mosquito_joe.work_orders
GROUP BY YEAR(scheduledate);

````

Code used to break down the most popular streets in Boston for shootings. 

```` python
-- Columns needed for bayes = Shooting, Street 
-- This query sums up the amount of shootings per street in Boston 
-- Washington street made up for 4.18% of total shootings in Boston MA
with shootings_sum as (
SELECT distinct(STREET), sum(SHOOTING) as shootings
FROM crime_data.boston_crime_2021
group by STREET)
select street , (shootings / total_shootings) * 100 as percent
from shootings_sum
-- Cross Joining to get the total number of shootings to divide by each street sum 
cross join (
	select sum(shootings) as total_shootings
	from shootings_sum) as c_j
-- Only want streets that have shootings 
where shootings > 0
order by shootings desc
````

Year over year customer churn 

```` python
 Getting churn year to year   
with 2020_churn as (
SELECT DISTINCT accountnum, Businessname, 2020 as churn_year
FROM mosquito_joe.work_orders
WHERE YEAR(scheduledate) = 2020
  AND accountnum NOT IN (
    SELECT DISTINCT accountnum
    FROM mosquito_joe.work_orders
    WHERE YEAR(scheduledate) = 2021
  ))
,  2021_churn as (SELECT DISTINCT accountnum, Businessname, 2021 as churn_year
FROM mosquito_joe.work_orders
WHERE YEAR(scheduledate) = 2021
  AND accountnum NOT IN (
    SELECT DISTINCT accountnum
    FROM mosquito_joe.work_orders
    WHERE YEAR(scheduledate) = 2022
  ))
,  2022_churn as (SELECT DISTINCT accountnum, Businessname, 2022 as churn_year
FROM mosquito_joe.work_orders
WHERE YEAR(scheduledate) = 2022
  AND accountnum NOT IN (
# have to select the current profiles to see the active and inactive 
    SELECT DISTINCT accountnum
    FROM mosquito_joe.customer_profiles
    WHERE `status` = 'active'
  ))   
,churn_union as (
select * from 2020_churn
UNION ALL 
select * from 2021_churn
UNION ALL 
select * from 2022_churn)
#Joining the data back in 
select customer_profiles.accountname, 
COALESCE(churn_year, '2023') as churn_year, 
customer_profiles.accountnum,
customer_profiles.accountaddress,
customer_profiles.city ,
customer_profiles.state ,
customer_profiles.emailaddress,
customer_profiles.scheduledate ,
customer_profiles.propertytypename,
customer_profiles.postalcode
from churn_union
right join mosquito_joe.customer_profiles on 
churn_union.accountnum = mosquito_joe.customer_profiles.accountnum
````
Code used to explore the number of resprays for Mojo based on raw work order data.

```` python
SELECT w.*, COALESCE(r.number_of_resprays, 0) AS number_of_resprays
FROM mosquito_joe.work_orders w
LEFT JOIN (
  SELECT accountnum, COUNT(*) AS number_of_resprays
  FROM mosquito_joe.work_orders
  WHERE description = 'Re-Spray'
  GROUP BY accountnum
) r ON w.accountnum = r.accountnum
where description != 'Re-Spray';
````




