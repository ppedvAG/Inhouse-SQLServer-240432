set statistics time on

select country, city, sum(freight) 
from ku
group by country, city
--CPU-Zeit = 640 ms, verstrichene Zeit = 189 ms.
--, CPU-Zeit = 578 ms, verstrichene Zeit = 95 ms.

--Doppelpfeil: MAXDOP 


select country, city, sum(freight) 
from ku
group by country, city
option (maxdop 4)

