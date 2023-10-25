SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID AS Expr1, Orders.OrderDate, Orders.ShipVia, Orders.Freight, 
                         Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Employees.LastName, Employees.FirstName, Employees.BirthDate, 
                         Products.ProductName, Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


insert into ku
select * from ku
go 9

alter table ku add id int identity


--DB logisches Design
--Normaliserung  
--PK FK ref Integrität
--Redundanz
--Generalisierung


create table t1 (id int identity, spx char(4100)) --woher kommt es dasses 160MB sind

insert into t1 
select 'XY'
GO 20000

---Wie groß ist t1 in etwa?  80MB

dbcc showcontig('ku')
--- Gescannte Seiten.............................: 42774
--- Mittlere Seitendichte (voll).....................: 98.08%

set statistics io, time on --IO = Seiten, Time = Dauer der CPU und Daer der Abfrage

select * from ku where id = 100

dbcc showcontig('t1')
--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%
--SQL legt Daten in Seiten ab
--Seiten haben ein Volumen von 8192bytes
--in Seiten kommen nicht mehr als 700DS
--Max Datenvolumen 8072bytes
--fixe Längen dürfen nicht größér als 8060bytes werden

create table t2 (id int , spx char(4100), SPy char(4100)) --geht nicht


select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku'), NULL,NULL, 'detailed')

--forwardRecordCount sollte 0 oder NULL sein
--Problem kann durch Indies behoben






--Je weniger IO, desto weniger RAM Verbrauch und desto weniger CPU Last

--Mittel zur IO reduzierung
----bessere Datentypen, Tabellen splitten,


select * from employees--datum = datetime

--Orderdate alles aus 1997
select * from orders where orderdate like '%1997%'

select * from orders where year(orderdate) = 1997 --imm eriner SCAN

select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997'--schnell aber eigtl falsch

select * from orders where datepart (yy, orderdate) = 1997


create table t2 (id int identity, spx char(4100))

declare @i as int = 1
begin tran
while @i<=20000
	begin
		insert into t2 (spx) values ('XY')
		set @i+=1
	end
commit





--8 Seiten am Stück = Block  HDD 64 Kb Formatierung

set statistics io, time on
select * from t1 where id = 100 --+ 160MB im RAM wg 20000 Seiten
--, CPU-Zeit = 31 ms, verstrichene Zeit = 59 ms.


--Kompression: Zeilen, Seiten

set statistics io, time on
select * from t1 where id = 100

----Neustart des Server: RAM gleich !
--RAM nach Abfrage: mehr, weniger, oder gleich
--CPU: mehr
--Dauer: weniger

--normalerweise 40 bis 60% Kompression-- t1 von 156MB--> 250kb










































