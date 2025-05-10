use SGBD_LAB_4
go

print 'T2: Start'
begin transaction
print 'Asteapta...'
waitfor delay '00:00:02'
print 'Seteaza...'
update MEDICAMENTE set Stoc = 100 where MedicamentId = 1
print 'Commit'
commit transaction