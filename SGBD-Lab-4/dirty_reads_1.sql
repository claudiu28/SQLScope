use SGBD_LAB_4
go

-- T1 : update + delay _ rollback

PRINT 'T1: Start';

BEGIN TRANSACTION;

PRINT 'T1:  Stoc = 100';
UPDATE MEDICAMENTE SET Stoc = 80 WHERE MedicamentId = 1;

PRINT 'T1: Wait 10 secunde...';
WAITFOR DELAY '00:00:10';

PRINT 'T1: ROLLBACK';
ROLLBACK;

PRINT 'T1: Final Value';
SELECT * FROM MEDICAMENTE WHERE MedicamentId = 1;