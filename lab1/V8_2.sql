-- Task 2
USE AdventureWorks2012;
GO

-- Task 2.1
-- Вывести на экран холостых сотрудников, которые родились раньше 1960 (включая 1960 год).

SELECT BusinessEntityID,
		BirthDate,
		MaritalStatus,
		Gender,
		HireDate 
FROM [AdventureWorks2012].[HumanResources].[Employee]
WHERE
	YEAR (BirthDate) <= 1960 AND MaritalStatus = 'S';

-- Task 2.2
-- Вывести на экран сотрудников, работающих на позиции ‘Design Engineer’, отсортированных в 
-- порядке убывания принятия их на работу.

SELECT BusinessEntityID,
		JobTitle,
		BirthDate,
		Gender,
		HireDate 
FROM [AdventureWorks2012].[HumanResources].[Employee]
WHERE
	JobTitle = 'Design Engineer'
ORDER BY
	HireDate DESC;

-- Task 2.3
-- Вывести на экран количество лет, отработанных каждым сотрудником отделе ‘Engineering’ ([DepartmentID] = 1). 
-- Если поле EndDate = NULL это значит, что сотрудник работает в отделе по настоящее время.

SELECT BusinessEntityID,
		DepartmentID,
		StartDate,
		EndDate,
		YearsWorked = DATEDIFF(YEAR, StartDate, ISNULL(EndDate, CONVERT(DATE, CURRENT_TIMESTAMP)))
FROM [AdventureWorks2012].[HumanResources].[EmployeeDepartmentHistory]
WHERE
	DepartmentID = 1;