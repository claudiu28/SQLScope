create database model2
go

use model2
go

create table Persoane(
	idPersoana int primary key identity(1,1),
	nume varchar(100) not null,
	gen varchar(20) not null,
	check (gen = 'masculin' or gen = 'feminin'),
	dataNastere date not null
);

create table Copii(
	idCopil int primary key identity(1,1),
	nume varchar(100) not null,
	varsta int not null
);

create table TipuriDeMoneda(
	idTip int primary key identity (1,1),
	tara varchar(100) not null,
	idCopil int not null,
	element varchar(100) not null,
	constraint fk_id_copil_tip foreign key (idCopil) references Copii(idCopil)on delete  cascade
);

create table Monede (
	idMoneda int primary key identity(1,1),
	idTip int not null,
	valoare float not null,
	denumire varchar(100) not null,
	check (denumire = 'euro' or denumire = 'ron'),
	constraint fk_idTip_Monede foreign key (idTip) references TipuriDeMoneda(idTip) on delete cascade
);

create table Utilizare(
	idPersoane int not null,
	idMonede int not null,
	numarMonede int not null,
	utilizare varchar(100) not null,
	constraint pk_utilizare primary key(idPersoane,idMonede),
	constraint fk_id_persoane_utilizare foreign key (idPersoane) references Persoane(idPersoana) on delete cascade,
	constraint fk_id_monede_utilizare foreign key (idMonede) references Monede(idMoneda) on delete cascade
);
go

create procedure ExistaProcedura
	@idPersoana int,
	@idMoneda int,
	@numarMonede int,
	@descriere varchar(100)
as
begin
	if exists(select 1 from Utilizare where Utilizare.idMonede = @idMoneda and Utilizare.idPersoane = @idPersoana)
	begin
		update Utilizare set numarMonede = @numarMonede, utilizare = @descriere
		where Utilizare.idMonede = @idMoneda and Utilizare.idPersoane = @idPersoana;
		print 'Update cu succes';
		return;
	end
	else
	begin
		insert into Utilizare(idMonede,idPersoane,numarMonede,utilizare) values (@idMoneda,@idPersoana,@numarMonede,@descriere)
		print 'Insert cu succes';
		return;
	end
end
go

create view VW_Model
as
select C.nume, C.varsta from Copii as C 
inner join TipuriDeMoneda as T on T.idCopil = C.idCopil 
go

create function FunctieT (@idMoneda int)
returns @tabel table (numePersoane varchar(100))
as
begin
	insert into @tabel select P.nume
	from Persoane as P inner join Utilizare as U on U.idPersoane = P.idPersoana
	where U.idMonede = @idMoneda group by P.nume
	having COUNT(U.idMonede) >= 3
	return;
end
go

insert into Persoane(nume,gen,dataNastere) values 
('Andrei', 'masculin' ,'2000-02-25'),
('Marcus', 'masculin' ,'2001-03-25'),
('Marius', 'masculin' ,'2002-04-27'),
('Jan', 'masculin' ,'2006-10-15'),
('Ionela', 'feminin' ,'2007-12-25'),
('Paul', 'masculin' ,'2001-12-01')

select * from Persoane

insert into Copii(nume,varsta) values
('Andrei', 12),
('Ilie', 10),
('Tudor', 8)

select * from Copii

insert into TipuriDeMoneda(tara,element,idCopil) values
('Italia','Vechi',1),
('Italia','Nou',1),
('Franta','Vechi',2),
('Germania','Vechi',3),
('Romania', 'Nou', 3)

select * from TipuriDeMoneda

insert into Monede(denumire,valoare,idTip) values
('euro', 2.32,1),
('euro', 2.32,2),
('euro', 4.36,3),
('euro', 5.8,4),
('ron', 2.32,5)

select * from Monede

insert into Utilizare(idMonede,idPersoane,numarMonede,utilizare) values
(1,1,4,'mancare'),
(2,1,4,'shopping'),
(3,2,5,'televizor'),
(4,1,1,'zi doi'),
(5,3,10,'vacanta')

select * from Utilizare

select * from VW_Model

select * from FunctieT(1)

exec ExistaProcedura @idPersoana = 7, @idMoneda = 2,
	@numarMonede = 9,
	@descriere = 'D'