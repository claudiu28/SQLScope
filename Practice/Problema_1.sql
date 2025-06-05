USE master
GO
IF(EXISTS(SELECT * FROM sys.databases WHERE name='Problema1'))
	DROP DATABASE Problema1;
GO
CREATE DATABASE Problema1;
GO
USE Problema1;
GO
CREATE TABLE Cofetarii
(
cod_cofetarie INT PRIMARY KEY IDENTITY,
nume_cofetarie VARCHAR(200),
adresa VARCHAR(200),
website VARCHAR(200)
);
CREATE TABLE Briose
(
cod_briosa INT PRIMARY KEY IDENTITY,
nume_briosa VARCHAR(200),
descriere VARCHAR(1000),
pret REAL,
cod_cofetarie INT FOREIGN KEY REFERENCES Cofetarii(cod_cofetarie)
ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Tari
(
cod_tara INT PRIMARY KEY IDENTITY,
nume_tara VARCHAR(200)
);
CREATE TABLE Clienti
(
cod_client INT PRIMARY KEY IDENTITY,
nume VARCHAR(200),
email VARCHAR(200),
data_nasterii DATE,
cod_tara INT FOREIGN KEY REFERENCES Tari(cod_tara) 
ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Note
(
cod_briosa INT FOREIGN KEY REFERENCES Briose(cod_briosa)
ON UPDATE CASCADE ON DELETE CASCADE,
cod_client INT FOREIGN KEY REFERENCES Clienti(cod_client)
ON UPDATE CASCADE ON DELETE CASCADE,
nota INT,
CONSTRAINT pk_Note PRIMARY KEY (cod_briosa, cod_client)
);
--Cofetarii
INSERT INTO Cofetarii(nume_cofetarie,adresa,website) VALUES
('Lemnul Verde','adresa Lemnul Verde','www.lemnulverde.ro');
INSERT INTO Cofetarii(nume_cofetarie,adresa,website) VALUES
('Carpati','adresa Carpati','www.carpati.ro');
INSERT INTO Cofetarii(nume_cofetarie,adresa,website) VALUES
('La Casa','adresa La Casa','www.lacasa.ro');
--Briose Lemnul Verde
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa1 Lemnul Verde','descriere briosa1',5,1);
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa2 Lemnul Verde','descriere briosa2',9,1);
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa3 Lemnul Verde','descriere briosa3',7,1);
--Briose Carpati
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa1 Carpati','descriere briosa1',4,2);
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa2 Carpati','descriere briosa2',8,2);
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa3 Carpati','descriere briosa3',10,2);
--Briose La Casa
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa1 La Casa','descriere briosa1',6,3);
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa2 La Casa','descriere briosa2',3,3);
INSERT INTO Briose(nume_briosa,descriere,pret,cod_cofetarie) VALUES
('briosa3 La Casa','descriere briosa3',7,3);
--Tari
INSERT INTO Tari (nume_tara) VALUES ('Romania');
INSERT INTO Tari (nume_tara) VALUES ('Ungaria');
INSERT INTO Tari (nume_tara) VALUES ('Spania');
--Clienti 
INSERT INTO Clienti (nume,email,data_nasterii,cod_tara) VALUES
('client1','client1@gmail.com','1991-02-12',1);
INSERT INTO Clienti (nume,email,data_nasterii,cod_tara) VALUES
('client2','client2@gmail.com','1972-12-02',2);
INSERT INTO Clienti (nume,email,data_nasterii,cod_tara) VALUES
('client3','client3@gmail.com','1982-10-10',3);
--Note
INSERT INTO Note (cod_briosa,cod_client,nota) VALUES (1,1,10);
INSERT INTO Note (cod_briosa,cod_client,nota) VALUES (1,2,7);
INSERT INTO Note (cod_briosa,cod_client,nota) VALUES (1,3,8);


select * from Briose;
select * from Note;
select * from Clienti;
select * from Tari;
select * from Cofetarii;

-- joins

select b.nume_briosa, c.nume_cofetarie from Briose as b inner join Cofetarii as c on c.cod_cofetarie = b.cod_cofetarie;

select c.nume, t.nume_tara from Clienti as c inner join Tari as t on t.cod_tara = c.cod_tara;

select c.nume_cofetarie, COUNT(b.cod_cofetarie) as numar_briose from Cofetarii as c inner join Briose as b on b.cod_cofetarie = c.cod_cofetarie group by c.nume_cofetarie;

select b.nume_briosa, n.nota from Briose as b inner join Note as n on n.cod_briosa = b.cod_briosa where n.nota > 7;

select c.nume, AVG(n.nota) from Clienti as c inner join Note as n on n.cod_client = c.cod_client group by c.nume; 

select b.nume_briosa, AVG(n.nota) from Briose as b inner join Note as n on n.cod_briosa = b.cod_briosa group by b.nume_briosa having AVG(n.nota) > 5;


select cf.nume_cofetarie from Cofetarii as cf inner join Briose as b on b.cod_cofetarie = cf.cod_cofetarie
inner join Note as n on n.cod_briosa = b.cod_briosa
inner join Clienti as c on c.cod_client = n.cod_client
inner join Tari as t on t.cod_tara = c.cod_tara group by cf.nume_cofetarie having COUNT(t.cod_tara) > 2;


select t.nume_tara from Tari as t inner join Clienti as c on c.cod_tara = t.cod_tara inner join Note as n on n.cod_client = c.cod_client group by t.nume_tara having AVG(n.nota) > 8;

select c.nume, b.pret from Clienti as c inner join Note as n on n.cod_client = c.cod_client
inner join Briose as b on b.cod_briosa = n.cod_briosa where n.nota < 6;

select c.nume from Clienti as c inner join Note as n on n.cod_client = c.cod_client 
inner join Briose as b on b.cod_briosa = n.cod_briosa
inner join Cofetarii as cf on cf.cod_cofetarie = b.cod_cofetarie where cf.nume_cofetarie like '%Lemnul%';

select b.nume_briosa, COUNT(distinct n.cod_client) from Briose as b left join Note as n on n.cod_briosa = b.cod_briosa group by b.nume_briosa;

select c.nume from Clienti as c inner join Note as n on n.cod_client = c.cod_client inner join Briose as b on b.cod_briosa = n.cod_briosa inner join Cofetarii as cf on cf.cod_cofetarie = b.cod_cofetarie
group by c.nume, cf.cod_cofetarie having COUNT(cf.cod_cofetarie) = 1;

select c.nume from Clienti as c inner join Note as n on n.cod_client = c.cod_client where n.nota >= 8 and n.nota <= 10;

select b.nume_briosa, COUNT(t.cod_tara) from Briose as b inner join Note as n on n.cod_briosa = b.cod_briosa inner join Clienti as ct on ct.cod_client = n.cod_client inner join Tari as t on t.cod_tara = ct.cod_tara
group by b.nume_briosa;

select top 3 b.nume_briosa, AVG(n.nota) as medie from Briose as b inner join Note as n on n.cod_briosa = b.cod_briosa group by b.nume_briosa order by medie desc;

select b.nume_briosa from Briose as b inner join Note as n on n.cod_briosa = b.cod_briosa inner join Clienti as c on n.cod_client = c.cod_client 
inner join Tari as t on t.cod_tara = c.cod_tara group by b.nume_briosa having COUNT(t.cod_tara) = 3;

select c.nume from Clienti as c inner join Note as n on n.cod_client = c.cod_client inner join Briose as b on b.cod_briosa = n.cod_briosa
inner join Cofetarii as cf on cf.cod_cofetarie = b.cod_cofetarie group by c.nume having COUNT(distinct cf.cod_cofetarie) = 1;

select c.nume_cofetarie, COUNT(b.cod_briosa) from Cofetarii as c inner join Briose as b on b.cod_cofetarie = c.cod_cofetarie group by c.nume_cofetarie;
