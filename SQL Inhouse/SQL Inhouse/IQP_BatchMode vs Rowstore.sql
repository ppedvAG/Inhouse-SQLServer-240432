USE NwindBig
GO
set statistics io, time on
-- Row mode due to hint
SELECT Customerid, Employeeid, sum(freight), count(Shipvia)
FROM orders
WHERE orderdate <= DATEADD(dd, -73, '19971113')
GROUP BY customerid,
	Employeeid	
ORDER BY customerid,
	Employeeid
OPTION (RECOMPILE, USE HINT('DISALLOW_BATCH_MODE'));