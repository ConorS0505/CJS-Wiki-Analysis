CREATE TABLE jan20americaviews(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '/home/cjsosh/project1/jan20pageviews/jan20americaviews' INTO TABLE jan20americaviews;

CREATE TABLE jan20notamericaviews(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '/home/cjsosh/project1/jan20pageviews/jan20notamericaviews' INTO TABLE jan20notamericaviews;

SELECT 
	america.page_title AS Page_Title,
	America_Views,
	Not_America_Views
FROM (
	SELECT page_title, SUM(count_views) AS America_Views
	FROM jan20americaviews 
	WHERE (domain_code = 'en' OR domain_code = 'en.m')
	GROUP BY page_title
) america
INNER JOIN (
	SELECT page_title, SUM(count_views) AS Not_America_Views
	FROM jan20notamericaviews 
	WHERE (domain_code = 'en' OR domain_code = 'en.m')
	GROUP BY page_title
) notamerica
ON (america.page_title = notamerica.page_title)
WHERE ((America_Views - Not_America_Views) > 200000)
ORDER BY America_Views DESC;