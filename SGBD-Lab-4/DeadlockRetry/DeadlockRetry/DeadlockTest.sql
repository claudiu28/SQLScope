CREATE DATABASE DeadlockTest
GO

USE DeadlockTest
GO

CREATE TABLE FARMACIE_DETALII(
	FarmacieId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Locatie NVARCHAR(100)
);
GO


CREATE TABLE MEDICAMENTE(
	MedicamentId INT PRIMARY KEY IDENTITY(1,1),
	Nume VARCHAR(50),
	Descriere NVARCHAR (500),
	Pret FLOAT,
	Stoc INT,
	FarmacieId INT,
	FOREIGN KEY (FarmacieId) REFERENCES FARMACIE_DETALII(FarmacieId)
);
GO
CREATE TABLE CUMPARATORI(
	CumparatorId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Data_Nasterii DATE
);
GO

CREATE TABLE CATEGORIE(
	CategorieId INT PRIMARY KEY IDENTITY(1,1),
	NumeCategorie VARCHAR(100)
);
GO


CREATE TABLE MEDS_CATEGORIE(
	MedicamentId INT,
	CategorieId INT,
	PRIMARY KEY (MedicamentId, CategorieId),
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId),
	FOREIGN KEY (CategorieId) REFERENCES CATEGORIE(CategorieId)
); 
GO

CREATE TABLE ANGAJATI(
	AngajatId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Pozitie VARCHAR(100),
	Email NVARCHAR(200), CHECK (CHARINDEX('@', EMAIL) > 0),
	FarmacieId INT,
	FOREIGN KEY (FarmacieId) REFERENCES FARMACIE_DETALII(FarmacieId)
);
GO

CREATE TABLE TRANZACTIE(
	TranzactieId INT PRIMARY KEY IDENTITY(1,1),
	NumeMed NVARCHAR(50),
	Cantitate INT,
	DataTranzactie DATE,
	CumparatorId INT,
	FOREIGN KEY (CumparatorId) REFERENCES CUMPARATORI(CumparatorId)
);
GO

CREATE TABLE MEDICAMENTE_TRANZACTII(
	MedicamentId INT,
	TranzactieId INT,
	PretTotal DECIMAL(10,2),
	Cantitate INT, CHECK (Cantitate BETWEEN 1 AND 10),
	PRIMARY KEY (MedicamentId, TranzactieId),
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId),
	FOREIGN KEY (TranzactieId) REFERENCES Tranzactie(TranzactieId)
);
GO

CREATE TABLE FURNIZORI(
	FurnizoriId INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(50),
	Adresa NVARCHAR(100)
);
GO

CREATE TABLE FURNIZORI_MEDICAMENTE(
	FurnizoriId INT,
	MedicamentId INT,
	PRIMARY KEY (FurnizoriId, MedicamentId),
	FOREIGN KEY (FurnizoriId) REFERENCES FURNIZORI(FurnizoriId),
	FOREIGN KEY (MedicamentId) REFERENCES MEDICAMENTE(MedicamentId)
);
GO


CREATE TABLE LogActions (
    LogID INT IDENTITY PRIMARY KEY,
    ActionTime DATETIME DEFAULT GETDATE(),
    ActionType NVARCHAR(20),      
    Entity NVARCHAR(50),          
    Details NVARCHAR(MAX),         
    IsError BIT,                   
    ErrorMessage NVARCHAR(MAX)    
);
GO

SELECT * FROM CATEGORIE
INSERT INTO CATEGORIE(NumeCategorie) VALUES 
('Antibiotice'),
('Antiseptice'),
('Antifungice');
DBCC CHECKIDENT ('CATEGORIE', RESEED, 0);

SELECT * FROM MEDICAMENTE
SELECT  * FROM FARMACIE_DETALII

INSERT INTO FARMACIE_DETALII(Nume, Locatie) VALUES ('Farmacia Dona', 'Str. Mihai Viteazu, nr. 1')
INSERT INTO FARMACIE_DETALII(Nume, Locatie) VALUES ('Farmacia Catena', 'Str. Stefan cel Mare, nr. 2')
INSERT INTO FARMACIE_DETALII(Nume, Locatie) VALUES ('Farmacia Tei', 'Str. Unirii, nr. 3')
INSERT INTO FARMACIE_DETALII(Nume, Locatie) VALUES ('Farmacia HelpNet', 'Str. Victoriei, nr. 4')
INSERT INTO FARMACIE_DETALII(Nume, Locatie) VALUES ('Farmacia Sensiblu', 'Str. Decebal, nr. 5')


INSERT INTO MEDICAMENTE (Nume, Descriere, Pret, Stoc, FarmacieId) 
VALUES ('Panadol', 'Pastile pentru dureri de cap', 12.5, 120, 1),
       ('Ketonal', 'Analgezic puternic', 25.0, 80, 2),
       ('Dicarbocalm', 'Pentru probleme digestive', 18.9, 60, 3),
       ('No-Spa', 'Antispastic muscular', 14.3, 90, 4),
       ('Omez', 'Trateaz? aciditatea gastric?', 10.0, 110, 5);

INSERT INTO MEDICAMENTE (Nume, Descriere, Pret, Stoc, FarmacieId) 
VALUES ('Supradyn', 'Vitamine ?i minerale', 30.5, 75, 1),
       ('Tantum Verde', 'Spray pentru gât', 22.0, 50, 2),
       ('Strepsils', 'Pastile pentru dureri în gât', 17.5, 100, 3),
       ('ACC', 'Pentru tuse ?i expectora?ie', 20.8, 95, 4),
       ('Faringosept', 'Antiseptic oral', 11.2, 130, 5);

INSERT INTO MEDICAMENTE (Nume, Descriere, Pret, Stoc, FarmacieId) 
VALUES ('Vibrocil', 'Pentru nas înfundat', 19.9, 85, 1),
       ('Claritine', 'Antihistaminic pentru alergii', 23.5, 70, 2),
       ('Parasinus', 'Trateaz? simptomele r?celii', 16.4, 110, 3),
       ('Dafalgan', 'Paracetamol forte', 13.8, 60, 4),
       ('Theraflu', 'Plicuri pentru r?ceal?', 26.9, 90, 5);

INSERT INTO CUMPARATORI (Nume, Data_Nasterii) VALUES
(N'Ionescu Andrei', '1990-05-12'),
(N'Popescu Maria', '1985-08-23'),
(N'Vasilescu Ion', '2000-01-10');

INSERT INTO TRANZACTIE (NumeMed, Cantitate, DataTranzactie, CumparatorId) VALUES
(N'Paracetamol', 2, '2024-04-01', 1),
(N'Ibusinus', 1, '2024-04-02', 1),
(N'Nurofen', 3, '2024-04-03', 2),
(N'Vitamina C', 1, '2024-04-04', 3),
(N'Oscillococcinum', 2, '2024-04-05', 3);