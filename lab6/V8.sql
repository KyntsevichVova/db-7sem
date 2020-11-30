USE AdventureWorks2012;
GO

CREATE PROCEDURE dbo.WorkOrdersByMonths(
	@months NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
	SET @sql = '
	SELECT
		DISTINCT [Year], ' + @months + '
	FROM
		(
			SELECT 
				YEAR(wo.DueDate) AS [Year],
				wo.OrderQty,
				[Month] = DATENAME(month, wo.DueDate)
			FROM
				Production.WorkOrder AS wo
		) AS m
	PIVOT (
		SUM(m.OrderQty)
	FOR 
		m.Month IN (' + @months + ')
	) AS pvt';
	EXEC(@sql);
END;

GO

EXECUTE dbo.WorkOrdersByMonths '[January],[February],[March],[April],[May],[June]';