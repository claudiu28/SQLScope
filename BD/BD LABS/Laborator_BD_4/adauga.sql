USE LAB4_FARMACIE;
GO 

INSERT INTO FARMACIE_DETALII (Nume, Locatie) VALUES 
('Catena', 'Strada Avram Iancu Nr.42'),
('Sensiblu', 'Bulevardul Unirii Nr.22'),
('Dona', N'Strada Lăpușneanu Nr.121'),
('Ropharma', N'Strada Martirilor Nr.10'),
('Help Net', N'Strada Mărășești Nr.11')
;

GO

INSERT INTO MEDICAMENTE (Nume,Descriere,Pret,Stoc,FarmacieId) VALUES
--MEDICAMENTE FARMACIA 1
(N'Paracetamol', N'Analgezic și antipiretic, 500mg', 12.50, 150, 1),
(N'Nurofen', N'Anti-inflamator pentru dureri și febră', 22.00, 100, 1),
(N'Doliprane', N'Antipiretic și analgezic, 500mg', 15.00, 100, 1),
--MEDICAMENTE FARMACIA 2
(N'Vitamina C', N'Supliment pentru imunitate, 1000mg', 15.75, 200, 2),
(N'Ibuprofen', N'Reduce inflamația și durerea, 400mg', 18.99, 180, 2),
(N'Paracetamol', N'Analgezic și antipiretic, 500mg', 12.50, 150, 2),
(N'Zentel', N'Medicament pentru paraziți intestinali, 400mg', 32.00, 50, 2),
(N'Nurofen', N'Anti-inflamator pentru dureri și febră', 22.00, 80, 2),
--MEDICAMENTE FARMCIA 3
(N'Antibiotic Amoxicilină', N'Tratament pentru infecții bacteriene, 250mg', 45.50, 80, 3),
(N'Panadol Extra', N'Combinație de paracetamol și cofeină', 27.30, 90, 3),
(N'Tylenol', N'Analgezic și antipiretic, 500mg', 20.00, 120, 3),
(N'Paracetamol', N'Analgezic și antipiretic, 500mg', 13.00, 100, 3),
--MEDICAMENTE FARMACIA 4
(N'Omez', N'Inhibitor al acidului gastric, 20mg', 10.00, 120, 4),
(N'Coldrex MaxGrip', N'Tratament pentru simptomele răcelii și gripei', 35.00, 50, 4),
(N'Dermazin', N'Crema antiseptică pentru arsuri, 1%', 22.50, 80, 4),
(N'Ibuprofen', N'Reduce inflamația și durerea, 400mg', 18.99, 100, 4),
--MEDICAMENTE FARMACIA 5
(N'Metoclopramid', N'Tratament pentru greață și vărsături, 10mg', 9.99, 150, 5),
(N'Zyrtec', N'Antialergic, tratament pentru rinită alergică', 25.60, 130, 5),
(N'Aspirină C', N'Anti-inflamator cu vitamina C', 19.50, 70, 5),
(N'Ibuprofen', N'Reduce inflamația și durerea, 400mg', 19.50, 90, 5);

GO

INSERT INTO ANGAJATI(Email,Nume,Pozitie,FarmacieId) VALUES 
(N'andrei.popescu@catena.ro', N'Andrei Popescu', N'Farmacist', 1),
(N'mihaela.ionescu@catena.ro', N'Mihaela Ionescu', N'Asistent Farmacist', 1),
(N'george.marinescu@sensiblu.ro', N'George Marinescu', N'Farmacist', 2),
(N'elena.vasilescu@sensiblu.ro', N'Elena Vasilescu', N'Casier', 2),
(N'cristina.stoica@dona.ro', N'Cristina Stoica', N'Farmacist', 3),
(N'florin.munteanu@dona.ro', N'Florin Munteanu', N'Asistent Farmacist', 3),
(N'gabriela.neagu@ropharma.ro', N'Gabriela Neagu', N'Farmacist', 4),
(N'valentin.dragomir@ropharma.ro', N'Valentin Dragomir', N'Casier', 4),
(N'ioana.iliescu@helpnet.ro', N'Ioana Iliescu', N'Farmacist', 5),
(N'adrian.badea@helpnet.ro', N'Adrian Badea', N'Asistent Farmacist', 5);

GO


INSERT INTO CUMPARATORI(Nume,Data_Nasterii) VALUES 
(N'Ion Popescu', '1985-03-14'),
(N'Maria Ionescu', '1990-07-22'),
(N'Andrei Vasilescu', '1978-09-10'),
(N'Elena Georgescu', '1982-11-05'),
(N'Cristian Dumitrescu', '1995-01-17'),
(N'Mihaela Dragomir', '1989-02-28'),
(N'Valentin Stanciu', '1972-05-12'),
(N'Gabriela Neagu', '1986-12-19'),
(N'Stefan Preda', '1992-08-07'),
(N'Diana Stoica', '1983-10-25'),
(N'Adrian Munteanu', '1976-04-06'),
(N'Laura Badea', '1991-06-13'),
(N'Mihai Pavel', '1987-09-29'),
(N'Cristina Marin', '1993-11-30'),
(N'Dragos Rusu', '1980-12-03'),
(N'Ioana Popa', '1988-07-20'),
(N'Florin Grigorescu', '1984-03-09'),
(N'Simona Constantinescu', '1996-05-15'),
(N'Claudiu Barbu', '1974-10-02'),
(N'Alina Oprea', '1981-01-21');

GO

INSERT INTO TRANZACTIE(NumeMed,Cantitate,DataTranzactie,CumparatorId) VALUES
(N'Paracetamol', 2, '2024-01-10', 1),
(N'Paracetamol', 2, '2024-02-10', 1),
(N'Nurofen', 1, '2024-01-11', 2),
(N'Nurofen', 5, '2024-02-11', 2),
(N'Vitamina C', 5, '2024-01-12', 3),
(N'Vitamina C', 3, '2024-02-12', 3),
(N'Ibuprofen', 3, '2024-01-13', 4),
(N'Ibuprofen', 2, '2024-02-13', 4),
(N'Omez', 2, '2024-01-14', 5),
(N'Zyrtec', 1, '2024-01-15', 6),
(N'Zyrtec', 9, '2024-02-14', 6),
(N'Aspirină C', 4, '2024-01-16', 7),
(N'Aspirină C', 4, '2024-02-15', 7),
(N'Coldrex MaxGrip', 2, '2024-01-17', 8),
(N'Panadol Extra', 3, '2024-01-18', 9),
(N'Panadol Extra', 2, '2024-02-16', 9),
(N'Doliprane', 2, '2024-01-19', 10),
(N'Antibiotic Amoxicilină', 1, '2024-01-20', 11),
(N'Antibiotic Amoxicilină', 2, '2024-02-17', 11),
(N'Faringosept', 5, '2024-01-21', 12),
(N'Metoclopramid', 2, '2024-01-22', 13),
(N'Tylenol', 4, '2024-01-23', 14),
(N'Tylenol', 1, '2024-02-18', 14),
(N'Zentel', 1, '2024-01-24', 15),
(N'Ketonal', 3, '2024-01-25', 16),
(N'Claritine', 1, '2024-01-26', 17),
(N'Magne B6', 2, '2024-01-27', 18),
(N'Diclofenac', 3, '2024-01-28', 19),
(N'Oscillococcinum', 2, '2024-01-29', 20),
(N'Oscillococcinum', 3, '2024-02-19', 20);



INSERT INTO FURNIZORI(Nume,Adresa) VALUES
(N'Farmex', N'Strada Dorobanți Nr.23, București'),
(N'Terapia', N'Calea Victoriei Nr.45, Cluj-Napoca'),
(N'Sanofi', N'Strada Aviatorilor Nr.10, Timișoara'),
(N'Biofarm', N'Strada Mărășești Nr.12, Iași'),
(N'Pfizer', N'Bulevardul Unirii Nr.30, Constanța'),
(N'Antibiotice', N'Strada Independenței Nr.16, Craiova');

INSERT INTO CATEGORIE(NumeCategorie) VALUES
(N'Analgezice'),
(N'Antibiotice'),
(N'Antiinflamatoare'),
(N'Antipiretice'),
(N'Antialergice'),
(N'Vitamins and Supplements'),
(N'Antivirale'),
(N'Antifungice'),
(N'Antidiabetice'),
(N'Hipertensiune');

INSERT INTO MEDS_CATEGORIE(CategorieId,MedicamentId) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 9),
(3, 5),
(3, 2),
(4, 1),
(4, 3),
(4, 11),
(5, 18),
(6, 4),
(7, 14),
(8, 15);

INSERT INTO FURNIZORI_MEDICAMENTE(FurnizoriId,MedicamentId) VALUES 
(1,1),
(1,2),
(1,3),
(1,4),
(2,6),
(2,8),
(2,9),
(3,5),
(3,10),
(3,7),
(4,11),
(4,12),
(4,13),
(4,14),
(5,20),
(5,19),
(5,16),
(6,17),
(6,15),
(6,18);



INSERT INTO MEDICAMENTE_TRANZACTII(MedicamentId,TranzactieId,Cantitate,PretTotal) 
SELECT Med.MedicamentId, Tranz.TranzactieId, Tranz.Cantitate, (Med.Pret * Tranz.Cantitate) 
FROM MEDICAMENTE Med
INNER JOIN TRANZACTIE Tranz ON Med.Nume = Tranz.NumeMed;
DBCC CHECKIDENT ('Furnizori', RESEED, 0);
GO