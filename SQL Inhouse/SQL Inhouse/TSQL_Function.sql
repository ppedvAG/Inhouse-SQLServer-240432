USE [master]
GO
ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 160
GO

select * from orders
select * from [order details]

select f(sp) , f(Wert) from f(Wert) where f(Sp) > f(wert)


select dbo.fRngSumme(orderid) ;

create or alter function fRngSumme(@oid int) returns money
as
begin
	return 
		(select sum(unitprice*quantity) 
			from 
					[order details] 
			where 
					orderid = @oid)
	end
GO

select dbo.fRngSumme(10248) --440;

select * from orders
select * from [order details]


select orderid, freight, customerid, dbo.fRngSumme(orderid) as RSumme from orders;
GO 

select * from orders where dbo.fRngSumme(orderid)< 500

--Testen Prüfen..
set statistics io, time on 




select * from customers where left(customerid,1) = 'A'

select * from employees
	where birthdate < dateadd(yy, -65, getdate()






