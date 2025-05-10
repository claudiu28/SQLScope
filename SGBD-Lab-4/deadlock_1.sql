use SGBD_LAB_4
go

set DEADLOCK_PRIORITY HIGH;
begin transaction
update MEDICAMENTE set Stoc = 200 where MedicamentId = 2;
waitfor delay '00:00:05'
update CATEGORIE set NumeCategorie = 'anti-raceala' where CategorieId = 1;
commit transaction

select * from MEDICAMENTE;
select * from CATEGORIE;