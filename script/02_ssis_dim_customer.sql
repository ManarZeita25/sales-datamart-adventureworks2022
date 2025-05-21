
--02_ssis_dim_customer_01_customer
SELECT CustomerID AS customer_id, PersonID
FROM Sales.Customer
WHERE PersonID IS NOT NULL
UNION ALL
SELECT NULL, NULL

--02_ssis_dim_customer_02_customer_all_data
SELECT
	p.BusinessEntityID AS personid,
	CAST( 
		( ISNULL(p.FirstName, '') +' ' + ISNULL(p.MiddleName, '') +' '+ ISNULL(p.LAStName, '') ) 
	AS NVARCHAR(150)) AS customer_name,
	a2.AddressLine1 AS address1,
	a2.AddressLine2 AS address2,
	a2.City,
	-- a2.PostalCode,
	pp.PhoneNumber AS phone
FROM Person.Person AS p
	LEFT JOIN Person.BusinessEntityAddress AS a1 
		ON p.BusinessEntityID = a1.BusinessEntityID and a1.AddressTypeID = 2 -- there are few customers with multiple address types (2,5)
	LEFT JOIN Person.Address AS a2 
		ON a2.AddressID = a1.AddressID 
	LEFT JOIN Person.PersonPhone AS pp
		ON p.BusinessEntityID = pp.BusinessEntityID

--02_dim_customer_03test_scd_setup
USE EO_AdventureWorksDW2014; 

-- delete ~10% of records in dim_customer 
DELETE FROM dim_customer 
WHERE  customer_id % 50 = 2; 

-- update city for ~10% in dim_customer 
UPDATE dim_customer 
SET    city = 'cairo' 
WHERE  city = 'paris'; 

-- update phone number 
UPDATE dim_customer 
SET    phone = Substring(phone, 10, 3) 
               + Substring(phone, 4, 5) + Substring(phone, 9, 1) 
               + Substring(phone, 1, 3) 
WHERE  Len(phone) = 12 
       AND LEFT(phone, 3) BETWEEN '101' AND '125'; 

-- updated records - type 2 
SELECT customer_id, 
       Count(*) 
FROM   dim_customer 
GROUP  BY customer_id 
HAVING Count(*) > 1 

SELECT * 
FROM   dim_customer 
WHERE  customer_id = 11036 

