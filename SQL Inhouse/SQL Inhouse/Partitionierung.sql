

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







