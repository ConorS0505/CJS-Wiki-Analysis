CREATE DATABASE projectone;

USE projectone;

CREATE TABLE jan20views(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '/home/cjsosh/project1/jan20pageviews' INTO TABLE jan20views;

SELECT page_title, SUM(count_views) AS Num_Views
FROM jan20views
WHERE (domain_code = 'en' OR domain_code = 'en.m')
GROUP BY page_title
ORDER BY Num_Views DESC
LIMIT 20;