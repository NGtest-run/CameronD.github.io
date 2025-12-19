SELECT 
*
FROM 
	dbo.engagement_data;

SELECT
	EngagementID,
	ContentID,
	CampaignID,
	ProductID,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) as ContentType,
	LEFT(ViewsClicksCombined, CHARINDEX('-',ViewsClicksCombined)) AS Views, -- Extracts Views
	RIGHT(ViewsClicksCombined, Len(ViewsClicksCombined) - CHARINDEX('-',ViewsClicksCombined) as Clicks, --Extracts Clicks
	Likes,
	-- Converts the date to dd.mm.yyy format
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') as EngagementDate
FROM
	dbo.engagement_data
WHERE
	ContentType != 'Newsletter';