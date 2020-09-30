-- Task 1

USE master;
GO

CREATE DATABASE Vladimir_Kuntsevich;
GO

USE Vladimir_Kuntsevich;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA persons;
GO

CREATE TABLE sales.Orders (
	OrderNum INT NULL
);
GO

BACKUP DATABASE Vladimir_Kuntsevich TO DISK = 'D:\DB\lab1\Vladimir_Kuntsevich.bak';
GO

USE master;
GO

DROP DATABASE Vladimir_Kuntsevich;
GO

RESTORE DATABASE Vladimir_Kuntsevich FROM DISK = 'D:\DB\lab1\Vladimir_Kuntsevich.bak';
GO