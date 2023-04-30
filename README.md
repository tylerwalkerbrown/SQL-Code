# SQL-Code
Examples of some work 

```` python

SELECT 
  YEAR(scheduledate) AS Year, 
  SUM(SumOfbillamount) AS TotalRevenue,
  100 * (SUM(SumOfbillamount) - LAG(SUM(SumOfbillamount)) OVER (ORDER BY YEAR(scheduledate))) / LAG(SUM(SumOfbillamount)) OVER (ORDER BY YEAR(scheduledate)) AS company_growth
FROM mosquito_joe.work_orders
GROUP BY YEAR(scheduledate);

````
