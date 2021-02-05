CREATE TABLE decviews(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

CREATE TABLE decclickstream(
	prev STRING,
	curr STRING,
	type STRING,
	n INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

SELECT SUM(count_views) * 15 AS Num_Views
FROM decviews
WHERE (domain_code = 'en' OR domain_code = 'en.m')
AND page_title = 'Hotel_California';
-- (4,123 x 15) = 61,845 people get to Hotel California
SELECT type, SUM(n)
FROM decclickstream 
WHERE prev = 'Hotel_California'
GROUP BY type;
-- 13,663 click an internal link
SELECT *
FROM decclickstream
WHERE prev = 'Hotel_California'
ORDER BY n DESC
LIMIT 5;
-- Top 5 contains 7625 visitors: About 56% of the traffic that clicked internal links
--									and is about 12% of the total traffic
--	Name							| Visitors | Percent of Internal | Percent of Total
--	Hotel_California_(Eagles_album) | 2371 	   |	17.35			 | 3.83 <-- We'll use this
--	Don_Felder 						| 1511 	   |	11.06			 | 2.44
--	Eagles_(band) 					| 1404 	   |	10.27			 | 2.27
--	Don_Henley 						| 1370 	   |	10.03			 | 2.22
--	Glenn_Frey 						| 969  	   |	7.09			 | 1.57


SELECT SUM(count_views) * 15 AS Num_Views
FROM decviews
WHERE (domain_code = 'en' OR domain_code = 'en.m')
AND page_title = 'Hotel_California_(Eagles_album)';
-- (2,287 x 15) = 34,305 people get to the album Hotel California
SELECT type, SUM(n)
FROM decclickstream 
WHERE prev = 'Hotel_California_(Eagles_album)'
GROUP BY type;
-- 12,246 click an internal link
SELECT *
FROM decclickstream
WHERE prev = 'Hotel_California_(Eagles_album)'
ORDER BY n DESC
LIMIT 5;
-- Top 5 contains 6,780 visitors: About 55% of the traffic that clicked internal links
--									and is about 20% of the total traffic
-- Name								| Visitors	| Percent of Internal	| Percent of Total
-- Hotel_California					|	2375	|	19.39				|	6.92
-- The_Long_Run_(album) 			|	2104	|	17.18				|	6.13 <-- We'll take this (Going to H.C. again is a loop)
-- Their_Greatest_Hits_(1971–1975) 	|	907		|	7.41				|	2.64
-- Eagles_(band) 					|	900		|	7.35				|	2.62
-- The_Beverly_Hills_Hotel 			|	494		|	4.03				|	1.44


SELECT SUM(count_views) * 15 AS Num_Views
FROM decviews
WHERE (domain_code = 'en' OR domain_code = 'en.m')
AND page_title = 'The_Long_Run_(album)';
-- (832 x 15) = 12,480 people get to the album The Long Run
SELECT type, SUM(n)
FROM decclickstream 
WHERE prev = 'The_Long_Run_(album)'
GROUP BY type;
-- 5,133 click an internal link
SELECT *
FROM decclickstream
WHERE prev = 'The_Long_Run_(album)'
ORDER BY n DESC
LIMIT 5;
-- Top 5 contains 3,049 visitors: About about 59% of the traffic that clicked internal links
--									and is about 24% of the total traffic
-- Name								| Visitors	|	Percent of Internal	|	Percent of Total
-- Eagles_Live						|	1415	|		27.57			|		11.34 <-- Good, a new article.
-- Hotel_California_(Eagles_album)	|	644		|		12.55			|		5.16
-- I_Can't_Tell_You_Why				|	360		|		7.01			|		2.88
-- Heartache_Tonight				|	338		|		6.58			|		2.71
-- The_Long_Run_(song) 				|	292		|		5.69			|		2.34


SELECT SUM(count_views) * 15 AS Num_Views
FROM decviews
WHERE (domain_code = 'en' OR domain_code = 'en.m')
AND page_title = 'Eagles_Live';
-- (348 x 15) = 5,220 people get to the Eagles Live page (Yikes)
SELECT type, SUM(n) AS Click_Link
FROM decclickstream
WHERE prev = 'Eagles_Live'
GROUP BY type;
-- 2,113 click an internal link
-- 40.48% of the total click an internal link

-- Final equation:
-- (2,371 / 61,845) * (2,104 / 34,305) * (1,415 / 12,480) * (2,113 / 5,220) ~= 0.0108%
-- Hotel California   Eagles Album       The Long Run       Eagles Live
--                                 TO
-- Eagles Album       The Long Run       Eagles Live         NULL
