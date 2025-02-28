create database netflix_db
USE  netflix_db;
create  table netflix(
show_id	varchar(6),
type	varchar(10),
title	varchar(150),
director varchar(208),
casts  varchar(1000),	
country	 varchar(150),
date_added	varchar(50),
release_year	int,
rating	varchar(10),
duration	varchar(15),
listed_in	varchar(25),
description	varchar(250)
);

select *from netflix;

select  
count(*) as total_content 
from netflix;

select 
DISTINCT TYPE
from netflix;

# business problems 
--  1. count the number of movies vs tv shows 

select 
type ,
count(*)  as total_content
from netflix
group by type


--  2. find the most common rating for movies and tv shows 
select 
type,
rating,
 COUNT(*),
 RANK() over(partition by type order by COUNT(*)) as ranking 
 
 from netflix 
 group by 1,2
 -- order by 1,3 desc
 
 
 --  3. list all the movies listed in the year (eg.2022)
 
 select *  from netflix 
 WHERE 
 type = 'Movie'
 AND 
 release_year = 2020
 
 --  5. identify the longest movie 
 
 select * from netflix 
 WHERE
 type = 'Movie'
 AND 
 
 duration = (SELECT MAX(duration) from netflix) 
 
 -- 6. find the content added in the last 5 years 
 
 select * from netflix 
 WHERE 
   TO_DATE( date_added , 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years' 
   
   -- 7. find all the movies/tv shows by director 'Rajiv Chilaka'
   
   select * from netflix 
   where 
   director LIKE '%Rajiv chilaka%'
   
   -- 8. list all tv shows with more than 5 seasons 
   
   select * from netflix 
   WHERE 
   type = 'TV Show'
   AND 
      SPLIT_PART(duration, ' ', 1)::numeric > 5 
 
 
 -- 9. COUNT THE NUMBER OF CONTENT ITEM IN EACH GENRE 
 
 SELECT 
 UNNEST(STRING_TO_ARRAY(listed_in, ' , ' ,  )) as genre 
 COUNT(show_id) as total content 
 from netflix 
 group by 1 
 
 -- 10. 
 
 
 select 
 extract (YEAR from  TO_DATE( date_added , 'Month DD, YYYY')) as year,
 COUNT(*)
 
 from netflix
 where 
 country = 'India'
 group by 1 
 
 -- list all the movies that are documentories 


 select * from netflix
 where 
 listed_in  ILIKE '%documentaries%'
 
 
 -- 12. find all the content without a director 
 
 select * from netflix 
 where 
 director IS NULL 
 
 -- 13. find how many movies actor salaman khan appeared last year 10 year !
 
 select * from netflix 
 where 
 casts ILIKE '%salman khan%' 
 AND release_year > extract (YEAR from CURRENT_DATE)  - 10
 

 
 
 






