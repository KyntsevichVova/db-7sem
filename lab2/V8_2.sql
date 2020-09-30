-- Task 2
USE AdventureWorks2012;
GO


-- Task 2.1
-- создайте таблицу dbo.Address с такой же 
-- структурой как Person.Address, кроме полей geography, uniqueidentifier, не включая индексы, ограничения и триггеры;

CREATE TABLE dbo.Address (
	AddressID int,
	AddressLine1 nvarchar(60),
	AddressLine2 nvarchar(60),
	City nvarchar(30),
	StateProvinceID int,
	PostalCode nvarchar(15),
	ModifiedDate datetime
);

-- Task 2.2
-- используя инструкцию ALTER TABLE, добавьте в таблицу dbo.Address новое поле ID с типом данных INT, 
-- имеющее свойство identity с начальным значением 1 и приращением 1. Создайте для нового поля ID ограничение UNIQUE;

ALTER TABLE 
	dbo.Address 
ADD ID int IDENTITY(1, 1);
GO

ALTER TABLE 
	dbo.Address
ADD UNIQUE (ID);
GO

-- Task 2.3
-- используя инструкцию ALTER TABLE, создайте для таблицы dbo.Address ограничение для поля StateProvinceID, 
-- чтобы заполнить его можно было только нечетными числами;

ALTER TABLE 
	dbo.Address
ADD CONSTRAINT 
	StateProvinceID_CHECK CHECK (StateProvinceID % 2 = 1);
GO

-- Task 2.4
-- используя инструкцию ALTER TABLE, создайте для таблицы 
-- dbo.Address ограничение DEFAULT для поля AddressLine2, задайте значение по умолчанию ‘Unknown’;

ALTER TABLE 
	dbo.Address
ADD CONSTRAINT 
	AddressLine2_DEFAULT DEFAULT 'Unknown' FOR AddressLine2;
GO

-- Task 2.5
-- заполните новую таблицу данными из Person.Address. Выберите для вставки только те адреса, где 
-- значение поля Name из таблицы CountryRegion начинается на букву ‘а’. Также исключите данные, где 
-- StateProvinceID содержит четные числа. Заполните поле AddressLine2 значениями по умолчанию;

INSERT INTO dbo.Address (
	AddressID,
	AddressLine1,
	City,
	StateProvinceID,
	PostalCode,
	ModifiedDate
)
SELECT 
	pa.AddressID,
	pa.AddressLine1,
	pa.City,
	pa.StateProvinceID,
	pa.PostalCode,
	pa.ModifiedDate
FROM 
		Person.Address as pa
	INNER JOIN 
		Person.StateProvince as psp
	ON 
		pa.StateProvinceID = psp.StateProvinceID
	INNER JOIN 
		Person.CountryRegion as pcr
	ON 
		psp.CountryRegionCode = psp.CountryRegionCode
WHERE 
	pcr.Name LIKE 'a%' AND psp.StateProvinceID % 2 != 0;
GO

SELECT * FROM dbo.Address;
GO

-- Task 2.6
-- измените поле AddressLine2, запретив вставку null значений.

ALTER TABLE 
	dbo.Address
ALTER COLUMN 
	AddressLine2 nvarchar(60) NOT NULL;
GO