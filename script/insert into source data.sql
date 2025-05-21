use AdventureWorks2022
-- Enable identity insert for SalesOrderHeader
SET IDENTITY_INSERT sales.SalesOrderHeader ON;

INSERT INTO sales.SalesOrderHeader
(SalesOrderID, OrderDate, DueDate, ShipDate, CustomerID, BillToAddressID, ShipToAddressID, ShipMethodID)
VALUES
(1, '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', 29565, 850, 921, 5),
(2, '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', 29565, 850, 921, 5),
(3, '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', 29565, 850, 921, 5),
(4, '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', 29565, 850, 921, 5),
(5, '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', '2022-05-31 00:00:00.000', 29565, 850, 921, 5);

-- Disable identity insert for SalesOrderHeader
SET IDENTITY_INSERT sales.SalesOrderHeader OFF;

-- Enable identity insert for SalesOrderDetail
SET IDENTITY_INSERT sales.SalesOrderDetail ON;

INSERT INTO sales.SalesOrderDetail
(SalesOrderID, SalesOrderDetailID, ProductID, OrderQty, UnitPrice, SpecialOfferID)
VALUES
(1, 1, 884, 1, 53.99, 1),
(2, 1, 884, 1, 53.99, 1),
(3, 1, 884, 1, 53.99, 1),
(4, 1, 884, 1, 53.99, 1),
(5, 1, 884, 1, 53.99, 1);

-- Disable identity insert for SalesOrderDetail
SET IDENTITY_INSERT sales.SalesOrderDetail OFF;
