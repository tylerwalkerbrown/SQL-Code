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

