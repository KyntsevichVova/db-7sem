USE AdventureWorks2012;
GO

CREATE PROCEDURE dbo.XmlToTable(@xml XML)
AS
BEGIN
	SELECT
		xml_data.item.value('@ID', 'INT') AS AddressID,
		xml_data.item.value('(City)[1]', 'NVARCHAR(30)') AS City,
		xml_data.item.value('(Province/@ID)[1]', 'INT') AS StateProvinceID,
		xml_data.item.value('(Province/Region)[1]', 'NVARCHAR(3)') AS CountryRegionCode
	FROM @xml.nodes('/Addresses/Address') AS xml_data(item);
END;

GO

DECLARE @xml XML;
SET @xml = (
	SELECT 
		pa.AddressID AS [@ID],
		pa.City AS [City],
		psp.StateProvinceID AS [Province/@ID],
		psp.CountryRegionCode AS [Province/Region]
	FROM
			Person.[Address] AS pa
		INNER JOIN
			Person.StateProvince AS psp
		ON
			pa.StateProvinceID = psp.StateProvinceID
	FOR XML PATH ('Address'), ROOT ('Addresses')
);

SELECT @xml; 
EXEC dbo.XmlToTable @xml;