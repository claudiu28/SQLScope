-- Farmacie Laborator 1

CREATE DATABASE FARMACIE;
go

USE FARMACIE;
go

CREATE TABLE FARMACIE_DETALII(
	FarmacieId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Locatie NVARCHAR(100)
);

CREATE TABLE MEDICAMENTE(
	MedicamentId INT PRIMARY KEY IDENTITY(1,1),
	Nume VARCHAR(50),
	Descriere NVARCHAR (500),
	Pret FLOAT,
	Stoc INT,
	FarmacieId INT,
	FOREIGN KEY (FarmacieId) REFERENCES FARMACIE_DETALII(FarmacieId)
);


CREATE TABLE CUMPARATORI(
	CumparatorId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Varsta INT,
	MedicamentId INT,
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId)
)

CREATE TABLE CATEGORIE(
	CategorieId INT PRIMARY KEY IDENTITY(1,1),
	NumeCategorie VARCHAR(100)
);


CREATE TABLE MEDS_CATEGORIE(
	MedicamentId INT,
	CategorieId INT,
	PRIMARY KEY (MedicamentId, CategorieId),
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId),
	FOREIGN KEY (CategorieId) REFERENCES CATEGORIE(CategorieId)
); 


CREATE TABLE ANGAJATI(
	AngajatId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Pozitie VARCHAR(100),
	FarmacieId INT,
	FOREIGN KEY (FarmacieId) REFERENCES FARMACIE_DETALII(FarmacieId)
);

CREATE TABLE TRANZACTIE(
	TranzactieId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Cantitate INT,
	DataTranzactie DATE
);

CREATE TABLE MEDICAMENTE_TRANZACTII(
	MedicamentId INT,
	TranzactieId INT,
	Pret FLOAT,
	PRIMARY KEY (MedicamentId, TranzactieId),
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId),
	FOREIGN KEY (TranzactieId) REFERENCES Tranzactie(TranzactieId)

);

CREATE TABLE FURNIZORI(
	FurnizoriId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Adresa VARCHAR(100)
);

CREATE TABLE FURNIZORI_MEDICAMENTE(
	FurnizoriId INT,
	MedicamentId INT,
	PRIMARY KEY (FurnizoriId, MedicamentId),
	FOREIGN KEY (FurnizoriId) REFERENCES FURNIZORI(FurnizoriId),
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId)
);


ALTER TABLE CUMPARATORI
DROP COLUMN Varsta

ALTER TABLE CUMPARATORI
ADD Data_Nasterii DATE

ALTER TABLE MEDICAMENTE_TRANZACTII
ADD Cantitate INT, CHECK (Cantitate BETWEEN 1 AND 10)

ALTER TABLE ANGAJATI
ADD Email NVARCHAR(200), CHECK (CHARINDEX('@', EMAIL) > 0)

ALTER TABLE CUMPARATORI
DROP FK__CUMPARATO__Medic__3C69FB99;
// MUTA KEYUL DIN CUMAPRATORI IN TRANZACTIE UN CUMAPRATOR CU MAI MULTE TERANZACTII 
ALTER TABLE CUMPARATORI
DROP COLUMN MedicamentId; 

ALTER TABLE CUMPARATORI
ADD TranzactieId INT; 

ALTER TABLE CUMPARATORI
ADD CONSTRAINT FK_Cumparatori_Tranzactie FOREIGN KEY (TranzactieId) REFERENCES Tranzactie(TranzactieId);