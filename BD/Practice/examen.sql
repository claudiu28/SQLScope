create database examen
go

use examen
go

create table tipuri(
	idTip int primary key identity(1,1),
	nume varchar(100) not null,
	modUtilizare varchar(100) not null
);

select * from tipuri

insert into tipuri(nume, modUtilizare) values ('nume1', 'mod1'), ('nume2', 'mod2'), ('nume3', 'mod3')

create table producatori(
	idProducator int primary key identity(1,1),
	nume varchar(100) not null,
	descriere varchar(100) not null,
	website varchar(1000) not null,
	numarTelefon varchar(10) not null
);

select * from producatori
--delete from producatori
--DBCC CHECKIDENT ('producatori', RESEED, 0);

insert into producatori(nume,descriere,website,numarTelefon) values ('producator1', 'descreireProd1', 'www.prod_1.ro', '0774567123'),
('producator2', 'descreireProd2', 'www.prod_2.ro', '0724567123'),
('producator3', 'descreireProd3', 'www.prod_3.ro', '0734567123')

create table bureti(
	idBurete int primary key identity(1,1),
	nume varchar(100) not null,
	descriere varchar(100) not null,
	an int not null,
	lungime int not null,
	latime int not null,
	inaltime int not null,
	pret float not null,
	idProducator int not null,
	constraint fk_producator_bureti foreign key (idProducator) references producatori(idProducator) on delete cascade,
	idTip int not null,
	constraint fk_tip_bureti foreign key (idTip) references tipuri(idTip) on delete cascade
);

insert into bureti(nume,descriere,an,lungime,latime,inaltime,pret,idProducator,idTip) values
('burete1', 'descriereBurete1', 2024, 12, 3, 4, 20.5, 1, 1),
('burete2', 'descriereBurete2', 2024, 13, 2, 3, 10.5, 1, 2),
('burete3', 'descriereBurete3', 2024, 1, 13, 5, 21, 2, 3),
('burete4', 'descriereBurete4', 2024, 3, 2, 6, 15, 3, 2)

select * from bureti

create table materiale(
	idMaterial int primary key identity(1,1),
	nume varchar(100) not null,
	nivelElasticitate int not null,
	check (nivelElasticitate between 1 and 10)
);
select * from materiale
insert into materiale(nume,nivelElasticitate) values ('matriale1', 2),
('matriale3', 3),
('matriale2', 4),
('matriale4', 5),
('matriale5', 2),
('matriale6', 8)

create table confectionare(
	idMaterial int not null,
	idBurete int not null,
	procent int not null,
	check(procent between 1 and 100),
	constraint pk_confectionare primary key (idMaterial,idBurete),
	constraint fk_material_confectionare foreign key (idMaterial) references materiale(idMaterial),
	constraint fk_burete_confectionare foreign key (idBurete) references bureti(idBurete)
);
select * from confectionare
insert into confectionare(idMaterial,idBurete,procent) values
(1,1,50),
(1,2,30),
(2,3,40),
(2,1,20),
(5,2,10)
go
create or alter procedure Procedura
	@idMaterial int,
	@idBurete int,
	@procent int
as
begin
	if exists(select 1 from confectionare as c where c.idBurete = @idBurete and c.idMaterial = @idMaterial)
	begin
		update confectionare set procent = @procent where  confectionare.idBurete = @idBurete and confectionare.idMaterial = @idMaterial
		print 'update cu succes'
		return;
	end
	else
	begin
		insert into confectionare(idMaterial,idBurete,procent) values (@idMaterial,@idBurete,@procent)
		print 'insert cu success'
		return;
	end
end
go
exec Procedura @idMaterial = 5, @idBurete = 4, @procent = 30-- insert
exec Procedura @idMaterial = 5, @idBurete = 4, @procent = 50 -- update

-- de zis
exec Procedura @idMaterial = 6, @idBurete = 1, @procent = 70  -- (pt insert)
exec Procedura @idMaterial = 6, @idBurete = 1, @procent = 80 --( pt update)


select * from confectionare
go

create function Functie (@tip varchar(100))
returns table
as return (
	select top 3 with ties p.nume, p.website, COUNT(b.idBurete) as numarBureti from producatori as p inner join bureti as b on p.idProducator = b.idProducator
	inner join tipuri as t on t.nume = @tip
	group by p.nume, p.website having (Count(b.idTip) > 2) order by (COUNT (b.idBurete) ) desc 
)
go


insert into bureti(nume,descriere,an,lungime,latime,inaltime,pret,idProducator,idTip) values
('burete5', 'descriereBurete5', 2024, 122, 2, 1, 10.5, 1, 1)
select * from bureti
insert into bureti(nume,descriere,an,lungime,latime,inaltime,pret,idProducator,idTip) values
('burete6', 'descriereBurete6', 2024, 32, 20, 10, 10.5, 1, 1)

select * from dbo.Functie('nume1')