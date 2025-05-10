use SGBD_LAB_4
go
print 'T2: Start'
begin transaction
print 'Asteptare'
waitfor delay '00:00:03'
print 'Inserare in medicamente'
insert into MEDICAMENTE(Nume, Descriere, Pret, Stoc, FarmacieId) values ('Paracetamol', 'Ceva Med', 25.99, 50, 1);
print 'Commit'
commit transaction;
