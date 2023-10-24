USE AdventureWorks2014
GO
-- Create New Table
CREATE TABLE [dbo].[MySalesOrderDetail](
[SalesOrderID] [int] NOT NULL,
[SalesOrderDetailID] [int] NOT NULL,
[CarrierTrackingNumber] [nvarchar](25) NULL,
[OrderQty] [smallint] NOT NULL,
[ProductID] [int] NOT NULL,
[SpecialOfferID] [int] NOT NULL,
[UnitPrice] [money] NOT NULL,
[UnitPriceDiscount] [money] NOT NULL,
[LineTotal] [numeric](38, 6) NOT NULL,
[rowguid] [uniqueidentifier] NOT NULL,
[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
-- Create clustered index
CREATE CLUSTERED INDEX [CL_MySalesOrderDetail] ON [dbo].[MySalesOrderDetail]
( [SalesOrderDetailID])
GO
-- Create Sample Data Table
-- WARNING: This Query may run upto 2-10 minutes based on your systems resources
INSERT INTO [dbo].[MySalesOrderDetail]
SELECT [SalesOrderID],[SalesOrderDetailID],[CarrierTrackingNumber],
[OrderQty],[ProductID],[SpecialOfferID],[UnitPrice],
[UnitPriceDiscount],[LineTotal],[rowguid],[ModifiedDate]
FROM Sales.SalesOrderDetail S1
GO 50

-- 2017
ALTER DATABASE [AdventureWorks2017] SET COMPATIBILITY_LEVEL = 120
GO
-- Comparing Regular Index with ColumnStore Index
USE AdventureWorks2014
GO
SET STATISTICS IO, TIME ON
GO
-- Select Table with regular Index
SELECT ProductID, SUM(UnitPrice) SumUnitPrice, AVG(UnitPrice) AvgUnitPrice,
SUM(OrderQty) SumOrderQty, AVG(OrderQty) AvgOrderQty
FROM [dbo].[MySalesOrderDetail]
GROUP BY ProductID
ORDER BY ProductID
GO

--NUN mit 
ALTER DATABASE [AdventureWorks2014] SET COMPATIBILITY_LEVEL = 150