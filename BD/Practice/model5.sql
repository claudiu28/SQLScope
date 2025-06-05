create database model5
go

use model5
go


create table Locatii(
	idLocatie int primary key identity(1,1),
	strada varchar(100) not null,
	numar int not null,
	codPostal varchar(10)
);

create table Magazin(
	idMagazin int primary key identity(1,1),
	denumire varchar(100) not null,
	an int not null,
	locatieId int not null,
	constraint fk_locatie_magazin foreign key (locatieId) references Locatii(idLocatie) on delete cascade
);

create table Client(
	idClient int primary key identity(1,1),
	nume varchar(100) not null,
	prenume varchar(100) not null,
	gen varchar(100), check (gen = 'masculin' or gen = 'feminin'),
	dataNastere date not null
)

create table ProduseFavorite(
	idProdus int primary key identity(1,1),
	denumire varchar(100) not null,
	pret float not null,
	reducere int not null,
	check(reducere <= 100),
	idClient int not null,
	constraint fk_produse_client foreign key (idClient) references Client(idClient) on delete cascade
);

create table achizitionare(
	idMagazin int not null,
	idClient int not null,
	constraint pk_magazin_client primary key(idClient,idMagazin),
	constraint fk_achizitionare_client foreign key (idClient) references Client(idClient) on delete cascade,
	constraint fk_achizionare_magazin foreign key (idMagazin) references Magazin(idMagazin) on delete cascade,
	dataCump date not null,
	pret float not null,
);
go

create procedure Procedura 
	@idClient int,
	@idMagazin int,
	@data date,
	@pret float
as
begin
	if exists(select 1 from achizitionare as a where a.idClient = @idClient and a.idMagazin = @idMagazin)
	begin
		update achizitionare set dataCump = @data, pret = @pret
		where achizitionare.idClient = @idClient and achizitionare.idMagazin = @idMagazin
		print 'succes update'
		return;
	end
	else
	begin
		insert into achizitionare(idClient,idMagazin,dataCump,pret) values(@idClient,@idMagazin,@data,@pret)
		print 'success insert'
		return;
	end
end
go

create view ViewFav 
as select C.nume from Client as C 
inner join ProduseFavorite as a on a.idClient = C.idClient
group by C.nume having COUNT(a.idClient) <= 3

