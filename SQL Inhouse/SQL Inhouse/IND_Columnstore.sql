--INDIZES

/*
Auswirkungen
schneller
wg weniger Lesen

Insert kann länger dauern
IX ist verantwortlich für Zeilensperren

mehr Platz

IX können Tabellen "reparieren"




*/
select * into kunden from customers

begin tran
update kunden		set city = 'Vilsb' where customerid = 'ALFKI'
update customers	set city = 'Vilsb' where customerid = 'ALFKI'
rollback

set statistics io, time on














select id from ku where id = 100-- Table Scan

--Überlege zuerst den GR IX!!!!
select top 3 * from ku --between < > orderdate = CL IX

--NIX_ID
select id from ku where id = 100 --3 Seiten IX Seek


select id, freight from ku where id = 100 --4 Seiten IX Seek mit Lookup
select id, freight from ku where id < 911500-- ab hier ca Tab Scan

--mit NIX_ID_FR haben wir selbst bei 900000 immer noch Seek
--zusammengestzer IX: Problem

select id, freight, COUNTRY from ku where id < 100

select country, city, sum(unitprice*quantity)
from KU
where
	freight =0.02
	OR
	productId  = 2
group by
	country, city
--NIX_FR_PID_incl_CYCI





select * into ku2 from ku

select top 3 * from ku

--where   Berechnung pro 
--Umsatz pro Land und Productname
--die wo vore 1997 und Land ist nicht Austria

select country, productname, sum(unitprice*quantity)
from ku
where
			orderdate < '1.1.1997' and country != 'Austria'
group by 
			country, productname-- 2142,CPU-Zeit = 63 ms, verstrichene Zeit = 100 ms.


select country, productname, sum(unitprice*quantity)
from ku2
where
			--orderdate < '1.1.1997' and country != 'Austria'
			freight = 0.02
group by 
			country, productname



