-- If you hear about a shooting in a news what is the probability it was on washington street in Boston?
-- ( Only using the amount of streets in the dataset to solve for the conditional ) 
-- Bayes theorm states that P(A|B) = P(B|A) * P(A) / P(B)
SELECT * FROM crime_data.boston_crime_2021
limit 10;

-- Table columns printed out 
SHOW COLUMNS FROM crime_data.boston_crime_2021

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

