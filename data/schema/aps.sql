CREATE TABLE [Employee] (
  [EmployeeID] uniqueidentifier not null primary key,
  [Name] nvarchar(100) not null,   
  [Title] nvarchar(100) not null, 
  [Sequence] smallint not null,
  [Enabled] bit not null default(1), 
  [ModifiedBy] nvarchar(80) not null, 
  [ModifiedTDS] datetime not null default(getdate())
);

CREATE TABLE [Rent] (
  [RentID] uniqueidentifier not null primary key,
  [EmployeeID] uniqueidentifier not null,
  [RentPct] numeric(5,2) not null, 
  [EffectiveTDS] datetime not null,
  [ModifiedBy] nvarchar(80) not null, 
  [ModifiedTDS] datetime not null default(getdate()),

  constraint [fk_employee] foreign key ([EmployeeID]) references [Employee]([EmployeeID])
);

CREATE TABLE [DailyGross] (
  [DailyGrossID] uniqueidentifier not null primary key,
  [RentID] uniqueidentifier not null,
  [Gross] numeric(12,2) not null, 
  [GrossTDS] datetime not null,
  [ModifiedBy] nvarchar(80) not null, 
  [ModifiedTDS] datetime not null default(getdate()),
  
  constraint [fk_rent] foreign key ([RentID]) references [Rent]([RentID])
);

