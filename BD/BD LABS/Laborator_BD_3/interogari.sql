USE LAB3_FARMACIE
GO


-- 5 interogări ce folosesc where
-- 3 interogări ce folosesc group by
-- 2 interogări ce folosesc distinct 
-- 2 interogări cu having
-- 7 interogări ce extrag informaţii din mai mult de 2 tabele
-- 2 interogări pe tabele alfate în relaţie m-n 

-- Interogare 1 
SELECT DISTINCT Meds.Nume AS NumeMedicament,
Meds.Descriere AS DescriereMedicament, MT.PretTotal,
Trz.DataTranzactie, Cump.Nume AS NumeCumparator,
Cump.Data_Nasterii 
FROM MEDICAMENTE Meds INNER JOIN MEDICAMENTE_TRANZACTII MT ON Meds.MedicamentId = MT.MedicamentId
INNER JOIN TRANZACTIE Trz ON MT.TranzactieId = Trz.TranzactieId
INNER JOIN CUMPARATORI Cump ON Cump.CumparatorId = Trz.CumparatorId WHERE  PretTotal > 30;

-- Interogare 2

SELECT Meds.Nume AS MedicamentNume,
Meds.Pret, Meds.Stoc,
FarmDet.Nume AS FarmacieNume,FarmDet.Locatie,
Furn.Nume AS FurnizoriNume
FROM MEDICAMENTE Meds
INNER JOIN FARMACIE_DETALII FarmDet ON FarmDet.FarmacieId = Meds.MedicamentId
INNER JOIN FURNIZORI_MEDICAMENTE ON FURNIZORI_MEDICAMENTE.MedicamentId = Meds.MedicamentId
INNER JOIN FURNIZORI Furn ON Furn.FurnizoriId = FURNIZORI_MEDICAMENTE.FurnizoriId WHERE Stoc > 100

-- Interogare 3

SELECT DISTINCT Meds.Nume,
MedsTranz.Cantitate, MedsTranz.PretTotal,
FarmDet.Nume FROM MEDICAMENTE Meds
INNER JOIN FARMACIE_DETALII FarmDet ON FarmDet.FarmacieId = Meds.MedicamentId
INNER JOIN MEDICAMENTE_TRANZACTII MedsTranz ON MedsTranz.MedicamentId = Meds.MedicamentId
INNER JOIN TRANZACTIE Trz ON Trz.TranzactieId = MedsTranz.TranzactieId WHERE MedsTranz.Cantitate < 3 and MedsTranz.PretTotal > 20

-- Interogare 4

SELECT Meds.Nume AS NumeMedicamente,
Meds.Descriere,
Categ.NumeCategorie AS NumeCategorie,
Furn.Nume AS NumeFurnizori
FROM MEDICAMENTE Meds
INNER JOIN FURNIZORI_MEDICAMENTE on FURNIZORI_MEDICAMENTE.MedicamentId = Meds.MedicamentId
INNER JOIN FURNIZORI Furn ON Furn.FurnizoriId = FURNIZORI_MEDICAMENTE.FurnizoriId
INNER JOIN MEDS_CATEGORIE ON MEDS_CATEGORIE.MedicamentId = Meds.MedicamentId
INNER JOIN CATEGORIE Categ ON Categ.CategorieId = MEDS_CATEGORIE.CategorieId WHERE Meds.Descriere LIKE '%mg%';


-- Interogare 5
SELECT Meds.Nume AS NumeMedicament, MT.PretTotal, Trz.DataTranzactie, Cump.Nume
FROM MEDICAMENTE Meds
LEFT OUTER JOIN MEDICAMENTE_TRANZACTII MT ON MT.MedicamentId = Meds.MedicamentId 
LEFT OUTER JOIN TRANZACTIE Trz ON Trz.TranzactieId = MT.TranzactieId
LEFT OUTER JOIN CUMPARATORI Cump ON Cump.CumparatorId = Trz.CumparatorId WHERE MT.PretTotal < 40 OR MT.PretTotal IS NULL;

-- Interogare 6

SELECT Meds.Nume, Meds.Stoc,
FARMACIE_DETALII.Locatie,
FARMACIE_DETALII.Nume AS FarmacieNume,
ANGAJATI.Nume AS Vanzator
FROM MEDICAMENTE Meds
INNER JOIN FARMACIE_DETALII ON FARMACIE_DETALII.FarmacieId = Meds.FarmacieId
INNER JOIN ANGAJATI ON ANGAJATI.FarmacieId  = FARMACIE_DETALII.FarmacieId WHERE ANGAJATI.Pozitie = 'Casier';

-- Interogare 7

SELECT Meds.Nume AS NumeMedicament,
Meds.Descriere AS DescriereMedicament,
CATEGORIE.NumeCategorie, MT.Cantitate,
Cump.Nume AS NumeCumparator, Varsta = DATEDIFF(YEAR, Cump.Data_Nasterii, GETDATE())
FROM MEDICAMENTE Meds INNER JOIN MEDICAMENTE_TRANZACTII MT ON Meds.MedicamentId = MT.MedicamentId
INNER JOIN TRANZACTIE Trz ON MT.TranzactieId = Trz.TranzactieId
INNER JOIN CUMPARATORI Cump ON Cump.CumparatorId = Trz.CumparatorId
INNER JOIN MEDS_CATEGORIE ON Meds.MedicamentId = MEDS_CATEGORIE.CategorieId
INNER JOIN CATEGORIE ON CATEGORIE.CategorieId = MEDS_CATEGORIE.CategorieId; 

-- Interogare 8
SELECT FarmacieId, SUM(STOC) AS STOC_MAXIM FROM MEDICAMENTE GROUP BY FarmacieId HAVING SUM(STOC) > 500;
-- Interogare 9
SELECT FarmacieId, Min(STOC) AS WORST_STOC FROM MEDICAMENTE GROUP BY FarmacieId HAVING MIN(STOC) = 100;
-- Interogare 10
SELECT Pret, COUNT(Pret) AS MEDS_EGALE FROM MEDICAMENTE GROUP BY Pret HAVING Pret < 50;
