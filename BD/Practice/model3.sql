create database model3
go

use model3
go

create table Clienti(
	idClient int primary key identity(1,1),
	denumire varchar(100),
	codFiscal varchar(10)
);

create table AgentiDeVanzare(
	idVanzare int primary key identity(1,1),
	nume varchar(100),
	prenume varchar(100)
);

create table Produse(
	idProduse int primary key identity(1,1),
	denumire varchar(100),
	unitateDeMasura varchar(5)
);
create table Factura(
	idFactura int primary key identity(1,1),
	dataEmitere date,
	idClient int,
	idAgent int,
	constraint fk_client_factura foreign key (idClient) references Clienti(idClient) on delete cascade,
	constraint fk_agent_vanzari_factura foreign key (idAgent) references AgentiDeVanzare(idVanzare) on delete cascade
);
create table Lista(
	idFactura int,
	idProdus int,
	numarOrdine int,
	cantiate float,
	pret float,
	constraint pk_lista primary key (idFactura, numarOrdine),
	constraint fk_factura_lista foreign key (idFactura) references Factura(idFactura) on delete cascade,
	constraint fk_lista_produs foreign key (idProdus) references Produse(idProduse) on delete cascade
);
go
create procedure procedura
	@idProdus int,
	@idFactura int,
	@numarOrdine int,
	@pret float,
	@cantaite float
as begin
	declare @nouaordine int;
	select @nouaordine = Max(L.numarOrdine) from Lista as L;
	if exists (select 1 from Lista as L where L.idFactura = @idFactura and L.numarOrdine = @numarOrdine)
	begin
		insert into Lista(idFactura,idProdus,numarOrdine,cantiate,pret) values
		(@idFactura, @idProdus, @nouaordine,-@cantaite,@pret)
		return;
	end
	else
		begin
			insert into Lista(idFactura,idProdus,numarOrdine,cantiate,pret) values
		(@idFactura, @idProdus, @nouaordine,@cantaite,@pret)
		return;
		end
end
go

create view VW
as
	select C.denumire,F.dataEmitere,L.numarOrdine, SUM(L.pret) as suma from Factura as F inner join Clienti as C on F.idClient = C.idClient
	inner join Lista as L on L.idFactura = F.idFactura GROUP BY 
    C.denumire, 
    F.dataEmitere, 
    L.numarOrdine;
GO

create function Functie (@year int)
returns table
as
return
(select MONTH(F.dataEmitere) as Luna, A.nume, A.prenume, SUM(L.cantiate * L.pret) as suma from Factura as F 
inner join AgentiDeVanzare as A ON F.idAgent = A.idVanzare
inner join Lista as L on L.idFactura = F.idFactura
where YEAR(F.dataEmitere) = @year
group by MONTH(F.dataEmitere), A.nume, A.prenume order by  MONTH(F.dataEmitere), A.nume, A.prenume
)
go