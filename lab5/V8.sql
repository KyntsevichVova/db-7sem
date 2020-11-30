USE AdventureWorks2012;
GO

-- Создайте scalar-valued функцию, которая будет принимать в качестве входного параметра id подкатегории для продукта 
-- (Production.ProductSubcategory.ProductSubcategoryID) и возвращать количество продуктов указанной подкатегории 
-- (Production.Product).

CREATE FUNCTION Production.subcategoryProductCount(
	@ProductSubcategoryID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @ret INT;
	SELECT 
		@ret = COUNT(*) 
	FROM 
		Production.Product as p
	WHERE
		p.ProductSubcategoryID = @ProductSubcategoryID;
	IF (@ret IS NULL)
		SET @ret = 0;
	RETURN @ret;
END;

GO

-- Создайте inline table-valued функцию, которая будет принимать в качестве входного параметра id подкатегории 
-- для продукта (Production.ProductSubcategory.ProductSubcategoryID), а возвращать список продуктов указанной 
-- подкатегории из Production.Product, стоимость которых более 1000 (StandardCost).

CREATE FUNCTION Production.subcategoryProducts1000(
	@ProductSubcategoryID INT
)
RETURNS TABLE
AS
RETURN (
	SELECT 
		ProductSubcategoryID, ProductID
	FROM
		Production.Product as p
	WHERE
			p.ProductSubcategoryID = @ProductSubcategoryID AND p.StandardCost > 1000
);

GO

-- Вызовите функцию для каждой подкатегории, применив оператор CROSS APPLY. 
-- Вызовите функцию для каждой подкатегории, применив оператор OUTER APPLY.

SELECT
	*
FROM
	Production.ProductSubcategory as ps
	CROSS APPLY
	Production.subcategoryProducts1000(ps.ProductSubcategoryID) as p
ORDER BY
	ps.ProductSubcategoryID;

SELECT
	*
FROM
	Production.ProductSubcategory as ps
	OUTER APPLY
	Production.subcategoryProducts1000(ps.ProductSubcategoryID) as p
ORDER BY
	ps.ProductSubcategoryID;

GO

-- Измените созданную inline table-valued функцию, сделав ее multistatement 
-- table-valued (предварительно сохранив для проверки код создания inline table-valued функции).

CREATE FUNCTION Production.subcategoryProducts(
	@ProductSubcategoryID INT
)
RETURNS @productsResult TABLE(
	ProductSubcategoryID INT,
	ProductID INT
)
AS
BEGIN
	INSERT INTO @productsResult
		SELECT 
			p.ProductSubcategoryID, p.ProductID
		FROM
			Production.Product as p
		WHERE
				p.ProductSubcategoryID = @ProductSubcategoryID AND p.StandardCost > 1000;
	RETURN;
END;