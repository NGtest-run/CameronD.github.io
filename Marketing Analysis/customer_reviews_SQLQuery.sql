SELECT 
*
FROM dbo.customer_reviews;

SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	--Replaces double spaaces with single spaces
	REPLACE(ReviewText,'  ',' ') AS ReviewText
FROM
	dbo.customer_reviews;