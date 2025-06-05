create database model1
go
use model1
go

create table Planete(
	idPlaneta int primary key identity(1,1),
	nume varchar(100) not null,
	descriere varchar(1000) not null,
	distantaSoare float not null,
	distantaPamant float not null
);

create table Sateliti(
	idSatelit int primary key identity(1,1),
	idPlaneta int not null,
	constraint fk_idPlaneta_sateliti foreign key (idPlaneta) references Planete(idPlaneta) on delete cascade,
	denumire varchar(100) not null,
	marime float not null,
	specific varchar(100) not null
)

create table RociPredominante(
	idRoca int primary key identity(1,1),
	denumire varchar(100) not null,
	duritate int not null,
	an int not null,
	idPlaneta int not null,
	constraint fk_idPlaneta_roci foreign key (idPlaneta) references Planete(idPlaneta) on delete cascade
);

create table Exploratori(
	idExplorator int primary key identity(1,1),
	nume varchar(100) not null,
	gen varchar(10) not null,
	dataNastere date not null
);

create table Misiune(
	idPlaneta int not null ,
	constraint fk_idPlaneta_misiune foreign key (idPlaneta) references Planete(idPlaneta) on delete cascade,
	idExplorator int not null,
	constraint fk_idExplorator_misiune foreign key (idExplorator) references Exploratori(idExplorator) on delete cascade,
	constraint pk_misiune primary key (idPlaneta,idExplorator),
	dataMisiune date not null,
	descriere varchar(1000) not null
);


insert into Sateliti(denumire,marime,specific,idPlaneta) values 
('Appolo1', 200, 'observare', 1),
('Appolo2', 300, 'parcurgere', 2),
('Appolo3', 400, 'observare', 1)
go

select * from Sateliti;


insert into Planete(nume,descriere,distantaSoare,distantaPamant) values 
('Jupiter', 'Planeta mare', 4000.5, 3000),
('Saturn', 'Planeta medie', 2000.5, 1000),
('Pluto', 'Planeta mica', 1050.8, 2000)

go

insert into RociPredominante(denumire,duritate,an,idPlaneta) values 
('ursuRoca', 5000, 1000, 1),
('dolRoca', 4000, 50, 2),
('polRoca', 2000, 500, 3)
go

select * from RociPredominante

insert into Exploratori(nume,gen,dataNastere) values 
('Andrei', 'Masculin', '2024-03-28'),
('Ionel', 'Masculin', '2021-05-28'),
('Jan', 'Masculin', '2004-03-23'),
('Paula', 'Feminin', '2005-03-21'),
('Toni', 'Masculin', '2006-02-22'),
('Alinusa', 'Feminin', '2017-10-28')
go
select * from Exploratori


insert into Misiune(idPlaneta,idExplorator,dataMisiune,descriere) values
(1,1,'2026-09-18','Catre Jupiter'),
(2,2,'2025-10-28','Expeditie'),
(3,3,'2021-11-18','Cercetare'),
(1,4,'2022-09-18','Observare'),
(2,5,'2023-03-18','Cautare si joaca pe planeta'),
(3,6,'2021-07-18','Vedem pluto')

select * from Misiune
go
create procedure Procedura
	@idExplorator int,
	@idPlaneta int,
	@dataMisiune date,
	@descriere varchar(100)
as
begin
	if exists (select * from Misiune where Misiune.idPlaneta = @idPlaneta and Misiune.idExplorator = @idExplorator)
	begin
		update Misiune set Misiune.dataMisiune = @dataMisiune,
		Misiune.descriere = @descriere where Misiune.idPlaneta = @idPlaneta and Misiune.idExplorator = @idExplorator
		Print 'UPDATE CU SUCCES'
		return;
	end
	else begin
		insert into Misiune(idPlaneta,idExplorator,descriere,dataMisiune) values (@idPlaneta,@idExplorator,@descriere,@dataMisiune)
		print 'INSERT CU SUCCES'
		RETURN
	end
end
go

EXEC Procedura @idExplorator = 1, @idPlaneta = 1, @dataMisiune = '1900-02-20', @descriere = 'Update catre jupiter'

EXEC Procedura @idExplorator = 1, @idPlaneta = 3, @dataMisiune = '1900-02-20', @descriere = 'Insert catre pluto'
go

create view VWSateliti
as
	select P.nume as DENUMIRE_PLANETA,S.denumire as DENUMIRE_SATELIT, S.marime, S.specific from Planete as P inner join Sateliti as S on P.idPlaneta = S.idPlaneta
go
select * from VWSateliti
go

CREATE FUNCTION fn_MisiuniCuMultiExploratori (@NrMinExploratori INT)
RETURNS @Misiuni TABLE (
    idPlaneta INT,
    NumePlaneta VARCHAR(100),
    NrExploratori INT
)
AS
BEGIN
    INSERT INTO @Misiuni
    SELECT m.idPlaneta, p.nume, COUNT(DISTINCT m.idExplorator) AS NrExploratori
    FROM Misiune m
    JOIN Planete p ON m.idPlaneta = p.idPlaneta
    GROUP BY m.idPlaneta, p.nume
    HAVING COUNT(DISTINCT m.idExplorator) >= @NrMinExploratori;

    RETURN;
END;
go
SELECT * FROM dbo.fn_MisiuniCuMultiExploratori(2);