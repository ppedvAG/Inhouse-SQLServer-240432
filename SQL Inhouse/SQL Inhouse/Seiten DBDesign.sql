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


--A 10000 DS 
--B 1000000 DS

--Abfrage, die immer 10 Ergebniszeilen
--A oder B 
--A

create table u2023(id int, jahr int, spx int)

create table u2022(id int, jahr int, spx int)


create table u2021(id int, jahr int, spx int)

create table u2020(id int, jahr int, spx int)

--Anwendung

select * from umsatz

create view Umsatz
as
select * from u2023
UNION ALL
select * from u2022
UNION ALL
select * from u2021
UNION ALL
select * from u2020



select * from umsatz where jahr = 2023




--f()

------------------100]--------------------------200]---------------------------int
--       1                     2                                    3


create partition function fzahl(int)
as
range left for values(100,200)

select $partition.fzahl(117) --2

--Dgruppen

create table tx(id int) on PRIMARY

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis100daten', FILENAME = N'C:\_SQLDATA\bis100daten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis200daten', FILENAME = N'C:\_SQLDATA\bis200daten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis5000', FILENAME = N'C:\_SQLDATA\bis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'restdaten', FILENAME = N'C:\_SQLDATA\restdaten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO


create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
--                      1    2     3


create table messdaten (id int) on HOT

create table ptab (id int identity, nummer int, spx char(4100)) 
on 
	schZahl(nummer) --auf PartSchema legen


declare @i as int = 1

while @i<= 20000
begin
	insert into ptab select @i,'XY'
	set @i+=1
end



set statistics io, time on
select * from ptab where id=117
select * from ptab where nummer = 117


-----------100-------200-------------------------5000------------------------------------
--DGruppe: weitere Dgruppe (bis5000)
--F() neue Grenze
--Scheme : neue DGruppe
--Tabelle: nee nie nada never

--zuerst scheme
alter partition scheme schZahl next used bis5000

select $partition.fzahl(nummer), min(nummer), max(nummer), count(*) from ptab
group by $partition.fzahl(nummer)

--------100-----200split 

alter partition function fzahl()  split range(5000)

---x100x-----200----5000-----

--Dgruppen:nix
--F(): ja
--Scheme: ne
--Tabelle: ne


alter partition function fzahl()  merge range(100)


select * from ptab where nummer = 6666



CREATE PARTITION FUNCTION [fzahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO

CREATE PARTITION SCHEME [schZahl] AS PARTITION [fzahl] TO ([bis200], [bis5000], [rest])
GO

create table archiv(id int not null, nummer int, spx char(4100)) on bis200

alter table ptab switch partition 1 to archiv
select * from archiv

--HDD 100MB/sek   Part1 1000000000000000000000000000MB 

create partition function fNamen varchar(50)
as
RANGE LEFT for Values ('N','R')

--AbisM   N-R   S-Z


-------M]-----------------S]----------------------------

create partition function fNamen datetime
as
RANGE LEFT for Values ('31.12.2023 23:59:59.997','')



create partition scheme schx
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])

















































