INSERT INTO [Employee] ([EmployeeID], [FirstName], [LastName], [Title], [Sequence], [Enabled], [ModifiedBy])
	SELECT newid(), 'Tom', 'Capuano', 'Owner', 1, 1, 'sa'
    UNION ALL
	SELECT newid(), 'Ron', 'Capuano', 'Owner', 2, 1, 'sa'
    UNION ALL
	SELECT newid(), 'Ronda', 'Wilson', 'Manager', 3, 1, 'sa'
    UNION ALL
	SELECT newid(), 'Alysha', 'Workman', 'Barber', 4, 1, 'sa'
    UNION ALL
	SELECT newid(), 'Veronica', 'Six', 'Barber', 5, 1, 'sa'
    UNION ALL
	SELECT newid(), 'Rosemary', 'DeVillers', 'Barber', 6, 0, 'sa'
go

INSERT INTO [Rent] ([RentID], [EmployeeID], [RentPct], [EffectiveTDS], [ModifiedBy])
	select
		newid(),
		e.EmployeeID,
        case 
        	when e.FirstName = 'Tom' then 0.83
        	when e.FirstName = 'Ron' then 0.83
        	when e.FirstName = 'Ronda' then 0.75
        	when e.FirstName = 'Alysha' then 0.73
        	when e.FirstName = 'Veronica' then 0.73
            else 0
        end,
        '01-01-2000 00:00:00',
        'sa'
	from
		Employee e
go

declare @rentid uniqueidentifier
declare empcur cursor for
select r.rentid
from employee e
inner join rent r on r.employeeid = e.employeeid
order by e.sequence;

open empcur
fetch next from empcur into @rentid
while @@FETCH_STATUS = 0
begin
	;WITH d AS 
	(
	  SELECT TOP (6) d = DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY object_id), DATEADD(dd, DATEPART(DW,GETDATE())*-1+1, GETDATE()))
	  FROM sys.all_objects
	)

	insert into DailyGross (DailyGrossID,RentID,Gross,GrossTDS,ModifiedBy,ModifiedTDS)		
		select newid(), @rentid, (RAND(CHECKSUM(NEWID())) * 500), CONVERT(datetime, datediff(day, 0, d)), 'sa', current_timestamp
		from d
		
	fetch next from empcur into @rentid
end
close empcur
deallocate empcur
go