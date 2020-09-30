-- Task 1
USE AdventureWorks2012;
GO

-- Task 1.1
-- Вывести на экран список сотрудников которые подавали резюме при трудоустройстве.

SELECT em.BusinessEntityID,
		em.OrganizationLevel,
		em.JobTitle,
		jc.JobCandidateID,
		jc.[Resume]
FROM 
		[AdventureWorks2012].[HumanResources].[Employee] as em 
	INNER JOIN 
		[AdventureWorks2012].[HumanResources].[JobCandidate] as jc
	ON
		em.BusinessEntityID = jc.BusinessEntityID;

-- Task 1.2
-- Вывести на экран названия отделов, в которых работает более 10-ти сотрудников.

SELECT dp.DepartmentID,
		dp.Name,
		COUNT(edh.DepartmentID) as EmpCount
FROM
		[AdventureWorks2012].[HumanResources].[EmployeeDepartmentHistory] as edh
	INNER JOIN 
		[AdventureWorks2012].[HumanResources].[Department] as dp
	ON
		edh.DepartmentID = dp.DepartmentID 
WHERE
	edh.EndDate IS NULL
GROUP BY 
	dp.DepartmentID, dp.Name
HAVING
	COUNT(edh.DepartmentID) > 10;

-- Task 1.3
-- Вывести на экран накопительную сумму часов отпуска по причине болезни (SickLeaveHours) в рамках каждого отдела. 
-- Сумма должна накапливаться по мере трудоустройства сотрудников (HireDate).

SELECT dp.Name,
		em.HireDate,
		em.SickLeaveHours,
		SUM(em.SickLeaveHours) 
			OVER (PARTITION BY dp.Name ORDER BY em.HireDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as AccumulativeSum
FROM
		[AdventureWorks2012].[HumanResources].[Employee] as em
	INNER JOIN
		[AdventureWorks2012].[HumanResources].[EmployeeDepartmentHistory] as edh
	ON
		em.BusinessEntityID = edh.BusinessEntityID
	INNER JOIN 
		[AdventureWorks2012].[HumanResources].[Department] as dp
	ON
		edh.DepartmentID = dp.DepartmentID
GROUP BY 
	dp.Name, em.HireDate, em.SickLeaveHours;
