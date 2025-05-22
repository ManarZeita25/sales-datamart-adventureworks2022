
--05_ssis_fact_sales_02_incremental_load_01 sales order header
SELECT
	SalesOrderID,
	SalesOrderNumber,
	CONVERT(date, OrderDate) AS OrderDate,
	CustomerID,
	TerritoryID,
	TaxAmt,
	Freight
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1
AND ModifiedDate >= ? -- user variable, last update date
AND ModifiedDate < ? -- system variabl, StartTime
ORDER BY sales_order_id

--05_ssis_fact_sales_02_incremental_load_02_sales_order_details
SELECT
	sod.SalesOrderID AS SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	ProductID,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal
FROM sales.SalesOrderDetail AS sod
INNER JOIN sales.SalesOrderHeader AS soh
	ON sod.SalesOrderID = soh.SalesOrderID
WHERE OnlineOrderFlag = 1
AND soh.ModifiedDate >= ? -- user variable, last update date
AND soh.ModifiedDate < ? -- system variabl, StartTime
ORDER BY sales_order_id