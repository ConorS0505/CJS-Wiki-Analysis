CREATE TABLE decviews(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

CREATE TABLE jan20views(
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
TBLPROPERTIES("skip.header.line.count"="1");

SELECT december.page_title, Dec_Views, Jan_Views
FROM (
	SELECT page_title, SUM(count_views) * 15 AS Dec_Views 
	FROM decviews 
	WHERE page_title IN('Undertale', 'Yakuza_0', 'Risk_of_Rain_2')
	GROUP BY page_title
) december
INNER JOIN( 
	SELECT page_title, SUM(count_views) * 30 AS Jan_Views
	FROM jan20views 
	WHERE page_title IN('Undertale', 'Yakuza_0', 'Risk_of_Rain_2')
	GROUP BY page_title
) january
ON january.page_title = december.page_title;
