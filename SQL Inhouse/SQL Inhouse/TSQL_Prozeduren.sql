--KU ohne Indizes

select * from ku where id < 2

--NIX_ID ohne eingeschl Spalten  

select * from ku where id < 2

select * from ku where id < 20000 --43014, Table Scan

set statistics io, time on

drop procedure gpdemo1

create or alter proc gpdemo1 @par int
as
select * from ku where id < @par

exec gpdemo1 2
exec gpdemo1 40000

dbcc freeproccache




gpdemo1 900000

select * from ku where id < 900000

select * from Ku 
where 
id < 200000

--
exec gpsucheKunden 'ALK'

select * from customers where customerid like 'ALK%'  --nchar(5)

create or alter  proc gpSucheKunden @kdnr nvarchar(15)  = '%'
as
select * from customers where customerid like @kdnr + '%'

gpSuchekunden 'AL'




