SELECT
*
FROM dbo.customer_journey;

-- Common Table expression (CTE) to identify and tag duplicate records
WITH DuplicateRecords AS (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		-- USE ROW_NUMBER to assign a unique row muner to each record
		ROW_NUMBER() OVER (
			--PARTITION BY groups the rows based on specified coloms that should be unique
			PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
			-- ORDER BY defines how to order rows (Usually by unique identifier )
			ORDER BY JourneyID
		) as row_num
	FROM
		dbo.customer_journey
)

SELECT
*
FROM DuplicateRecords
WHERE row_num > 1  -- Indicates duplicate rows 
ORDER BY JourneyID;

SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration) as Duration -- Replaces missing durations with avg duration
FROM
	(
	--Subquery to process and clean data
SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	UPPER(Stage) AS Stage,
	Action,
	Duration,
	AVG(Duration) OVER (PARTITION BY VisitDate) as avg_duration,
	ROW_NUMBER () OVER (
		PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
			-- ORDER BY defines how to order rows (Usually by unique identifier )
		ORDER BY JourneyID
	) AS row_num
FROM
	dbo.customer_Journey
	) AS subquery
WHERE
	row_num = 1;
