
# Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

select * 
from CITY 
where POPULATION > 100000 and CountryCode = 'USA'

# Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

select NAME
from CITY
where POPULATION > 120000 and COUNTRYCODE = 'USA'

# Query all columns for a city in CITY with the ID 1661.

select * 
from CITY
where ID = 1661

# Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

select * 
from CITY 
where COUNTRYCODE = 'JPN'

# Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

select Distinct(NAME) 
from CITY 
where COUNTRYCODE = 'JPN'

# Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
# MOD(dividend, divisor) mod is used to return the remaineder of a division problem
# In this case we wanted to find all columns that had even ID numbers so the remainder would have to be 0  

SELECT DISTINCT(CITY)
FROM STATION 
WHERE MOD(ID,2)=0;

# Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

select count(CITY) - count(distinct(CITY))
from STATION S;


#Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths 
# (i.e.: number of characters in the name). If there is more than one smallest or largest city, 
# choose the one that comes first when ordered alphabetically.

(select CITY, length(CITY) as city_len 
 from STATION 
 order by city_len asc, CITY asc limit 1) 
UNION
(select CITY, length(city) as city_len 
 from STATION 
 order by city_len desc, CITY asc limit 1);





