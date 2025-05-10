use SGBD_LAB_4
go
-- read uncommitted
-- sol : serializable
set transaction isolation level serializable
go
print 'T1: Start'
begin transaction
print 'Vezi mediacmente'
select * from MEDICAMENTE where MedicamentId between 1 and 10
print 'Asteptare...'
waitfor delay '00:00:10'
print 'Vezi medicamente'
select * from MEDICAMENTE where MedicamentId between 1 and 10
print 'Commit'
commit transaction