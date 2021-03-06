INSERT INTO [Employee] ([EmployeeID], [Name], [Title], [Sequence], [Enabled], [ModifiedBy])
	SELECT newid(), 'Tom', 'Owner', 1, 1, 'admin'
    UNION ALL
	SELECT newid(), 'Ronda', 'Manager', 3, 1, 'admin'
    UNION ALL
	SELECT newid(), 'Alysha', 'Barber', 4, 1, 'admin'
    UNION ALL
	SELECT newid(), 'Alva', 'Barber', 5, 1, 'admin'
    UNION ALL
	SELECT newid(), 'Eric', 'Barber', 6, 0, 'admin'
go

INSERT INTO [Rent] ([RentID], [EmployeeID], [RentPct], [EffectiveTDS], [ModifiedBy])
	select
		newid(),
		e.EmployeeID,
        case 
        	when e.Name = 'Tom' then 0.83
        	when e.Name = 'Ronda' then 0.83
        	when e.Name = 'Alva' then 0.73
        	when e.Name = 'Alysha' then 0.73
        	when e.Name = 'Eric' then 0.73
            else 0
        end,
        '01-01-2000 00:00:00',
        'admin'
	from
		Employee e
go