--05_ssis_fact_sales_01_full_load_01 sales order header
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
ORDER BY SalesOrderID

--05_ssis_fact_sales_01_full_load_02_sales_order_details
SELECT
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	ProductID,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal
FROM sales.SalesOrderDetail
ORDER BY SalesOrderID



--05_ssis_fact_sales_03_LKP_dim_customer
SELECT
	customer_key,
	customer_id
FROM dim_customer
WHERE is_current = 1

--05_ssis_fact_sales_04_LKP_dim_product
SELECT
	product_key,
	product_id,
	standard_cost
FROM dim_product
WHERE is_current = 1

--05_ssis_fact_sales_05_LKP_dim_territory
SELECT
	territory_key,
	territory_id
FROM dim_territory
WHERE is_current = 1

--05_ssis_fact_sales_06_LKP_dim_Date
SELECT
	date_key AS order_date_key,
	full_date
FROM dim_date


---