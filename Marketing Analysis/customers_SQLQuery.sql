SELECT
*
FROM dbo.customers;

SELECT
*
FROM dbo.geography;

SELECT
	c.CustomerID,
	c.CustomerName,
	c.Email,
	c.Age,
	g.Country,
	g.City
FROM 
	dbo.customers as c
LEFT JOIN
-- RIGHT JOIN
-- INNER JOIN
-- FULL OUTER JOIN
	dbo.geography as g
ON
	c.GeographyID = g.GeographyID;