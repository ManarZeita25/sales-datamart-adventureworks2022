use AdventureWorks2022
--01_ ssis_dim_product_01_select_product
SELECT 
	ProductID AS product_id ,
	Name AS product_name,
	Color,
	ReorderPoint AS reorder_point,
	StandardCost AS standard_cost,
	ProductSubcategoryID,
	ProductModelID
FROM Production.Product

--01_ssis_dim_product_02_Product_Model_and_Description
SELECT
	pm.ProductModelID,
	pm.Name AS model_name,
	pd.Description AS Product_description
FROM [Production].[ProductModel] AS pm
	LEFT JOIN production.ProductModelProductDescriptionCulture AS pdi 
		ON pm.ProductModelID = pdi.ProductModelID
	LEFT JOIN [Production].[ProductDescription] AS pd
		ON pdi.ProductDescriptionID = pd.ProductDescriptionID
WHERE pdi.CultureID = 'en' OR pdi.CultureID IS null
UNION ALL
SELECT null,null,null

--01_ssis_dim_product_03_Product_sub_category_and_category
SELECT
	psc.ProductSubcategoryID,
	psc.Name AS product_subcategory,
	pc.name AS product_category
FROM [Production].[ProductSubcategory] AS psc
	LEFT JOIN [Production].[ProductCategory] AS pc
		ON psc.ProductCategoryID = pc.ProductCategoryID
UNION ALL
SELECT null,null,null

--05_dim_product_test_scd_setup
use EO_AdventureWorksDW2022


-- ============== dim_product  ==============
SELECT COUNT(*) FROM dim_product
;

SELECT 
	product_key, product_key % 10
FROM dim_product
;

-- delete ~10% of records in dim_product
DELETE FROM dim_product WHERE product_key % 10 = 6
;

-- update product color 
UPDATE dim_product SET color = 'Dark-Green' 
WHERE product_key % 10 = 3
;

-- update reorder_point by adding 10% to the original value
UPDATE dim_product SET reorder_point = ROUND(reorder_point * 1.1,0)
WHERE product_key % 10 = 4

--104_ssis_dim_product_01_select_products_all_in_one
SELECT 
	p.ProductID AS product_id ,
	p.Name AS product_name,
	COALESCE(p.Color, 'Unknown') AS color,
	p.ReorderPoint AS reorder_point,
	p.StandardCost AS standard_cost,
	COALESCE(pm.Name, 'Unknown')  AS model_name,
	COALESCE(pd.Description, 'Unknown')  AS Product_description,
	COALESCE(psc.Name, 'Unknown') AS product_subcategory,
	COALESCE(pc.name, 'Unknown') AS product_category

FROM Production.Product AS p
	LEFT JOIN [Production].[ProductModel] AS pm 
		ON p.ProductModelID = pm.ProductModelID
	LEFT JOIN production.ProductModelProductDescriptionCulture AS pdi 
		ON pm.ProductModelID = pdi.ProductModelID
	LEFT JOIN [Production].[ProductDescription] AS pd
		ON pdi.ProductDescriptionID = pd.ProductDescriptionID
	LEFT JOIN [Production].[ProductSubcategory] AS psc 
		ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	LEFT JOIN [Production].[ProductCategory] AS pc
		ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pdi.CultureID = 'en' OR pdi.CultureID IS NULL