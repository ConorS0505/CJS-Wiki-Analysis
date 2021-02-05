
CREATE TABLE decanalytics (
	wiki_db STRING,
	event_entity STRING,
	event_type STRING,
	event_timestamp STRING,
	event_comment STRING,
	event_user_id INT,
	event_user_text_historical STRING,
	event_user_text STRING,
	event_user_blocks_historical STRING,
	event_user_blocks STRING,
	event_user_groups_historical STRING,
	event_user_groups STRING,
	event_user_is_bot_by_historical STRING,
	event_user_is_bot_by STRING,
	event_user_is_created_by_self BOOLEAN,
	event_user_is_created_by_system BOOLEAN,
	event_user_is_created_by_peer BOOLEAN,
	event_user_is_anonymous BOOLEAN, 
	event_user_registration_timestamp STRING,
	event_user_creation_timestamp STRING,
	event_user_first_edit_timestamp STRING,
	event_user_revision_count INT,
	event_user_seconds_since_previous_revision INT,
	page_id INT,
	page_title_historical  STRING,
	page_title  STRING,
	page_namespace_historical INT,
	page_namespace_is_content_historical BOOLEAN,
	page_namespace INT,
	page_namespace_is_content BOOLEAN,
	page_is_redirect BOOLEAN,
	page_is_deleted BOOLEAN,
	page_creation_timestamp STRING,
	page_first_edit_timestamp STRING,
	page_revision_count INT,
	page_seconds_since_previous_revision INT,
	user_id INT,
	user_text_historical STRING,	
	user_text	STRING,
	user_blocks_historical STRING,
	user_blocks	STRING,	
	user_groups_historical	STRING,	
	user_groups	STRING,
	user_is_bot_by_historical STRING,	
	user_is_bot_by	STRING,	
	user_is_created_by_self BOOLEAN,	
	user_is_created_by_system BOOLEAN,
	user_is_created_by_peer BOOLEAN,
	user_is_anonymous BOOLEAN,
	user_registration_timestamp	STRING,
	user_creation_timestamp	STRING,
	user_first_edit_timestamp	STRING,
	revision_id INT,
	revision_parent_id INT, 
	revision_minor_edit BOOLEAN, 
	revision_deleted_parts	STRING,
	revision_deleted_parts_are_suppressed BOOLEAN,
	revision_text_bytes INT, 
	revision_text_bytes_diff INT, 
	revision_text_sha1	STRING,
	revision_content_model	STRING, 
	revision_content_format	STRING, 
	revision_is_deleted_by_page_deletion BOOLEAN,	
	revision_deleted_by_page_deletion_timestamp	STRING, 
	revision_is_identity_reverted BOOLEAN,
	revision_first_identity_reverting_revision_id INT,
	revision_seconds_to_identity_revert INT,
	revision_is_identity_revert BOOLEAN,
	revision_is_from_before_page_creation BOOLEAN,
	revision_tags	STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/home/cjsosh/project1/decanalytics' INTO TABLE decanalytics;

SELECT (AVG(revision_seconds_to_identity_revert) / 86400) AS Average_Revision_Time_In_Days
	FROM decanalytics
	WHERE (event_entity = 'revision' AND
	(event_comment LIKE '%vandalism%' OR event_comment LIKE '%vandalized%'));
-- 1.5929605141054195 Days to get a revision on average

SELECT (AVG(count_views) / 2) AS Average_Views_Per_Day
	FROM decviews;
-- 1.8072096252890826 People view a page per day

-- So, multiplying the average views on a page per day by the number of days it takes to revise a page = 
-- 2.878 (and some change) So roughly 3 people per day will view a vandalised article.