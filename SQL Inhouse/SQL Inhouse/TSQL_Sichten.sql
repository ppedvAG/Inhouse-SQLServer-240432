
create table slf (id int, stadt int, land int)

insert into slf
select 1,10,100
UNION ALL
select 2,20,200
UNION ALL
select 3,30,300

select * from slf

create or alter view vslf with schemabinding
as
select id, stadt, fluss from dbo.slf

select * from vslf

alter table slf add fluss int
update slf set fluss = id *1000

alter table slf drop column fluss


select * from vdemo2

select country, count(*) from vdemo2 
group by country

select country, count(*) from customers 
group by country
set statistics io, time on

select country, count(*) from ku
group by country

create or alter view vdemo3 with schemabinding
as
select country, count_big(*) as Anzahl from dbo.ku
group by country

select * from vdemo3


create table hr.test (id int)







