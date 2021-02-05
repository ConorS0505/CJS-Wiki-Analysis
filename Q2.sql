CREATE TABLE decviews(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '/home/cjsosh/project1/dec7pageviews' INTO TABLE decviews;
LOAD DATA LOCAL INPATH '/home/cjsosh/project1/dec21pageviews' INTO TABLE decviews;

CREATE TABLE decclickstream(
	prev STRING,
	curr STRING,
	type STRING,
	n INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/home/cjsosh/project1/dec-clickstream' INTO TABLE decclickstream;

SELECT
	page_title,
	Total_Views,
	Clicked_Links, 
	(Clicked_Links / Total_Views) * 100 AS Percent_Clicked
FROM (
	SELECT page_title, (SUM(count_views)*15) AS Total_Views
	FROM decviews
	WHERE (domain_code = 'en' OR domain_code = 'en.m')
	GROUP BY page_title
) pageviews
INNER JOIN (
	SELECT prev, type, SUM(n) AS Clicked_Links
	FROM decclickstream
	WHERE type = 'link'
	GROUP BY prev, type
) clickstream
ON (page_title = prev)
WHERE Total_Views > Clicked_Links
AND Total_Views > 100000
ORDER BY Percent_Clicked DESC
LIMIT 20;